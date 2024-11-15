SELECT * FROM PROFESSOR p ;

ALTER TABLE DEPARTMENT MODIFY (DEPTNO CONSTRAINT DEPARTMENT_PK PRIMARY KEY);

SELECT STUDNO, ROWID, ROWNUM FROM STUDENT;

--DEPARTMENT 테이블 DNAME에 고유 인덱스 생성
CREATE UNIQUE INDEX IDX_DEPT_NAME ON DEPARTMENT(DNAME);

DROP INDEX IDX_DEPT_NAME;

SELECT /*+ INDEX (DEPARTMENT IDX_DEPT_NAME) */ * FROM DEPARTMENT;
SELECT * FROM DEPARTMENT;

-- STUDENT BIRTHDATE에 비고유 인덱스 생성
CREATE INDEX IDX_STUD_BIRTHDATE ON STUDENT(BIRTHDATE);

-- STUDENT테이블의 DEPTNO, GRADE에 결합인덱스 생성
SELECT DISTINCT GRADE, DEPTNO FROM STUDENT s ;
CREATE INDEX IDX_STUD_DEPTNO_GRADE ON STUDENT(DEPTNO, GRADE DESC);

SELECT * FROM STUDENT s ;

-- VIEW

CREATE OR REPLACE VIEW VIEW_STUD AS
SELECT STUDNO, NAME, USERID,DEPTNO FROM STUDENT;

SELECT DEPTNO, COUNT(*) 
FROM VIEW_STUD
WHERE DEPTNO <> 201
GROUP BY DEPTNO;

INSERT INTO VIEW_STUD VALUES (12345, '홍길동', NULL);

SELECT * FROM VIEW_STUD;
SELECT * FROM (SELECT STUDNO, NAME, USERID, DEPTNO FROM STUDENT);

SELECT * FROM STUDENT;

CREATE FORCE VIEW VIEW_STUD2 AS -- FORCE를 사용하여 강제로 VIEW 생성
SELECT * FROM STUDEN;
 

-- 학번, 이름, 학과번호, 학과이름으로 VIEW_STUD_DEPT라는 뷰 생성

CREATE VIEW VIEW_STUD_DEPT AS
SELECT STUDNO, NAME, DEPTNO, DNAME 
FROM STUDENT s NATURAL JOIN DEPARTMENT d;

SELECT * FROM VIEW_STUD_DEPT;

-- 11111, 고길동, 101, 컴퓨터공학과
INSERT INTO VIEW_STUD_DEPT VALUES(11111, '고길동', 101, '컴퓨터공학과');


-- 학과별 인원수를 조회하여 VIEW_STUD_DEPT2 라는 이름의 VIEW 생성
CREATE VIEW VIEW_STUD_DEPT2(DNO, CNT) AS
SELECT DEPTNO, COUNT(*)
FROM STUDENT s
GROUP BY DEPTNO
ORDER BY 1;

SELECT * FROM VIEW_STUD_DEPT2;


SELECT * FROM BOARD ORDER BY 1;

DELETE FROM BOARD WHERE WRITER = '작성자';

DROP SEQUENCE SEQ_BOARD;
CREATE SEQUENCE SEQ_BOARD;

INSERT INTO BOARD(NO, TITLE, CONTENT, WRITER) 
	VALUES (SEQ_BOARD.NEXTVAL, '제목' || SEQ_BOARD.CURRVAL, '내용', '작성자');
	
INSERT INTO BOARD(NO, TITLE, CONTENT, WRITER)
	SELECT SEQ_BOARD.NEXTVAL, TITLE, CONTENT, WRITER FROM BOARD;

-- 한 페이지에 몇개씩?
SELECT * FROM (
	SELECT ROWNUM RN, A.*
	FROM (
		SELECT B.* FROM BOARD B 
		--WHERE ROWNUM <= 10
		ORDER BY 1 DESC
	) A
)
WHERE ROWNUM <= 10 AND RN > (1 - 1) * 10;

SELECT * FROM (
	SELECT /*+ INDEX_DESC(B SYS_C007012) */ B.*, ROWNUM RN 
	FROM BOARD B 
	WHERE NO > 0
); 

WITH A AS (
	SELECT /*+ INDEX_DESC(B SYS_C007012) */ B.*, ROWNUM RN 
	FROM BOARD B 
	WHERE NO > 0
)
SELECT * 
FROM A
WHERE ROWNUM <= 10
AND RN > 10;


-- FILE SYSTEM
-- FILE의 권한

SELECT * FROM HR.EMPLOYEES;
SELECT * FROM EMP;

CREATE SYNONYM EMP FOR HR.EMPLOYEES;

CREATE PUBLIC SYNONYM STU FOR SAMPLE.STUDENT;

SELECT * FROM STU;

-- 사전
-- 접두어 : USER_, ALL_, DBA_

SELECT * FROM USER_TABLES;

SELECT * FROM ALL_TABLES WHERE OWNER = 'SAMPLE';

SELECT * FROM USER_TAB_COLUMNS -- 테이블 열 조회
WHERE TABLE_NAME = 'BOARD';

SELECT * FROM USER_CONSTRAINTS; -- 제약조건

SELECT * FROM USER_INDEXES; -- INDEX정보

-- 별칭
SELECT s.* FROM STUDENT s ;
SELECT D.* FROM STUDENT D ;

-- DUAL 공용동의어
SELECT SYSDATE FROM DUAL;
SELECT * FROM SYS.DUAL;