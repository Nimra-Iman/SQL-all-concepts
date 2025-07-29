create database demo;
CREATE TABLE emp (
    e_id INT AUTO_INCREMENT,
    e_name VARCHAR(100) NOT NULL,
    dept VARCHAR(50),
    salary int,
    PRIMARY KEY (e_id)
);
INSERT INTO emp (e_id, e_name, dept, salary) VALUES
    (1, 'nimra', "HR", 1000),
	(2, 'kinza', "HR", 25000),
	(3, 'shiza', "IT", 5000),
	(4, 'nimra', "MRKT", 3000),
	(5, 'asad', "MRKT", 15000)
;

-- slect distinct
SELECT DISTINCT DEPT FROM EMP;

-- WHERE (FOR CONDITION)
SELECT E_NAME FROM EMP WHERE DEPT = "HR";

-- NOT
SELECT E_NAME FROM EMP WHERE NOT DEPT = "HR";

