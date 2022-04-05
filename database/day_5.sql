-- DAY 5 223p 자주쓰는 함수

/*
자세한내용은 검색
 숫자데이터형식 INT FLOAT, DOUBLE, DECIMAL...                                      
 
 문자데이터형식 CHAR고정길이 VARCHAR가변길이, LONGTEXT
	BLOB(사진 영상등을 데이터베이스에 저장하는데 장단점이 있다. 잘안쓴다고함)
	
날짜와 시간 데이터 형식 DATE TIME DATETIME
그외 sql에서도 변수 사용할수 있다는점
*/

-- 데이터 형식과 형변환
SELECT '10';
SELECT CONVERT('10',INT);
-- 명시적 형변환 강제형변환 (Explicit conversion)

SELECT '10' + '10';
-- 프로그래밍언어는 결과값 1010나올텐데 mysql에서는 사칙연산 숫자로 계산됨
-- 이런게 암시적인형변환(자동형변환) implicit conversion

SELECT 10;
SELECT CONVERT(10, CHAR);
-- varchar 은 안되네

SELECT CONVERT('10.1', FLOAT);


-- 형변환 cast
SELECT CAST('10' AS INT);

-- 문자열합치기 concat
SELECT 'A' + 'B';
-- 프로그래밍어에서는 이렇게 했겠지만

SELECT CONCAT('A1' , '22B2' , '가나다');

-- IF
SELECT if(100>200, '후엥' , '호롤롤');

-- employees 테이블을 조회하는데 gender 값이 'M'이면 '남자' 'F'면 '여자' 값이 뜨도록
USE `employees`;

SELECT *, IF(gender='M', '남자','여자') FROM employees;

-- 응용
-- SELECT 'M', 'F', 'A' 세 타입일경우

SELECT IF(gender = 'M', '남자', IF(gender = 'F', '여자', 'other'))
FROM employees;

-- 예제
USE `test1`;

SELECT *, IF(nm = '농구', 'basketball', IF(nm = '배구', 'volleyball','football')) AS EN_nm
FROM t_hobbit;

SELECT
	CONCAT(nm,
		if(nm = '농구', 'basketball',if(nm='배구','volleyball','football'))
		)
		FROM t_hobbit;
-- 다름표현방식

-- ifnull 자주쓰임

SELECT *, IFNULL(memberaddress, '주소없음')
FROM membertbl;

-- nullif
SELECT NULLIF('안녕', '안녕');
SELECT NULLIF('안녕', '안녕22');


-- case-when-else-end
 --	case 값 when 비교값 then...
SELECT CASE nm
			when '농구' THEN 'basketball'
 			when '배구' THEN 'volleyball'
 			when '축구' THEN 'football'
 		end
FROM t_hobbit;
 
 -- case when 조건식 then...
 SELECT 
 	nm, 
 	CASE WHEN nm = '농구' THEN 'basketball'
 			when nm = '배구' THEN 'volleyboall'
 			when nm = '축구' THEN 'football'
 			ELSE '없음'
 	END AS eng
FROM t_hobbit;
-- 비교식형태 가능. nm 뿐이아니라 다른컬럼 사용가능./ 아래형태가 더 유연함

--  이런것도 있다. 235p
SELECT ASCII('A'), CHAR(65);

-- concat_ws
SELECT CONCAT('A','B','C');
SELECT CONCAT('A','_','B','_','C'); 						
SELECT CONCAT_WS('_', 'A', 'B', 'C');

--

SELECT FORMAT(1/3, 12);

SELECT FLOOR(11.9), CEIL(11.02352351), ROUND(11.53452, 3);
-- floor:버림 ceil:올림 round:반올림

SELECT FORMAT(FLOOR(124124.124124),0);

SELECT round(123.1212413, 4);


-- insert
SELECT
	INSERT('abcdefghi', 3,4,'@@@')
	,INSERT('abcdefghi', 3,0,'@@@');
	
-- upper, lower
SELECT 'aBc', 'AbC', 'aBc' = 'AbC';
-- 1은 true. database 에는 걍 트루뜨네. 프로그래밍쪽은 false 뜸
SELECT LOWER('abcdEFG'), UPPER('abcdEFGH');

--

SELECT '      a    bc    ', LTRIM('      a    bc    '), TRIM('      a    bc    ');
SELECT TRIM(BOTH 'ㅋ' FROM 'ㅋㅋㅋㅋㅋ a   bcㅋㅋㅋㅋㅋ');


-- date_format
SELECT *, DATE_FORMAT(created_at, '%Y/%m/%d ') FROM t_hobbit_2;
SELECT *, DATE_FORMAT(created_at, '%Y/%m/%d %h:%i ') FROM t_hobbit_2;
SELECT *, DATE_FORMAT(created_at, '%r') FROM t_hobbit_2;
SELECT *, DATE_FORMAT(created_at, '%y') FROM t_hobbit_2;


/*
Apache Server(웹서버) https://www.apachelounge.com/download/
Php https://www.php.net/ > thread safe (zip 파일) 으로, non 으로하게되면 연동이 안된다?
MySQL, MariaDB
*/