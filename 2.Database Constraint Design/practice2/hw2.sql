use homework;

-- 1. 初始化originData表
SET @@foreign_key_checks=0;
DROP TABLE IF EXISTS originData;

CREATE TABLE originData
(
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    value BIGINT NOT NULL
);

SET @@foreign_key_checks=1;

-- 2. 初始化max_slidingWin表
SET @@foreign_key_checks=0;
DROP TABLE IF EXISTS max_slidingWin;

CREATE TABLE max_slidingWin
(
    id BIGINT NOT NULL PRIMARY KEY,
    value BIGINT NOT NULL,
    constraint max_fk_max_sliding foreign key(id) references originData(id)
);

SET @@foreign_key_checks=1;

-- 3. 初始化sum_slidingWin表

-- 4. 初始化aggResult表

-- 5. 构造一个定时往originData里增加数据的模拟器
-- 5(1). 首先我们构造一个向originData中存数据的存储过程

DROP PROCEDURE IF EXISTS insertOriginData;

DELIMITER $$
CREATE PROCEDURE insertOriginData()
    BEGIN
		-- 生成随机数的最大值
		SET @max_random_val = 100;
        INSERT INTO originData ( value ) VALUES(
            FLOOR(RAND() * @max_random_val + 1)
        );
    END $$
DELIMITER ;

-- 5(2). 其次我们构造一个按时调用上述存储过程的事件

-- 两次事件间隔的秒数
SET @no_seconds_between_events = 1;

-- 事件执行的时间
SET @no_seconds_event_runs = 100;

DROP EVENT IF EXISTS insertOriginDataEvent;

DELIMITER $$
CREATE EVENT insertOriginDataEvent 
ON SCHEDULE EVERY @no_seconds_between_events SECOND 
STARTS CURRENT_TIMESTAMP + interval 1 second
ENDS CURRENT_TIMESTAMP + interval @no_seconds_event_runs second
ON COMPLETION PRESERVE
DO 
BEGIN
CALL insertOriginData();
END $$
DELIMITER ;

-- 6. 定义一个触发器在每次插入originData的时候更新
-- max_slidingWin表

DROP TRIGGER IF EXISTS insertMaxSlidingWin;

DELIMITER $$
CREATE TRIGGER insertMaxSlidingWin
AFTER INSERT ON originData
FOR EACH ROW
BEGIN
    -- 设置N的大小
    SET @N = 10;
    DELETE FROM max_slidingWin WHERE 
    max_slidingWin.value <= NEW.value;
    DELETE FROM max_slidingWin WHERE
    max_slidingWin.id <= NEW.id - @N;
    INSERT INTO max_slidingWin(id, value) 
    VALUES(NEW.id, NEW.value);
END $$
DELIMITER ;