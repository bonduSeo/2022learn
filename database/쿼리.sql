--DDL (정의어)

CREATE DATABASE test1;
DROP DATABASE test1;

CREATE TABLE memberTBL (
	memberID CHAR(8) NOT NULL PRIMARY KEY,
	memberName CHAR(5) NOT NULL,
	memberAddress CHAR(20) null
);
/* prymary key
unique(중복된 값이 안들어가는), not null, index*/

-- 주석방법. --하고 하고 한칸 띄어야함. 싱글라인 주석
/* 요거도 됨 멀티라인 주석 */ 

DROP TABLE membertbl;

CREATE TABLE productTBL(
	productName CHAR(4) PRIMARY KEY,
	cost INT NOT NULL,
	MAKEDATE DATE,
	company CHAR(5),
	amount INT NOT null
);

-- int:정수, 실수(소수점이 있으면)


-- CRUD, DML (데이터 조작어)
-- Create ( insert문)
/*
INSERT INTO  테이블명
(값을 넗고싶은 컬럼명)
VALUES 
(값들)
띄어지기만하면 띄어쓰기 줄바꿈 상관없음
*/
INSERT INTO membertbl
(memberid, membername, memberaddress)
VALUES
(1, '홍길동','서울시');

INSERT INTO membertbl
(memberid, membername, memberaddress)
VALUES
(2, '홍길동동동','서울울시');

INSERT INTO membertbl
(memberid, membername)
VALUES
(3, '홍길동');

INSERT INTO membertbl
(membername, memberid)
VALUES
('홍길동',3);
-- 이렇게도 쌉가능


-- membername 은 not null 이기때문에 에러가 발생
INSERT INTO membertbl
(memberid)
VALUES
(4);

INSERT INTO membertbl
(memberid, membername)
VALUES
(5, '신사임당'),
(6, '유관순'),
(7, '나이팅게일');

INSERT INTO membertbl
VALUES
(8, '신사임당', '부산시');
-- 이렇게 되긴하는데 에러터질수도있고 안쓰는게 낫다. (DB에서 컬럼순서가 바뀔수도있기에)


-- Read (select문)
/*
select 보고싶은 컬럼명들 from 테이블명
[옵션]
[join 테이블 연결]
[where 보고싶은 조건]
[group by 그룹으로 묶은 조건]
[having 그룹으로 묶는 조건에서의 조건]
[order by 레코드 순서 지정]
[limit 보고싶은 레코드 수]
*/
SELECT memberid, membername, memberaddress
FROM membertbl;

SELECT membername, memberid
FROM membertbl;

SELECT * FROM membertbl;

SELECT * FROM membertbl
WHERE memberid = '1';

SELECT * FROM membertbl
WHERE memberaddress = '서울시';

SELECT * from membertbl
WHERE memberaddress != '서울시';
-- 서울시가 아닌 값이 있는 

SELECT * FROM membertbl
WHERE memberaddress IS NULL;
-- null 인 항목

SELECT * FROM membertbl
WHERE memberaddress != '서울시'
or memberaddress IS NULL;
-- 난 둘돠 

SELECT * FROM membertbl
	WHERE memberaddress ='부산시'
		AND membername = '신사임당';
		
-- LIKE문은 문자열이 포함된 레코드를 찾을 때.
SELECT * FROM membertbl
WHERE membername LIKE '%팅%';

SELECT * FROM membertbl
WHERE membername LIKE '%이%';

SELECT * FROM membertbl
WHERE membername LIKE '나%';
 -- 나로 시작하는

-- Update (update문)
/*
	update 테이블명
	set 수정하고 싶은 컬럼명 = 변경하고 싶은 값
	where 레코드 선택
*/
UPDATE membertbl
SET membername = '게일'
WHERE memberid = 7;
-- update 문은  where절이 거의 필수다. 왜나면 데이터가 모두 바뀌거나 위험함

UPDATE membertbl
SET membername = 'gugu'
, memberaddress = '강원도'
WHERE memberid = '9';

/*
	my name is hong
표기법-작명

camel case			: myNameIsHong
pascal case			: MyNameIsHong
snake case			: my_name_is_hong
cabob case (케밥)	: :my-name-is-hong

*/
-- Delete (delete문)
/*
delete from 테이블명 whrere 절
*/
DELETE FROM membertbl
WHERE memberAddress IS NULL; 

-- is not null 널이 아닌친구들


DELETE FROM membertbl
WHERE memberId = 8;