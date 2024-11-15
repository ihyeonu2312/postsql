SELECT 1+1
FROM DUAL
WHERE 'SQL'='SQL';

CREATE TABLE EX_TYPE (
	C CHAR(7),
	V VARCHAR(7),
	N NUMBER(5,2) -- 값 지정 필수X
);

DROP  TABLE EX_TYPE;

SELECT *
FROM EX_TYPE
ORDER BY N ASC; -- ASC(기본값) 생략가능   ASC오름차순 DESC내림차순 정렬

INSERT INTO EX_TYPE VALUES('1', 'SQL', 1);
INSERT INTO EX_TYPE VALUES('100', 'SQL', 100);
INSERT INTO EX_TYPE VALUES('2', 'SQL', 2);
INSERT INTO EX_TYPE VALUES('3', 'SQL', 3);
INSERT INTO EX_TYPE VALUES('20', 'SQL', 20);

DELETE FROM EX_TYPE;

SELECT *
FROM EX_TYPE
WHERE C=V || '    ';

SELECT 3.14 + 1 FROM DUAL;

SELECT ROWNUM, STUDENT.*, ROWID FROM STUDENT
WHERE ROWNUM <= 5;
--WHERE GRADE = 2;

-- 현재 시간 정보
SELECT SYSDATE FROM DUAL;

SELECT * FROM DEPARTMENT d;

--{1, 100, 2, 3, 20}

SELECT * FROM EX_TYPE;

-- 학생 테이블에서 1학년 학생의 학번, 이름, 학과번호 조회
SELECT STUDNO, NAME, DEPTNO
FROM STUDENT s
WHERE GRADE = '1';

-- 학번, 이름, 학과번호, 몸무게 조회 단, 70KG이상
SELECT STUDNO, NAME, DEPTNO, WEIGHT
FROM STUDENT
WHERE WEIGHT >=70;

-- 이름, 학년, 몸무게, 학과번호, 70KG이상이면서 1학년 학생
SELECT NAME, GRADE, WEIGHT, DEPTNO
FROM STUDENT s
WHERE WEIGHT >= 70
	AND GRADE = '1';

	
-- 이름, 학년, 몸무게, 학과번호, 70KG이상이거나 1학년 학생
SELECT NAME, GRADE, WEIGHT, DEPTNO
FROM STUDENT s
WHERE WEIGHT >= 70
	OR GRADE = '1';
	
-- 학번, 이름, 몸무게, 50KG이상이면서 70이하
SELECT STUDNO, NAME, WEIGHT
FROM STUDENT s
WHERE WEIGHT BETWEEN 50 AND 7O;

-- 학생증 이름, 생년월일 81년에서 83년사이
SELECT NAME, BIRTHDATE 
FROM STUDENT s
WHERE BIRTHDATE BETWEEN '81/01/01' AND '83/12/31';

-- 이름, 생년월일 출력 81년에서 83년사이 IN사용
SELECT NAME, BIRTHDATE 
FROM STUDENT s
WHERE TO_CHAR(BIRTHDATE, 'YY') IN(81,82,83);

-- 이름, 학년, 학과번호 조회 102번, 201번 학과만
SELECT NAME, GRADE, DEPTNO
FROM STUDENT
WHERE DEPTNO IN(102, 201);

-- 이름, 학년, 학과번호 조회 성이 김씨인 학생만 
SELECT NAME, GRADE, DEPTNO
FROM STUDENT s
WHERE NAME LIKE '김%' ; -- LIKE 부분일치

SELECT 2/NULL FROM DUAL;

-- 교수 테이블에서 이름, 직급, 보직수당 조회
SELECT  NAME, POSITION, COMM
FROM PROFESSOR p ;

-- 교수 테이블에서 이름, 직급, 보직수당 조회, 단 수당이 있는 사람만
SELECT NAME, POSITION , COMM
FROM PROFESSOR p
WHERE COMM IS NOT NULL;

-- 교수이름, 급여, 수당, 급여+수당 조회
SELECT NAME, SAL, COMM, SAL+COMM SALCOM, NVL(COMM, 0)+SAL A , NVL2(COMM, SAL+COMM, SAL) B
FROM PROFESSOR p;         
