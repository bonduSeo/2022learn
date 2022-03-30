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


/* 함수사용 (left right mid) ____*/
SELECT LEFT(birth_date, 4) FROM employees;

SELECT * FROM employees
WHERE LEFT(birth_date, 4) = '1952';
-- like % 로 해도 되네

SELECT * FROM employees
WHERE birth_date LIKE '____-09-__';
-- like 랑 같이쓸수있는거중에 언더바_ 가 있다. 

SELECT * FROM employees
WHERE LEFT(birth_date, 4) >= '1960';
-- like % 로 해도 되네

SELECT birth_date, RIGHT(birth_date, 2), MID(birth_date, 6,2)
FROM employees;


-- -------
SELECT * FROM employees
WHERE emp_no = 500000;

UPDATE employees
SET gender = 'F'
, hire_date = '2021-03-29'
, FIRST_name = 'Jindong'
WHERE emp_no = 500000;

SELECT hire_date, LEFT(hire_date, 4)
FROM employees;

DELETE FROM employees
WHERE LEFT(hire_date,4) > '2020';

SELECT *,  LEFT(hire_date,4) FROM employees
WHERE LEFT(hire_date,4) > '1999';

SELECT 1+1 AS 'dd_dd';
-- 별칭. '' `` 안써도됨


SELECT 1+1 FROM DUAL;

SELECT COUNT(*) FROM employees;


-- 서브쿼리 189쪽 SubQuery

-- emp_no = 499613  근로자와 생년월일이 같은 사람 찾기
SELECT * FROM employees
WHERE birth_date = '1953-06-09';

SELECT birth_date FROM employees
WHERE emp_no = 499613;

SELECT * FROM employees
WHERE birth_date = (SELECT birth_date FROM employees WHERE emp_no = 499613);
-- 이것이 서브쿼리문

SELECT * FROM employees
WHERE gender = (SELECT gender FROM employees WHERE emp_no = 499619);


SELECT * FROM employees
WHERE gender = (SELECT gender FROM employees WHERE emp_no = 499619)
AND emp_no != 499619;

-- -----
SELECT birth_date FROM employees WHERE gender = 'F';

SELECT * FROM employees
WHERE birth_date = (SELECT birth_date FROM employees WHERE gender = 'F');
-- 서브쿼리의 결과가  1row 이상 나오기때문에 에러뜸
-- 서브쿼리를 쓸때 = 을쓸라면 스칼라값(행, 열이 1개인 값)이 와야함

SELECT * FROM employees
WHERE birth_date = any (SELECT birth_date FROM employees WHERE gender = 'F');
-- =any 는 in 과 같음
SELECT * FROM employees
WHERE birth_date IN (SELECT birth_date FROM employees WHERE gender = 'F');

SELECT * FROM employees
WHERE birth_date = all (SELECT birth_date FROM employees WHERE gender = 'F');

--

SELECT * FROM salaries
WHERE emp_no = 10010;

SELECT * FROM salaries
WHERE salary >= SOME (SELECT salary FROM salaries WHERE emp_no = 10010);
-- some 과 any 는 동일
SELECT * FROM salaries
WHERE salary >= all (SELECT salary FROM salaries WHERE emp_no = 10010);


-- 오름차순 ASC 디폴트
-- 내림차순 DESC
SELECT * FROM salaries
ORDER BY emp_no desc;

SELECT * FROM salaries
WHERE emp_no IN (499988, 499987, 499986)
ORDER BY emp_no DESC, from_date;

SELECT * FROM salaries
WHERE emp_no IN (499988, 499987, 499986)
ORDER BY emp_no DESC, salary DESC;

SELECT salary, emp_no FROM salaries
WHERE emp_no IN (499988, 499987, 499986)
ORDER BY emp_no DESC, salary DESC;
-- 데이터베이스에 데이터순서는 중요하지않다. 이렇게 정렬시켜서 볼수있기때문에


-- 젊은사람이 위로, 태어난날짜가 같다면 여자가 위로
SELECT * FROM employees
ORDER BY birth_date DESC, gender DESC;

DESC employees; 
-- 테이블 정보 보기



