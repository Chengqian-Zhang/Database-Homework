-- 5. 构造一个定时往originData里增加数据的模拟器
-- 5(1). 首先我们构造一个向originData中存数据的存储过程

DROP PROCEDURE IF EXISTS insertOriginData;

CREATE PROCEDURE insertOriginData()
BEGIN
    -- 生成随机数的最大值
    DECLARE max_random_val INT;
    SET max_random_val = 100;
    INSERT INTO originData ( value ) VALUES(
        FLOOR(RAND() * max_random_val + 1)
    );
END;

-- 5(2). 其次我们构造一个按时调用上述存储过程的事件

-- 两次事件间隔的秒数
SET @no_seconds_between_events = 1;

-- 事件执行的时间
SET @no_seconds_event_runs = 100;


DROP EVENT IF EXISTS insertOriginDataEvent;

CREATE EVENT insertOriginDataEvent 
ON SCHEDULE EVERY @no_seconds_between_events SECOND 
STARTS CURRENT_TIMESTAMP + interval 1 second
ENDS CURRENT_TIMESTAMP + interval @no_seconds_event_runs second
ON COMPLETION PRESERVE
DO 
BEGIN
CALL insertOriginData();
END;

-- 5(3)聚合函数可能用到的存储过程

DROP PROCEDURE IF EXISTS agg;

CREATE PROCEDURE agg(newid INT)
BEGIN
    DECLARE newsum INT ;
    SELECT newsum=sum(value) from sum_slidingWin;
    INSERT INTO aggResult(id,sumRes,maxRes)VALUES(newid,newsum,newsum);
END;

-- 6. 定义一个触发器在每次插入originData的时候更新
-- max_slidingWin表

DROP TRIGGER IF EXISTS insertMaxSlidingWin;

CREATE TRIGGER insertMaxSlidingWin
AFTER INSERT ON sum_slidingWin
FOR EACH ROW
BEGIN
    -- 设置N的大小
    DECLARE N INT;
    SET N = 10;
    DELETE FROM max_slidingWin WHERE 
    max_slidingWin.value <= NEW.value;
    DELETE FROM max_slidingWin WHERE
    max_slidingWin.id <= NEW.id - N;
    INSERT INTO max_slidingWin(id, value) 
    VALUES(NEW.id, NEW.value);
END;

-- sum_slidingWin表

DROP TRIGGER IF EXISTS insertSumSlidingWin;

CREATE TRIGGER insertSumSlidingWin
AFTER INSERT ON originData
FOR EACH ROW
BEGIN
    -- 设置N的大小
    DECLARE N INT;
    SET N = 10;
    DELETE FROM sum_slidingWin WHERE
    sum_slidingWin.id <= NEW.id - N;
    INSERT INTO sum_slidingWin(id, value) 
    VALUES(NEW.id, NEW.value );
END;


-- aggResult表

DROP TRIGGER IF EXISTS updateResult;

CREATE TRIGGER updateResult
AFTER INSERT ON max_slidingWin
FOR EACH ROW
BEGIN
    -- INSERT INTO aggResult(SELECT sum_slidingWin.id, sum_slidingWin.value,max_slidingWin.value
    --                     FROM sum_slidingWin inner join max_slidingWin
    --                     ON sum_slidingWin.id=max_slidingWin.id
    --                     );
    -- CALL agg(NEW.id);
END;

