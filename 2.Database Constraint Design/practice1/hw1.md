# 实习二 数据库约束设计

成员：杨仕博 张钧天 马千里 张成谦 

```python
%load_ext sql
```


```python
import pymysql 
pymysql.install_as_MySQLdb()
%sql mysql://stu2100013111:stu2100013111@162.105.146.37:43306
```


```python
%sql use stu2100013111;
```
## 练习一 约束设计

给定员工表和部门表两个关系表，完成主码、外码、取值限制、模式匹配和表间关系等约束设计。

我们创建两个关系表，添加相应约束和简单样例，同时展示运行结果。

首先创建员工表和部门表：



```sql
%%sql

SET @@foreign_key_checks=0;
DROP TABLE IF EXISTS employee_tb;
CREATE TABLE employee_tb
(
    eno BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ename VARCHAR(40),
    dno BIGINT NOT NULL,
    salary BIGINT,
    level TINYINT,
    email VARCHAR(40) NOT NULL,
    #正则表达式匹配邮箱格式
    CHECK(regexp_like(email, '^[a-z0-9]+[a-z0-9._-]+@[a-z0-9.-]+\\.[a-z]{2,4}$')),
    #限定level取值以及与salary的对应关系
    CHECK(level IN (1,2,3,4,5)),
    CHECK(
         ((salary BETWEEN 1000 AND 2000) AND (level=1))
         OR
         ((salary BETWEEN 2001 AND 3000) AND (level=2))
         OR
         ((salary BETWEEN 3001 AND 4000) AND (level=3))
         OR
         ((salary BETWEEN 4001 AND 5000) AND (level=4))
         OR
         ((salary>5000) AND (level=5))
         )
);
SET @@foreign_key_checks=1;

SET @@foreign_key_checks=0;
DROP TABLE IF EXISTS department_tb;
CREATE TABLE department_tb
(
    dno BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dname VARCHAR(50) NOT NULL,
    manager BIGINT NOT NULL,
    budget BIGINT NOT NULL,
    CHECK(dname IN ('销售部', '财务部', '人事部'))
);
SET @@foreign_key_checks=1;
```

     * mysql://stu2100013111:***@162.105.146.37:43306
    0 rows affected.
    0 rows affected.
    0 rows affected.
    0 rows affected.
    0 rows affected.
    0 rows affected.
    0 rows affected.
    0 rows affected.

    []




插入数据作为例子：


```sql
%%sql

INSERT INTO employee_tb (
    ename,
    dno,
    salary,
    level,
    email
) VALUES (
    'abc', 
    1, 
    1500,
    1,
    '2020@ee.com'
);

INSERT INTO department_tb (
    dname,
    manager,
    budget
) VALUES (
    '销售部', 
    1, 
    3000
);
```

     * mysql://stu2100013111:***@162.105.146.37:43306
    1 rows affected.
    1 rows affected.

    []




定义外码约束：


```sql
%%sql

ALTER TABLE employee_tb
ADD CONSTRAINT employee_manager FOREIGN KEY(dno) REFERENCES department_tb(dno);
ALTER TABLE department_tb
ADD CONSTRAINT manager_employee FOREIGN KEY(manager) REFERENCES employee_tb(eno);
```

     * mysql://stu2100013111:***@162.105.146.37:43306
    1 rows affected.
    1 rows affected.

    []





定义触发器来实现员工工资总和与部门预算的比较：



```sql
%%sql

CREATE TRIGGER budget_check_trigger
BEFORE INSERT ON employee_tb
FOR EACH ROW
BEGIN
  DECLARE total_salary INT;
  DECLARE department_budget INT;
  SELECT SUM(salary) INTO total_salary FROM employee_tb WHERE dno = NEW.dno;  -- 计算该部门所有员工的salary总和
  SELECT budget INTO department_budget FROM department_tb WHERE dno = NEW.dno;  -- 获取该部门的budget
  IF total_salary + NEW.salary > department_budget THEN  -- 如果总工资超过预算，则阻止插入操作
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The total salary of employees in this department exceeds the budget.';
  END IF;
END;
```

     * mysql://stu2100013111:***@162.105.146.37:43306
    0 rows affected.

    []




当员工工资总和大于部门预算的时候，报错：



```sql
%%sql

INSERT INTO employee_tb (
    ename,
    dno,
    salary,
    level,
    email
) VALUES (
    'ab', 
    1, 
    1600,
    1,
    '2022@ee.com'
);
```

     * mysql://stu2100013111:***@162.105.146.37:43306
    (pymysql.err.OperationalError) (1644, 'The total salary of employees in this department exceeds the budget.')
    [SQL: INSERT INTO employee_tb (
        ename,
        dno,
        salary,
        level,
        email
    ) VALUES (
        'ab', 
        1, 
        1600,
        1,
        '2022@ee.com'
    );]
    (Background on this error at: https://sqlalche.me/e/14/e3q8)

