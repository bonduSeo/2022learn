SELECT * FROM employees 
WHERE emp_no BETWEEN 10010 AND 10020;

SELECT * FROM employees 
WHERE emp_no >=10010 AND emp_no <= 10020;


SELECT * FROM departments
WHERE dept_no = 'd001' 
	OR dept_no = 'd003'
	OR dept_no = 'd005';
	

SELECT * FROM departments
WHERE dept_no IN ('d001', 'd003', 'd005');

SELECT * FROM employees
WHERE emp_no % 2 = 0;
-- % :mod 2를 나눠서 나머지값: 그것이 0이거나 1인 친구들. 즉 홀수, 짝수

SELECT emp_no /2, emp_no %2 FROM employees;

-- 위에 d002 같은 문자열로 할려면 정수로 컨버팅하는 작업이 필요함