-- 사용자 아이디가 jun123인 학생과 같은 학년인 학생의 학번, 이름 학년 조회

SELECT STUDNO, NAME, GRADE
FROM STUDENT
WHERE GRADE = (SELECT GRADE
	FROM STUDENT
	WHERE USERID = 'jun123'); 

-- 101번 학과 학생들의 평균 몸무게보다 적은 몸무게를 가진 학생의 학번, 학과번호, 몸무게 조회
SELECT STUDNO, DEPTNO, WEIGHT
FROM STUDENT
WHERE WEIGHT < (SELECT AVG(WEIGHT) 
	FROM STUDENT
	WHERE DEPTNO = 101);
	
-- 20101 학생의 학년과 동일하고  20101학생보다 키가 큰 학생의 이름, 학년, 키를 조회
SELECT NAME, GRADE, HEIGHT
FROM STUDENT
WHERE GRADE = (SELECT GRADE
FROM STUDENT
WHERE STUDNO = 20101)
AND HEIGHT > (SELECT HEIGHT 
FROM STUDENT
WHERE STUDNO = 20101);

-- 정보미디어 학부에 소속된 학생의 학번, 이름, 학과번호 조회
SELECT STUDNO, NAME, DEPTNO
FROM STUDENT
WHERE DEPTNO IN (101, 102);

SELECT STUDNO, NAME, DEPTNO
FROM STUDENT
WHERE DEPTNO IN (SELECT DEPTNO
FROM DEPARTMENT 
WHERE COLLEGE = (SELECT DEPTNO 
	FROM DEPARTMENT
	WHERE DNAME = '정보미디어학부'));

--  모든 학생 중에서 4학년 학생 중에서 키가 제일 작은 학생보다 키가 큰 학생의 학번, 이름, 키를 출력하여라
SELECT HEIGHT
FROM STUDENT
WHERE HEIGHT > ANY (SELECT HEIGHT 
	FROM STUDENT
	WHERE GRADE = 4);

SELECT HEIGHT
FROM STUDENT s
WHERE HEIGHT > (SELECT MIN(HEIGHT)
	FROM STUDENT s
	WHERE GRADE = 4);
	
-- 4학년 학생중에서 키가 가장 큰 학생보다 큰 학생을 조회, 학번 이름 키
SELECT STUDNO, NAME, HEIGHT
FROM STUDENT s 
WHERE HEIGHT > ALL (
	SELECT HEIGHT
	FROM STUDENT s 
	WHERE GRADE = 4
);

SELECT STUDNO, NAME, HEIGHT
FROM STUDENT s 
WHERE HEIGHT > (
	SELECT MAX(HEIGHT)
	FROM STUDENT s
	WHERE GRADE = 4
);

-- 보직수당을 받는 교수가 존재한다면 교수들의 교수번호, 이름, 급여, 수당, 급여+수당을 조회
SELECT NAME , SAL , COMM , SAL+NVL(COMM,0) SALCOM 
FROM PROFESSOR p 
WHERE EXISTS (
	SELECT *
	FROM PROFESSOR p 
	-- WHERE COMM IS NOT NULL
	WHERE 1=1
);

-- 학년별 몸무게가 최소인 학생의 이름, 학년, 몸무게 조회
SELECT NAME, GRADE, WEIGHT 
FROM STUDENT s
WHERE (GRADE, WEIGHT) IN (
	SELECT GRADE, MIN(WEIGHT) 
	FROM STUDENT s
	GROUP BY GRADE
);

SELECT NAME , GRADE , WEIGHT 
FROM STUDENT s 
WHERE GRADE IN(
	SELECT DISTINCT GRADE
	FROM STUDENT s
) 	AND WEIGHT IN (SELECT MIN(WEIGHT) 
FROM STUDENT s 
GROUP BY GRADE);


SELECT MIN(WEIGHT) 
FROM STUDENT s1 
GROUP BY GRADE;

-- 학과 별 평균 키 보다 큰 학생의 이름, 학과번호, 키 조회
SELECT NAME, DEPTNO, HEIGHT 
FROM STUDENT s1 	
WHERE HEIGHT > (
	SELECT AVG(HEIGHT) 
	FROM STUDENT s2 
	WHERE S2.DEPTNO = S1.DEPTNO
);
	
