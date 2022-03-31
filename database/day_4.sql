-- day 4

CREATE TABLE t_member_hobbit (
	user_no INT,
	hobbit_no INT,
	PRIMARY KEY (user_no, hobbit_no),
	FOREIGN KEY (user_no) REFERENCES membertbl (memberid),
	FOREIGN KEY (hobbit_no) REFERENCES t_hobbit_2 (hobbit_id)
);

SELECT * FROM t_member_hobbit;

DESC t_member_hobbit;

SELECT * FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 't_member_hobbit';
-- 정보는 여기 저장된다고함

--

INSERT INTO t_member_hobbit
(user_no, hobbit_no)
VALUES
(1,1);

INSERT INTO t_member_hobbit
(user_no, hobbit_no)
VALUES
(1,2);

INSERT INTO t_member_hobbit
(user_no, hobbit_no)
VALUES
(5,3), (5,7), (5,8);

INSERT INTO t_member_hobbit
(user_no, hobbit_no)
VALUES
(7,6);
-- 정보입력, 아이디별 취미 입력함

DROP TABLE membertbl;
-- 포린키걸려있어서 드롭안된느데 gui에서 우클릭삭제하니까 됨 ㅠㅠ


SELECT
	B.*, A.* , C.*
FROM t_member_hobbit A
INNER JOIN membertbl B
	ON A.user_no = B.memberID
INNER JOIN t_hobbit_2 C
	ON A.hobbit_no = C.hobbit_id;
-- join 걸어쓰는방법은 여러방법이 있다고함
-- 꼭 중간에 있는테이블을 기준안해도 되네.

SELECT
	B.memberName, B.memberAddress, C.name
FROM t_member_hobbit A
	INNER JOIN membertbl B
		ON A.user_no = B.memberID
	INNER JOIN t_hobbit_2 C
		ON A.hobbit_no = C.hobbit_id;
	-- 이렇게 깔끔하게 볼수도있다.
	
	/*
	문제
	사원번호, 사원명, (부서이름), 직책 나오게
	*/
	
SELECT
	A.emp_no, A.first_name, A.last_name, B.title
FROM employees A
	INNER JOIN titles B
		ON A.emp_no = B.emp_no
	INNER JOIN dept_emp C
		ON A.emp_no = C.emp_no;
-- 부서이름 빼고

SELECT
	A.emp_no, A.first_name, A.last_name, B.title, D.dept_name
FROM employees A
	INNER JOIN titles B
		ON A.emp_no = B.emp_no
	INNER JOIN dept_emp C
		ON A.emp_no = C.emp_no
	INNER JOIN departments D
		ON D.dept_no = C.dept_no;
		
		
-- Q:남녀사원들의 평균 연봉
SELECT
	EM.gender, AVG(SA.salary) AS AVG_salary_gender
FROM employees EM
	INNER JOIN salaries SA
		ON EM.emp_no = SA.emp_no
GROUP BY EM.gender;
		
		
-- Q:부서별 제일 높은 평균연봉 값, 사람
 -- 어렵다. 쌤 깃허브 참고
SELECT emp_no, AVG(salary)
FROM salaries
GROUP BY emp_no;
-- 사원번호별 평균연봉

SELECT DE.dept_no, DP.dept_name, MAX(AA), NOAV.emp_no, EM.first_name, EM.last_name
FROM (
	SELECT emp_no, AVG(salary) AS AA
	FROM salaries
	GROUP BY emp_no
) AS NOAV
	INNER JOIN dept_emp DE
		ON NOAV.emp_no = DE.emp_no
	INNER JOIN departments DP
		ON DE.dept_no = DP.dept_no
	INNER JOIN employees EM
		ON DE.emp_no = EM.emp_no
GROUP BY DE.dept_no;
-- 여기서 부서이름도 나오게하면?



--

SELECT X.dept_no, MAX(Z.avg_salary) AS max_salary
FROM (
	SELECT A.emp_no, AVG(B.salary) AS avg_salary 
	FROM employees A
		INNER JOIN salaries B
			ON A.emp_no = B.emp_no
	GROUP BY A.emp_no
) AS Z
	INNER JOIN dept_emp X
		ON Z.emp_no = X.emp_no
GROUP BY X.dept_no;
-- 선생님코드


SELECT z.dept_no, MAX(Z.avg_salary) AS max_salary
FROM (
	SELECT B.dept_no, A.emp_no, AVG(A.salary) AS avg_salary
	FROM salaries A
	INNER JOIN dept_emp B
	ON A.emp_no = B.emp_no
	GROUP BY B.emp_no
) Z
GROUP BY Z.dept_no;
-- 은지씨코드 



-- 부서별(부서이름) 연봉평균값, max값, min값 나오게 해주세요.

SELECT DS.dept_no, DS.dept_name, AVG(SA.salary), MAX(SA.salary), MIN(SA.salary)
FROM dept_emp DE
	INNER JOIN salaries SA
		ON DE.emp_no = SA.emp_no
	INNER JOIN departments DS
		ON DE.dept_no = DS.dept_no
GROUP BY DE.dept_no;



-- 직무별 연봉 평균값

SELECT TT.title, AVG(salary)
FROM salaries SA
	INNER JOIN titles TT
		ON SA.emp_no = TT.emp_no
GROUP BY TT.title;
