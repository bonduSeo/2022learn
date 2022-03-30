-- day 3

-- dept_emp 테이블에서 dept_no 종류가 몇개가 있는지?
SELECT DISTINCT dept_no FROM dept_emp;
-- 중복된것 제거

-- 사원의 직무가 무엇이 있는지 selct 해주시오.
SELECT * FROM titles;

SELECT DISTINCT title FROM titles;


-- limit? /// limit ?, ?
SELECT * FROM employees
LIMIT 20;

SELECT * FROM employees
LIMIT 0, 10;

SELECT * FROM employees
LIMIT 12, 10;

-- 가장 많은 연봉을 받은 금액 3개만나오게

SELECT * from salaries;

SELECT * FROM salaries
ORDER BY salary DESC
LIMIT 3;

-- 위 결과에서 5- 10위까지만 나오도록

SELECT * FROM salaries
ORDER BY salary DESC
LIMIT 4, 6;

-- 테이블을 복사하는 create table ... select
CREATE TABLE departments_temp
(SELECT * FROM departments);
-- 비교해보면 틀과 데이터만 복사됨. PK라던지 그런것들은 복사안됨.
-- 필요하다면 지정한 일부열만 복사할수도 있다. 

CREATE TABLE departments_temp2 AS
SELECT * FROM departments;


-- 테이블 스키마 복사 (레코드x)
CREATE TABLE departments_temp3
LIKE departments;

INSERT INTO departments_temp3
SELECT * FROM departments;
-- 데이터 넣기
-- 제약조건까지 복사하라면 이렇게( 그럴일은 잘없긴함)
-- DROP TABLE 

-- 그룹 함수 min, max, sum,m avg, count (197p)
SELECT *, MIN(salary) FROM salaries;
-- group by 를 사용 안했을때는 전체에서 값을 가져온다. 
SELECT MIN(salary), MAX(salary), SUM(salary), AVG(salary), COUNT(emp_no)
, SUM(salary)/COUNT(*) FROM salaries;

SELECT emp_no, MIN(salary), MAX(salary), SUM(salary), AVG(salary), COUNT(*), from_date
FROM salaries
GROUP BY emp_no;
-- 위에 from_date 는 의미없음. 오라클에선 에러날수도. 저런건 안하는것이.

/*부서별 사원 수 */
SELECT title, COUNT(*) FROM titles
GROUP BY title;
-- 이건 직종별??

/* 부서별 사원수, 부서별 사원수가 20,000 명 이상인 부서만 나오게 한다.*/
SELECT dept_no, COUNT(emp_no) FROM dept_emp
GROUP BY dept_no
HAVING COUNT(*) >= 20000
ORDER BY COUNT(emp_no) DESC;
-- group by 결과에서 조건을 더 줄때 having 절

SELECT dept_no, COUNT(emp_no) FROM dept_emp
GROUP BY dept_no
WITH ROLLUP;
-- 프로그래밍쪽에서 처리하기때문에 많이는 안쓰는 기능


/*가장 적은 salary 를 받은 사람의 이름이 나오도록*/

SELECT emp_no FROM salaries
ORDER BY salary
LIMIT 1;

SELECT * FROM employees
WHERE emp_no = (
	SELECT emp_no FROM salaries
	ORDER BY salary
	LIMIT 1
);

-- min() 써서도 해결해볼것 + 같은 최저값을 갖는 사람이 여러명일때 체크

-- 207p auto_increment aka 개꿀기능
USE `test1`;

CREATE TABLE t_hobbit(
	i_hobbit INT UNSIGNED AUTO_INCREMENT,
	nm VARCHAR(10) UNIQUE NOT NULL,
	PRIMARY KEY (i_hobbit)
);
-- pk 혹은 unique 인 칼럼에 정수형에 적용가능

INSERT INTO t_hobbit (nm)
VALUES ('농구');

INSERT INTO t_hobbit (nm)
VALUES ('축구');

INSERT INTO t_hobbit (nm)
VALUES ('배구');

SELECT * FROM t_hobbit;

--

CREATE TABLE t_hobbit_2 (
	hobbit_id INT UNSIGNED PRIMARY KEY,
	NAME VARCHAR(20) NOT NULL,
	created_at DATETIME DEFAULT NOW()
);

INSERT INTO t_hobbit_2
(hobbit_id, NAME)
VALUES
(1, '핸드볼');

INSERT INTO t_hobbit_2
(hobbit_id, NAME, created_at)
VALUES
(2, '등산', '2022-02-10');

INSERT INTO t_hobbit_2
(hobbit_id, NAME, created_at)
VALUES
(3, '독서', '2022-02-10 12:12:12');

SELECT * FROM t_hobbit;
SELECT * FROM t_hobbit_2;

INSERT INTO t_hobbit_2
(hobbit_id, NAME)
SELECT i_hobbit, nm FROM t_hobbit;
-- 오류남 따라서 아래처럼

INSERT INTO t_hobbit_2
(hobbit_id, NAME)
SELECT i_hobbit + 3, nm FROM t_hobbit;