SELECT DEPTNO, AVG(HEIGHT)
FROM STUDENT
GROUP BY DEPTNO ;

SELECT AVG(HEIGHT)
FROM STUDENT
WHERE DEPTNO = 101;

SELECT MAX(SUN), MAX(MON) FROM(
SELECT 1 SUN, NULL MON, NULL, NULL, NULL, NULL, NULL FROM DUAL
UNION
SELECT NULL, 2, NULL, NULL, NULL, NULL, NULL FROM DUAL
UNION
SELECT NULL, NULL, 3, NULL, NULL, NULL, NULL FROM DUAL
);

SELECT MOD(12, 10) FROM DUAL;
SELECT TO_CHAR(TO_DATE('2024-09-07', 'YYYY-MM-DD'), 'W') FROM DUAL; 

SELECT 
	MAX(DECODE(MOD(RN, 7), 1, RN)) SUN
	,MAX(DECODE(MOD(RN, 7), 2, RN)) MON
	,MAX(DECODE(MOD(RN, 7), 3, RN)) TUE
	,MAX(DECODE(MOD(RN, 7), 4, RN)) WED
	,MAX(DECODE(MOD(RN, 7), 5, RN)) THU
	,MAX(DECODE(MOD(RN, 7), 6, RN)) FRI
	,MAX(DECODE(MOD(RN, 7), 0, RN)) SAT
FROM(
	SELECT
		ROWNUM RN,
		TO_CHAR(TO_DATE('2024-09-' || LTRIM(TO_CHAR(ROWNUM, '00'))), 'W') WEEK 
	FROM DICT
	WHERE ROWNUM <= TO_CHAR(LAST_DAY(TO_DATE('2024-09', 'YYYY-MM')), 'DD')
)
GROUP BY WEEK
ORDER BY WEEK;


-- DML

-- 홍길동 데이터 입력
-- 학번 : 10110, 이름 : '홍길동', userid : 'hong', grade: '1', idnum : '8510101010101'
-- birthdate : '85/10/10', tel :'041)123-4567', height : 170, weight:70, deptno:101, profno:9903
INSERT INTO STUDENT
VALUES(10110,'홍길동', 'hong', '1', '8510101010101', '85/10/10', '041)123-4567', 170, 70, 101, 9903);

SELECT COLUMN_NAME, COLUMN_ID FROM USER_TAB_COLS WHERE TABLE_NAME = 'STUDENT';

SELECT *FROM DICT WHERE TABLE_NAME LIKE 'ALL_%COL%';

SELECT * FROM STUDENT;

ROLLBACK;

COMMIT;

DELETE FROM STUDENT WHERE NAME = '홍길동';

-- 학과 테이블에 DEPTNO : 300, DNAME : 생명공학부를 추가
INSERT INTO DEPARTMENT(DEPTNO, DNAME, COLLEGE, LOC) VALUES(300, '생명공학부', NULL, '');
SELECT * FROM DEPARTMENT;

-- US_EN, UK_EN

INSERT INTO PROFESSOR(PROFNO, NAME, POSITION, HIREDATE, DEPTNO) VALUES (9920, '최윤식', '조교수', TO_DATE('2006-01-01', 'YYYY-MM-DD'), 102);

SELECT * FROM PROFESSOR;

DELETE PROFESSOR WHERE PROFNO = 9910; --삭제

INSERT INTO PROFESSOR VALUES (9910, '백미선', 'white', '전임강사', 200, TRUNC(SYSDATE), 10, 101);

-- 학생(STUDENT)과 동일한 테이블 생성 단, 데이터 없이
CREATE TABLE T_STUDENT AS
SELECT * FROM STUDENT WHERE 1=0; -- 데이터 없는 T_STUDENT테이블 생성

SELECT * FROM T_STUDENT; -- 테이블 조회

INSERT INTO T_STUDENT
SELECT * FROM STUDENT; -- STUDENT동일값 넣기