-- day 3

-- dept_emp 테이블에서 dept_no 종류가 몇개가 있는지?
SELECT DISTINCT dept_no FROM dept_emp;
-- 중복된것 제거
-- 이 테이블에서 pk가 2개, 두개 조합해서 값이 유일하면된다.(하나의 항목 중복은 있읈무 있다)

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
-- 비교해보면 틀과 데이터만 복사됨. 제약조건 - PK라던지 그런것들은 복사안됨.
-- 필요하다면 지정한 일부열만 복사할수도 있다. 
-- 임시로 데이터를 옮길때 쓰인다고함?!

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
-- group by 결과에서 조건을 더 줄때(where절처럼) having 절
-- where 절은 group by 하기전에 조건이 들어감

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
-- now() = current_timestamp(), 날짜까지만: current_date()
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


-- update 구문 

-- emp_no: 10001의 모든 salary를 1,000 씩 올리고 싶다.
SELECT * FROM salaries;

UPDATE salaries
SET salary = salary + 1000
WHERE emp_no = 10001;
SELECT * FROM salaries;

-- insert ignore p213 에러나도 무시하고 계속 실행
SELECT * FROM t_hobbit_2;

INSERT IGNORE INTO t_hobbit_2
(hobbit_id, NAME)
VALUE
(7, '탁구');
INSERT IGNORE INTO t_hobbit_2
(hobbit_id, NAME)
VALUE
(8, '스키');

INSERT INTO t_hobbit_2
(hobbit_id, NAME)
VALUE (7, '탁구')
ON DUPLICATE KEY UPDATE NAME = '수영';

INSERT INTO t_hobbit_2
(hobbit_id, NAME)
VALUE (7, '탁구')
ON DUPLICATE KEY UPDATE NAME = '탁구';
-- 요렇게 주로쓰일듯

DROP TABLE t_board;
CREATE TABLE t_board (
	i_board INT UNSIGNED PRIMARY KEY,
	title VARCHAR(20) UNIQUE NOT NULL,
	hits INT UNSIGNED DEFAULT 0
);

SELECT * FROM t_board;

INSERT INTO t_board
(i_board, title, hits)
VALUES (2,'안녕', 0)
ON DUPLICATE KEY UPDATE hits = hits + 1;
-- 오... primary key or unique 일경우 dupicate key 적용됨


SELECT * FROM dept_emp
WHERE dept_no = 'd001';

WITH dept_emp_d001(emp_no, from_date, to_date)
AS (
	SELECT emp_no, from_date, to_date FROM dept_emp
	WHERE dept_no = 'd001'
)
SELECT * FROM dept_emp_d001;
-- 잘안씀?! 왜냐면 아래처럼 쓸수도 있어서

SELECT A.* FROM
(
	SELECT emp_no, from_date, to_date FROM dept_emp
	WHERE dept_no = 'd001'
) AS A;
	
	
SELECT A.* FROM
(
	SELECT emp_no, from_date, to_date FROM dept_emp
	WHERE dept_no = 'd001'
) A;
-- 이건 where절 써서 더 뭔가할수있음?!


-- --
/* 사람별 평균 급여에의 평균값보다 큰 사람들의 이름이 나오게 해주세요.  */
SELECT * FROM employees 
WHERE emp_no IN (
	SELECT emp_no
	FROM salaries
	GROUP BY emp_no
	HAVING AVG(salary) >= (
		SELECT avg(avg_salary) FROM (
			SELECT 1 as val, AVG(salary) AS avg_salary FROM salaries
			GROUP BY emp_no
		) A
		GROUP BY val
	)
);
-- 안해봄. 체크해보기

-- 미션
USE `test1`;
CREATE TABLE T_ORDER (
	o_no INT PRIMARY KEY,
	cus_no INT,
	o_date DATE DEFAULT NOW(),
	o_price INT DEFAULT 0,
	FOREIGN KEY (cus_no) REFERENCES t_customer(cus_no)
);
-- now() 대신 current_time 해도됨
-- foreign key 이름도 따로줄수도있음 constraint 이름
SELECT * FROM t_order;

INSERT INTO t_order 
(o_no, cus_no)
VALUES
(1, 2);

CREATE TABLE t_customer (
	cus_no INT PRIMARY KEY,
	nm VARCHAR(10) NOT NULL
);

DESC t_order;
DESC t_customer;

DROP TABLE t_order;
DROP TABLE t_customer;

--  ----------------
-- Foreign Key 는 잘못된값이 입력되는것을 막기위해서..?
-- 참조한 테이블에 있는 값만 입력되게 하기 위해서


-- 미션2
INSERT INTO t_order
(o_no, cus_no, o_price)
VALUES
(1,3,55000),
(2,5,70000),
(3,3,60000);

INSERT INTO t_customer
(cus_no, nm)
VALUES
(3, '홍길동'),
(5, '이순신');

UPDATE t_customer
SET
nm = '장보고'
WHERE cus_no = 5;

DELETE FROM t_order
WHERE o_no = 2;

SELECT o_no, o_price FROM t_order;
