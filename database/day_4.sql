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