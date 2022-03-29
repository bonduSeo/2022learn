USE `employees`;
-- 홑따옴표가 아니고 그레이브 엑센트

SELECT * FROM departments;

INSERT INTO  departments
(dept_no, dept_name)
VALUES 
('d010', 'Business');


SELECT * FROM employees;

INSERT INTO employees
(emp_no, birth_date, first_name, last_name, gender, hire_date)
VALUES 
(500000, '1999-10-10', 'Gildong', 'Hong', 'M', '2022-03-29');

SELECT * FROM employees
WHERE emp_no >= 499900;

DELETE FROM employees
WHERE emp_no = 500000;


SELECT * FROM employees
WHERE gender = 'F' 
AND last_name LIKE '%ch%';

SELECT LEFT(birth_date, 4) FROM employees;

SELECT * FROM employees
WHERE LEFT(birth_date, 4) = '1952';
-- like % 로 해도 되네

SELECT * FROM employees
WHERE birth_date LIKE '____-09-__';
-- like 랑 같이쓸수있는거중에 언더바_ 가 있다. 