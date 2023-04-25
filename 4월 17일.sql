/*
1일차 수업

1. 소프트웨어 다운로드  (11g)
https://www.oracle.com/database/technologies/xe-prior-release-downloads.html

2. Oracle 설치 ( SYS , SYSTEM 계정에 대한 암호 설정: 1004)

3. sqlplus 프로그램 제공(CMD) : 단점 GUI  환경 제공하지 않아요

4. 별도의 프로그램  접속  Tool
4.1 SqlDeveloper 무료 , dbeaver  무료
4.2 토드 , 오렌지 , SqlGate  회사 .....

5. SqlDeveloper 실행  >> Oracle 서버 접속 >> GUI
5.1 HR 계정 사용 (unlock)
-- USER SQL
ALTER USER "HR" IDENTIFIED BY "1004" 
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
ACCOUNT UNLOCK ;
-- QUOTAS
ALTER USER "HR" QUOTA UNLIMITED ON "USERS";
-- ROLES
ALTER USER "HR" DEFAULT ROLE "CONNECT","RESOURCE";
-- SYSTEM PRIVILEGES

5.2 KOSA 계정 생성
-- USER SQL
CREATE USER "KOSA" IDENTIFIED BY "1004"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
-- QUOTAS
-- ROLES
GRANT "CONNECT" TO "KOSA" WITH ADMIN OPTION;
GRANT "RESOURCE" TO "KOSA" WITH ADMIN OPTION;
ALTER USER "KOSA" DEFAULT ROLE "CONNECT","RESOURCE";

-- SYSTEM PRIVILEGES

*/
/*
실습코드

CREATE TABLE EMP
(EMPNO number not null,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
MGR number ,
HIREDATE date,
SAL number ,
COMM number ,
DEPTNO number );
--alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800,null,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,200,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,'1981-04-02',2975,30,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,300,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,'1981-04-01',2850,null,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,'1981-06-01',2450,null,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,'1982-10-09',3000,null,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',null,'1981-11-17',5000,3500,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,'1983-01-12',1100,null,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,'1981-10-03',950,null,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,'1981-10-3',3000,null,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,'1982-01-23',1300,null,10);

COMMIT;

CREATE TABLE DEPT
(DEPTNO number,
DNAME VARCHAR2(14),
LOC VARCHAR2(13) );

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

COMMIT;



CREATE TABLE SALGRADE
( GRADE number,
LOSAL number,
HISAL number );

INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
COMMIT;



DB분야
개발자 (CRUD)(insert, select , update , delete) >> DML + DDL(create, alter ,drop)

관리자(DBA) 백업하고 복원 , 네트워크 관리 , 자원관리 , 하드웨어 관리

튜너 : SQL 튜너(문장) >> 속도 >> index >> 자료구조 
      하드웨어(네트워크) 튜너
      
모델러  : 설계 (PM) -ERD -요구사항 분석 ERD 

분석가 (데이터 분석)  석사급이상 .... 논문 read .....(SCI) 


*/
show user;

select * from emp;
select * from dept;
select * from salgrade;
--------------------------------------------------------------------------------
--1. 사원테이블에서 모든 데이터를 출력하세요
select * from emp;
SELECT * FROM EMP;
SELECT * FROM emp;

--2. 특정 컬럼 데이터 출력하기
select empno , ename , sal 
from emp;

select ename from emp;

--3. 가명칭 사용하기 (별칭: alias)
select empno 사번 , ename 이름
from emp;

select empno "사  번" , ename "이   름"
from emp;

--권장 문법(ANSI) >> 표준 >> 구문을 작성하면 (Oracle , Ms-sql , Mysql) 모두 동작
select empno as "사 번" , ename as "이 름"
from emp;

--Oracle 문자열 데이터 엄격하게 대소문자 구별
/*
JAVA : 문자> 'A' , 문자열> "AAAA"
ORACLE : 문자열 'A'   ,  'AAAA'  , 'AVBWEDWED'
ORACLE : 데이터로 'a' 'A' 다른문자열
*/
select * 
from emp
where ename='king'; --대소문자

select * 
from emp
where ename='KING'; --대소문자


/*
select 절     3
from 절       1
where 절      2
*/

--Oracle Query (질의어) : 언어
/*
연산자
JAVA : + 숫자(산술연산) , + 문자열(결합연산)
----------------------------------------
ORACLE :
결합 연산자  ||
산술 연산자  + (산술연산)

MS-SQL : + (산술, 결합)
*/

select '사원의 이름은' || ename || ' 입니다' as 사원정보
from emp;

--테이블의 기본 정보 ( 컬럼 , 타입)
desc emp;
--ENAME             VARCHAR2(10)   문자열 타입  결합가능 ...인지

/*
JAVA : class Emp {private int emnpno , private String ename}
ORACLE : create Table Emp( empno number , ename varchar2(20));
*/

--형변환(자동) >> 숫자를 문자열로 변환 
select empno || ename from emp;

select empno + ename from emp; --01722. 00000 -  "invalid number"

--사장님 ... 우리 회사에 직종이 몇개나 있나
select job from emp;

--중복 행 제거 키워드 : distinct

select distinct job from emp;
--grouping

--distinct 
--재미로 >> grouping
select distinct job , deptno
from emp
order by job;

--Oracle SQL 언어
--JAVA     : ( + , - , * /)  나머지 %
--ORACLE   : ( + , - , * /)  나머지 % 는 다른 곳에 사용 ...  함수 mod()
--문자열 패턴 검색 : ename like '%신%'

--사원테이블에서 사원의 급여를 100달라 인상한 결과를 출력하세요
select empno, ename , sal , sal + 100 as 인상급여 from emp;

--dual 임시 테이블
select 100 + 100 from dual;
select 100 || 100 from dual; -- 100100
select '100' + 100 from dual; --200 --'100' 숫자형 문자 ex)'123456'
select 'A100' + 100 from dual; --Error

--비교연산자
-- <  >   <=  
--주의
--JAVA : 같다 (==)  할당(=) , JavaScript : (== , ===)
--ORACLE : 같다 =    같지않다 !=

--논리연산자 (AND , OR , NOT)

select empno , ename ,sal
from emp
where sal >= 2000;

--사번이 7788번인 사원의 사번 , 이름 , 직종 , 입사일을 출력하세요
select empno, ename , job , hiredate
from emp
where empno=7788;

--사원의 이름이 king 사원의 사번 , 이름 , 급여 정보를 출력하세요
select empno , ename, sal
from emp
where ename ='KING';

/*    AND  , OR
 0 0   0     0
 1 0   0     1
 0 1   0     1
 1 1   1     1

*/
--초과 , 미만
--이상 , 이하 (=)

--급여가 2000달러 이상이면서 직종이 manager 인 사원의 모든 정보를 출력하세요
select *
from emp
where sal >= 2000 and job='MANAGER';


--급여가 2000달러 이상이거나 (또는) 직종이 manager 인 사원의 모든 정보를 출력하세요
select *
from emp
where sal >= 2000 or job='MANAGER';

--급여가 2000달러 초과이면서 직종이 manager 인 사원의 모든 정보를 출력하세요
select *
from emp
where sal > 2000 and job='MANAGER';

--오라클 날짜 (DB 서버의 날짜)
--sysdate
select sysdate from dual;
--23/04/17

select * from nls_session_parameters;
/*
NLS_LANGUAGE	        KOREAN
NLS_DATE_FORMAT	        RR/MM/DD
NLS_DATE_LANGUAGE	    KOREAN
NLS_TIME_FORMAT	        HH24:MI:SSXFF
*/
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

select sysdate from dual; --2023-04-17 14:35:54
--도구 >> 환경설정 >> 데이터베이스 확장 >> NLS >> 날짜형식 수정하셔도 됩니다

select * from emp;

--날짜 데이터 검색 >> 문자열 검색 처럼 >>  '날짜'
select * from emp
where hiredate ='1980-12-17';

select * from emp
where hiredate ='1980/12/17';

select * from emp
where hiredate ='1980.12.17';

select * from emp
where hiredate ='80-12-17'; --현재 날짜 (yyyy-MM-dd)

--사원의 급여가 2000이상이고 4000이하인 모든 사원의 정보를 출력하세요
select *
from emp
where sal >= 2000 and sal <= 4000;
-- 컬럼명 between A and B 연산자 (= 포함)

select *
from emp
where sal between 2000 and 4000;

--사원의 급여가 2000초과 4000미만 인 모든 사원의 정보를 출력하세요
select *
from emp
where sal > 2000 and sal < 4000;

--부서번호가 10번 또는 20번 또는 30번인 사원의 사번 , 이름 , 급여 , 부서번호를 출력하세요
select *
from emp
where deptno=10 or deptno=20 or deptno=30;
-- IN 연산자 
select *
from emp
where deptno in (10,20,30); --where deptno=10 or deptno=20 or deptno=30;

--부서번호가 10번 또는 20번 이 아닌 사원의 사번 , 이름 , 급여 , 부서번호를 출력하세요
select empno , ename,  sal , deptno
from emp
where deptno != 10 and deptno != 20;

-- IN 의 부정 ( NOT IN)
select *
from, emp
where deptno not in (10,20); --where deptno != 10 and deptno != 20;
--POINT : not in >>  != and 

--Today POINT
-- null 에 대한 이야기
-- 값이 없다
-- 필요악


create table member (
 userid varchar2(20) not null, --null을 허용하지 않겠다 (필수 입력사항)
 name varchar2(20) not null, --입력 강제
 hobby varchar2(50)--default null 허용 (선택 입력)
);
desc member;
insert into member(userid,hobby) values('kim','농구');
--ORA-01400: cannot insert NULL into ("KOSA"."MEMBER"."NAME")

insert into member(userid,name) values('hong','홍길동');
commit;
select * from member;

--------------------------------------------------------------------------------
/*
DB마다 설정
Oracle
insert , update , delete 명령
기본적으로 쿼리문 실행시 begin tran 구문이 자동 ~~~~ 개발자는 end(완료 , 취소)
오라클은 대기상태 . . . . 마지막 명령 (commit 실제 반영 , rollback 실제 취소) 작업완료

Ms-sql
자동 auto-commit
delete from emp; 자동 commit

begin tran
    delete from emp;
    
    commit or rollback 하지 않으면 데이터 처리 안됨
    
DB Transaction : 논리적인 작업 단위 (성공 , 실패)
OLTP (웹 환경 : 실시간 데이터 처리) >> 트랜잭션 
은행업무 이체
begin tran
    update . . . 계좌 - 1000
    update . . . 동생계좌 + 1000
end

OLAP (데이터 분석 : 일정기간 데이터를 모아서 분석)

*********오라클 에서 insert , update , delete 하면 반드시
*********commit , rollback 을 통해서 처리 여부를 결정해야 한다.
*/
--------------------------------------------------------------------------------
--수당(comm) 을 받지 않는 모든 사원의 정보를 출력하세요.
select *
from emp
where comm=null; --문법은 없어요

--null에 대한 비교는 is null을 써야 한다.
select *
from emp
where comm is null;
--암기 ( null 의 비교는 is null)

--comm을 받는 사원들 (comm 컬럼의 데이터가 null 이 아닌 것)
select *
from emp
where comm is not null;

--사원테이블에서 사번 , 이름 , 급여 , 수당 , 총급여(급여+수당) 을 출력하세요
select empno , ename , sal , comm , sal+comm as 총급여
from emp;
/*
null 이란 너셕
1. null 과의 모든 연산 결과는 null ex) null + 100 -> null 
2. null 이란 . . . . 함수 > mvl() , mvl2() 암기

ex) nvl(컬럼명 , 대체값) >> 치환

Tip)
Mysql   > null > IFNULL()   > select ifnull(null,' ')
MS-sql  > null > Convert()  
*/

select empno, ename ,sal , comm , sal+nvl(comm,0) as 총급여
from emp;

select 100 + null from dual;
select 1000 + nvl(null,0) from dual;
select comm , nvl(comm,111111) from emp;
select nvl(null,'hello world') from dual;

--사원의 급여가 1000이상이고 수당을 받지 않는 사원의 사번 , 이름 , 직종 , 급여 , 수당을 출력하세요.

select empno , ename , job , sal , comm
from emp
where sal>=1000 and comm is not null;

--문자열 검색
--주소겁색 >> 역삼 >> 역삼 단어가 있는 모든 주소가 나오는 것 
--Like 문자열 패턴 검색
--와일드 카드( %(모든것) , _ (한문자))

select *
from emp
where ename like '%A%'; --A를 포함하는 모든 이름

select *
from emp
where ename like 'A%'; --A로 시작하는 모든 이름 like '김%'

select *
from emp
where ename like '%E'; --E로 끝나는 모든 이름 



select *
from emp
where ename like '%LL%'; -- ALLEN , MILLER

select *
from emp
where ename like '%A%A%'; --A가 두개 들어 있는 모든 이름 ADAMS

select *
from emp
where ename like '_A%'; -- 2번째 글자는 A이고 뒤에는 상관없다 . . . WARD , MARTIN , JAMES

--정규표현식 regexp_like()
select * from emp where regexp_like(ename,'(A-C)');
--과제 (정규표현식 5개 만들기) 추후 카페에 올라가면 하세요.

--데이터 정렬하기
--order by 컬럼명 : 문자 , 숫자 , 날짜 정렬가능
--오름차순 : asc : 낮은순 : default
--내림차순 : desc : 높은순
--정렬 (알고리즘) >> 비용이 많이 드는 작업(cost)

select *
from emp
order by sal; -- default order by sal asc

select *
from emp
order by sal desc; -- 높은 순으로 정렬

--입사일이 가장 늦은 순으로 정렬해서 사번 , 이름 , 급여 , 입사일 출력하세요
--가장 최근에 입사한 순으로
select empno , ename , sal , hiredate
from emp
order by hiredate desc;

/*
Select 절    3
From 절      1
Where 절     2
order by 절  4
*/


select empno , ename , sal , job , hiredate
from emp
where job='MANAGER'
order by hiredate desc;


--emp에서 job과 deptno를 출력하는데 직업의 알파벳 순으로 정렬하고 각각 deptno가 높은 순으로 정렬
select job , deptno
from emp
order by job asc , deptno desc; --중요 (답변형 게시판 . . . 사용) >> grouping
--order by 컬럼명 asc , 컬럼명 asc ,  . . . . 



--연산자
--합집합 (union)       : 테이블과 테이블의 데이터를 합치는 것 (중복값을 배제)
--합집합 (union all)   : 테이블과 테이블의 데이터를 합치는 것 (중복값 허용)

create table uta(name varchar2(20));
insert into uta(name) values('AAA');
insert into uta(name) values('BBB');
insert into uta(name) values('CCC');
insert into uta(name) values('DDD');
commit;

create table ut(name varchar2(20));
insert into ut(name) values('AAA');
insert into ut(name) values('BBB');
insert into ut(name) values('CCC');
commit;

select * from uta;
select * from ut;

select * from ut
union
select * from uta;
--ut 집에 uta 식구들이 놀러가는 것 (중복 데이터 제거)

select * from ut
union all
select * from uta;
--ut 집에 uta 식구들이 놀러가는 것 (중복 데이터 제거X)

--union
--1. [대응]되는 [컬럼]의 타입이 동일해야 한다.

select empno , ename from emp       --숫자 , 문자열
union
select dname , deptno from dept;    --문자열 , 숫자

--emp 방에 dept 애들이 들어가는 것
select empno , ename from emp
union
select deptno , dname from dept;
--순서 나중에 subquery 를 사용해서 가상 테이블 ....
select *
from (
    select empno , ename from emp
    union
    select deptno , dname from dept
    ) m
order by m.empno desc; -- in-line view

--2. [대응]하는 컬럼의 개수가 동일
-- 필요악 (null) 컬럼의 대체
select empno, ename , job , sal from emp
union
select deptno , dname , loc , null from dept;
--------------------------------------------------------------------------------
--초급 개발자 의무적으로 해야 하는 코드 (단일 테이블 select)--------------------------
--오라클.pdf (47 page)
--------------------------------------------------------------------------------

show user;
select sysdate from dual; --날짜가 다시 돌아가 있다.
--alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

--문자열 함수
select initcap('the super man') from dual;

select lower('AAA') , upper('aaa') from dual;

select ename , lower(ename) as "ename" from emp;

select * from emp where lower(ename) = 'king';

select length('abcd') from dual; --문자열의 개수
select length('홍길동') from dual; -- 3개

select length('   홍 길 동a') from dual; --9개

select concat('a','b') from dual; --ab
--select concat('a','b','c') form dual;
select 'a' || 'b' || 'c' from dual; 

select concat(ename,job) from emp;
select ename || ' ' || job from emp;

--JAVA : substring
--ORACLE : substr

select substr('ABCDE',2,3) from dual; --BCD
select substr('ABCDE',1,1) from dual; --A
select substr('ABCDE',3,1) from dual; --C

select substr('asdfasdfasfaewf',3) from dual;

/*
사원테이블에서 ename 컬럼의 데이터에 대해서 첫글자는 소문자로 나머지 글자는 대문자로
출력하되 하나의 컬럼으로 만들어서 출력하고 컬럼의 별칭은 fullname 첫글자와 나머지
문자 사이에는 공백 하나를 넣으세요
*/

select lower(substr(ename,1,1)) || ' ' || upper(substr(ename,2)) as fullanem from emp;

select lpad('ABC',10,'*') from dual;

select rpad(substr('hong1004',1,2),length('hong1004'),'*') from dual;


--emp 테이블에서 ename 컬럼의 데이터를 출력하되 첫글자만 출력하고 나머지는 * 출력하세요
select rpad(substr(ename,1,1),length(ename),'*') from emp;

create table member2(
 id number,
 jumin varchar2(14)
);
insert into member2(id,jumin) values(100,'123456-1234567');
insert into member2(id,jumin) values(200,'234567-1234567');
commit;
 
select * from member2;

--출력결과
--100 : 123456-*******
--200 : 234567-*******

select id || ' : ' || rpad(substr(jumin,1,7),length(jumin),'*') as jumin from member2;


--rtrim
--오른쪽 문자를 지워라
select rtrim('MILLER','ER') from dual; --MILL 

--ltrim
--왼쪽 문자를 지워라
select ltrim('MILLLLLLLLER','MIL') from dual;

--공백제거
select '>' || rtrim('MILLER              ',' ') || '<' from dual;


--치환함수
select ename , replace(ename,'A','와우') from emp;
--------------------------------------------------------------------------------

--숫자함수
--    -3 -2 -1 0(정수) 1 2 3

--반올림함수
select round(12.345,0) as r from dual;
select round(12.567,0) as r from dual;

select round(12.345,1) as r from dual;
select round(12.345,-1) as r from dual;
select round(15.345,-1) as r from dual;
select round(12.345,-2) as r from dual;

--절삭함수
select trunc(12.345,0) as r from dual;
select trunc(12.567,0) as r from dual;

select trunc(12.345,1) as r from dual;
select trunc(12.345,-1) as r from dual;
select trunc(15.345,-1) as r from dual;
select trunc(12.345,-2) as r from dual;

--나머지
select 12/10 from dual; --1.2
select mod(12,10) from dual; --나머지 함수

select mod(0,0) from dual;

--------------------------------------------------------------------------------
--날짜 함수
select sysdate from dual;

select sysdate + 100 from dual;
select sysdate + 1000 from dual;
select sysdate - 1000 from dual;

select hiredate from emp;

select trunc(months_between('2022-9-27','2020-9-26'),0) from dual; --24개월

select trunc(months_between(sysdate,'2020-2-2'),0) from dual;

select '2023-01-01' + 100 from dual; --'2023-01-01' (날짜형식) 이지만 문자열
--문자를 날짜로 바꾸는 함수
select to_date('2023-01-01') + 100 from dual;

--  사원테이블에서 사원들의 입사일에서 현재날짜까지의 근속월수를 구하세요
--  사원이름, 입사일 , 근속월수 출력

select ename, hiredate , trunc(months_between(sysdate,hiredate),0) as 근속월수 from emp;

--한달이 31일이라고 가정하고 . . . 기준에서 근속월수를 구하세요
--함수는 사용하지 마세요 ( 반올림 하지 마세요 )

select trunc((sysdate-hiredate)/31,0) from emp;
--------------------------------------------------------------------------------
--문자함수 , 숫자함수 , 날짜함수 END ----------------------------------------------

--변환함수
select '100' + 100 from dual;
select to_number('100') + 100 from dual;

--변환시 표참조 (page 69 ~ 71 참조)
--형식 formant

select sysdate , to_char(sysdate,'YYYY')|| '년' as yyyy from dual;
select to_char(sysdate, 'YEAR') as YEAR from dual;

--입사일이 12월인 사원의 사번, 이름, 입사일, 입사년도, 입사월을 출력하세요
select empno , ename, hiredate , to_char(hiredate, 'YYYY') as 입사년도 , to_char(hiredate,'MM') as 입사월
from emp
where to_char(hiredate,'MM') = '12';

select '>' || to_char(12345,'999999999999999999999') || '<' from dual;

select '>' || ltrim(to_char(12345,'999999999999999999999')) || '<' from dual;

select '>' || to_char(12345,'$999,999,999,999,999') || '<' from dual;

select sal , to_char(sal,'$999,999') as 급여 from emp;

--HR계정 이동
show user;
--USER이(가) "HR" 입니다.
select * from employees;

/*
사원테이블 (employees) 에서 사원의 이름은 last_name , first_name 합쳐서 fullname 별칭
부여해서 출력하고 입사일은 YYYY-MM-DD 형식으로 출력하고 연봉(급여*12)을 구하고
연봉 10%(연봉 * 1.1) 인상한 값을
출력하고 그 결과는 1000단위 콤마 처리해서 출력하세요
단 2005년 이후 입사자들만 출력하세요 그리고 연봉이 높은 순으로 출력하세요
*/


select concat(last_name,first_name) as fullname , 
to_char(hire_date,'YYYY-MM-DD') as 입사일,
salary,
salary*12 as 연봉,
to_char(salary*12*1.1,'$999,999') as 급여인상
from employees
where to_char(hire_date,'YYYY') > 2005
order by 연봉 desc;

--다시 KOSA USER로
show user;

--Tip
select 'A' as a , 10 as b, null as c, empno
from emp;
--------------------------------------------------------------------------------
--문자 , 숫자 , 날짜 , 변환함수(to_...)
--------------------------------------------------------------------------------

--일반함수 (프로그래밍 성격이 강하다)

select comm , nvl(comm,0) from emp;

create table t_emp(
 id number(6), --정수 6자리
 job nvarchar2(20) -- unicode 영문자 , 한글 모두 2byte . . . . 20자 =>40바이트
);

desc t_emp;

insert into t_emp(id,job) values(100,'IT');
insert into t_emp(id,job) values(200,'SALES');
insert into t_emp(id,job) values(300,'MANAGER');
insert into t_emp(id,job) values(400);
insert into t_emp(id,job) values(500,'MANAGER');
COMMIT;

select * from t_emp;

select id,decode(id,100,'아이티',
                    200,'영업팀',
                    300,'관리팀',
                        '기타부서') as 부서이름
from t_emp;


select empno , ename , deptno , decode(deptno, 10 , '인사부',
                                               20 , '관리부',
                                               30 , '회계부',
                                               40 , '일반부서',
                                                    'ETC') as 부서이름
from emp;

create table t_emp2(
  id number(2),
  jumin char(7) --고정길이 문자열
);

desc t_emp2;

insert into t_emp2(id,jumin) values(1,'1234567');
insert into t_emp2(id,jumin) values(2,'2234567');
insert into t_emp2(id,jumin) values(3,'3234567');
insert into t_emp2(id,jumin) values(4,'4234567');
insert into t_emp2(id,jumin) values(5,'5234567');
commit;

select * from t_emp2;

select id,jumin,decode(substr(jumin,1,1), 1 , '남성',
                                          2 , '여성',
                                          3 , '중성',
                                              '기타') as 성별
from t_emp2;


/*
응용문제 : hint) if문 안에 if문
부서번호가 20번인 사원중에서 SMITH 라는 이름을 가진 사원이라면 HELLO 문자 출력하고
부서번호가 20번인 사원중에서 SMITH 라는 이름을 가진 사원이 아니라면 WORLD 문자 출력
부서번호가 20번인 사원이 아니라면 ETC라는 문자를 출력하세요
EMP 테이블에서 . . . 
*/
select deptno,ename,decode(deptno , 20 , decode(ename , 'SMITH' , 'HELLO','WORLD')
                                       , 'ETC')
from emp;


--CASE 문

create table t_zip(
    zipcode number(10)
);

desc t_zip;

insert into t_zip(zipcode) values(2);
insert into t_zip(zipcode) values(31);
insert into t_zip(zipcode) values(32);
insert into t_zip(zipcode) values(41);
commit;

select * from t_zip;


select '0' || to_char(zipcode) , case zipcode when 2 then '서울'
                                              when 31 then '경기'
                                              when 41 then '제주'
                                              else '기타'
                                 end 지역이름
from t_zip;


/*
사원테이블에서 사원급여가 100달러 이하면 4급
1001달러 2000달러 이하면 3급
2001달러 3000달러 이하면 2급
3001달러 4000달러 이하면 특급이라는 데이터를 출력하세요

1.
CASE 컬럼명 WHEN 결과1 THEN 출력1

2. 
조건식이 필요하다면
CASE WHEN 조건 비교식 THEN
     WHEN 조건 비교식 THEN
END
*/

select * from emp;

select ename , sal , case when (sal<100) then '4급'
                              when sal between 1001 and 2000 then '3급'
                              when sal between 2001 and 3000 then '2급'
                              when sal between 3001 and 4000 then '특급'
                     end 급수
from emp;

--------------------------------------------------------------------------------
--문자함수 , 숫자함수 , 날짜함수 , 변환함수(to_) , 일반함수 (nvl , decode , case) END-
--------------------------------------------------------------------------------

--집계함수(그룹)
--75page
--count(*) ⇒ row 수 , count(컬럼명) ⇒ 데이터 건수

select count(*) from emp; --14개의 row

select count(empno) from emp; --14건

select count(comm) from emp; --6 (null이 아닌 데이터만 counting)

select count(nvl(comm,0)) from emp; --14건

--급여의 합
select sum(sal) from emp;

select trunc(avg(sal)) from emp;

--사장님 . . . 총 수당이 얼마나 지급되었나
select sum(comm) from emp;
--null에 대한 고민
--수당의 평균은 얼마지 ?
select trunc(avg(comm),0) from emp; --721
select (300+200+30+300+3500+0)/6 from dual; --721
select comm from emp;

--사원수 기준
select (300+200+30+300+3500+0)/14 from dual; --309
select trunc(avg(nvl(comm,0))) from emp; --309

select max(sal) from emp;
select min(sal) from emp;

select sum(sal) , avg(sal) , max(sal) , min(sal) , count(*) , count(sal)
from emp;

select empno , count(empno) from emp;

--부서별 평균 급여를 구하세요
select deptno , avg(sal)
from emp
group by deptno;

--직종별 평균 급여를 구하세요
select job , avg(sal)
from emp
group by job;

select avg(sal)
from emp
group by job; --문법적인 오류 없어요 ( 하지만 판단 할 수 없다 )

select job, sum(sal) , avg(sal) , max(sal) , min(sal) , count(*) , count(sal)
from emp
group by job;


--부서별 , 직종별 급여의 합을 구하세요

select deptno , job , sum(sal),count(sal)
from emp
group by deptno , job
order by deptno; --부서번호 ... 그 안에서 직종별 그룹 ... 합계

/*
select 절    4
from 절      1
where 절     2
group by 절  3
order by 절  5
*/

--직종별 평균급여가 3000달러 이상인 사원의 직종과 평균급여를 출력하세요
select job , avg(sal) as avgsal
from emp
--where avg(sal) > 3000
group by job
having avg(sal) >= 3000;


select * from emp;
--quiz 1
select job,ename, sum(sal)
from emp
where comm is not null
group by job,ename
having sum(sal) >= 5000
--having comm is not null
order by sum(sal);


--quiz 2
select deptno , count(deptno) as 부서인원, sum(sal) as "부서별 급여의 합"
from emp
group by deptno
having count(deptno)>4;
--select count(*) from emp where job is null; -- null 여부 확인하자

--quiz 3
select job, sum(sal)
from emp
where job not in ('SALESMAN')
group by job
having sum(sal)>5000
order by sum(sal) desc;

select * from employees;

desc employees;
--quiz 4
select employee_id, last_name, hire_date, job_id, salary, department_id
from employees
where to_char(hire_date, 'YYYY-MM-DD') > '2005-01-01'
AND department_id is not null
AND salary between 5000 and 10000
order by department_id ASC , salary desc;

--quiz 5
select department_id, MAX(salary), MIN(salary), max(salary) - min(salary) as difference
from employees
where department_id is not null
--and count(department_id) >= 2
group by department_id
having count(*) >=2
order by department_id;


--------------------------------------------------------------------------------
--ETC
--create table 테이블명 ( 컬럼명 타입, 컬럼명 타입)
create table member3(age number);

--데이터 1건
insert into member3(age) value(100);

--데이터 여러건
insert into member3(age) value(100);
insert into member3(age) value(200);
insert into member3(age) value(300);

--------------------------------------------------------------------------------

--데이터 타입

--오라클 함수 ......
select * from SYS.NLS_DATABASE_PARAMETERS;
--NLS_CHARACTERSET  : 	AL32UTF8  한글 3byte 인식
--KO16KSC5601 2Byte (현재 변환하면 한글 다깨짐)
select * from nls_database_parameters where parameter like '%CHAR%';
------------------------------------------------------------------------------
create table test2(name varchar2(2));

insert into test2(name) values('a');
insert into test2(name) values('aa');
insert into test2(name) values('가'); --한글 1자 3byte 인지

-------------------------------------------------------------------------------
?--JOIN ( 하나 이상의 테이블에서 데이터 가져오기 )
--신입에게 요구하는 기술
--create table M (M1 char(6) , M2 char(10));
--create table S (S1 char(6) , S2 char(10));
--create table X (X1 char(6) , X2 char(10));
--
--insert into M values('A','1');
--insert into M values('B','1');
--insert into M values('C','3');
--insert into M values(null,'3');
--commit;
--
--insert into S values('A','X');
--insert into S values('B','Y');
--insert into S values(null,'Z');
--commit;
--
--insert into X values('A','DATA');
--commit;

select * from M;
select * from S;
select * from X;


--1. 등가조인(equi join)

--오라클 문법
select m.m1 , m.m2 , s.s2
from m, s
where m.m1 = s.s1;

--ANSI 문법
select m.m1 , m.m2 , s.s2
from m join s
on m.m1 = s.s1;

select * from emp;

select * from dept;


--사원번호 , 사원이름 , 부서번호 , 부서이름을 출력하세요 (ANSI)
select emp.empno, emp.ename, emp.deptno , dept.dname
from emp join dept
on emp.deptno = dept.deptno;

--현업(테이블 가명칭 부여)
select e.empno, e.ename , e.deptno , d.dname
from emp e join dept d
on e.deptno = d.deptno;


--***조인은 select * 처리하고 나서 컬럼을 명시한다.
select s.s1 , s.s2 , x.x2
from s join x
on s.s1 = x.x1;

select sysdate from dual;
--------------------------------------------------------------------------------
--SQL JOIN 문법 (단순)
select *
from m, s, x
where m.m1 = s.s1 and s.s1 = x.x1;

--ANSI 문법(권장)
select *
from m join s on m.m1 = s.s1
       join x on s.s1 = x.x1;
--------------------------------------------------------------------------------
--HR 이동
SHOW USER;
select * from employees;
select * from departments;
select * from locations;

select count(*) from employees;
--사번 , 이름(last_name) , 부서번호 , 부서이름을 출력하세요
select e.employee_id, e.first_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id=d.department_id;
--106명 . . .
select * from employees where department_id is null;

--사번 , 이름(last_name) , 부서번호 , 부서이름, 지역코드 , 도시명을 출력하세요
select e.employee_id, e.last_name, e.department_id, d.department_name, d.location_id, l.city
from employees e join departments d on e.department_id = d.department_id
                 join locations l on d.location_id = l.location_id;
                 
                 
--KOSA 계정 이동
SHOW USER;

--비등가조인 (컬럼이 매치되는 게 없다)
select * from emp;
select * from salgrade;


select *
from emp e join salgrade s 
on e.sal between s.losal and s.hisal;


--outer join (equi 조인이 선행되고 나서 => 남아있는 데이터를 가져오는 방법)

select *  
from m left outer join s
on m.m1 = s.s1;

select *
from m right outer join s
on m.m1 = s.s1;

select *
from m full outer join s
on m.m1 = s.s1;

--사번 , 이름(last_name) , 부서번호 , 부서이름을 출력하세요
--select e.employee_id, e.first_name, e.department_id, d.department_name
--from employees e join departments d
--on e.department_id=d.department_id;

--누락자 없게 . . 아우터 조인 활용하여
select e.employee_id, e.first_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id=d.department_id;

--현업 데이터 (null 고민 JOIN >> outer join)
select * from employees where department_id is null; --조금있다가 >> outer join

--self join

select * from emp;
--SMITH 사원의 사수 이름
--사원테이블 , 관리자테이블 만드는 것이 . . . . 중복 데이터 . . .
select e.empno , e.ename , m.empno , m.ename
from emp e join emp m
on e.mgr = m.empno;
--13명 . . .
--14명 . . . >> outer join

select e.empno , e.ename , m.empno , m.ename
from emp e left join emp m
on e.mgr = m.empno;

select count(*) from emp where mgr is null;
--------------------------------------------------------------------------------
select * from emp;
select * from dept; 
-- 1. 사원들의 이름, 부서번호, 부서이름을 출력하라.
select e.ename , e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno;
?
-- 2. DALLAS에서 근무하는 사원의 이름, 직위, 부서번호, 부서이름을 출력하라.
select e.ename , e.job, e.deptno , d.dname
from emp e join dept d on e.deptno = d.deptno
where d.loc = 'DALLAS';

-- 3. 이름에 'A'가 들어가는 사원들의 이름과 부서이름을 출력하라.
select e.ename, d.dname
from emp e join dept d
on e.deptno = d.deptno
where e.ename like '%A%'; 
?
-- 4. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을
--출력하는데 월급이 3000이상인 사원을 출력하라.
select e.ename , d.dname, e.sal
from emp e join dept d
on e.deptno = d.deptno
where e.sal > 3000;
?

-- 5. 직위(직종)가 'SALESMAN'인 사원들의 직위와 그 사원이름, 그리고
-- 그 사원이 속한 부서 이름을 출력하라.
select e.ename , d.dname, e.job
from emp e join dept d
on e.deptno = d.deptno
where e.job='SALESMAN';
?

-- 6. 커미션이 책정된 사원들의 사원번호, 이름, 연봉, 연봉+커미션,
-- 급여등급을 출력하되, 각각의 컬럼명을 '사원번호', '사원이름',
-- '연봉','실급여', '급여등급'으로 하여 출력하라.
--(비등가 ) 1 : 1 매핑 대는 컬럼이 없다
select * from salgrade;

select e.empno as "사원번호", e.ename as "사원이름", e.sal*12 as "연봉", (e.sal*12)+e.comm as "실급여", s.grade as "급여등급"
from emp e join salgrade s
on e.sal between s.losal and s.hisal;
?

-- 7. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름,
-- 월급, 급여등급을 출력하라.
select e.deptno, d.dname, e.ename, e.sal, s.grade
from emp e join dept d on e.deptno = d.deptno
           join salgrade s on e.sal between s.losal and s.hisal
where e.deptno = 10;


-- 8. 부서번호가 10번, 20번인 사원들의 부서번호, 부서이름,
-- 사원이름, 월급, 급여등급을 출력하라. 그리고 그 출력된
-- 결과물을 부서번호가 낮은 순으로, 월급이 높은 순으로
-- 정렬하라.
select e.deptno, d.dname, e.ename, e.sal, s.grade
from emp e join dept d on e.deptno = d.deptno
           join salgrade s on e.sal between s.losal and s.hisal
where e.deptno in (10,20)
order by e.deptno , e.sal desc;
?
-- 9. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의
-- 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호',
-- '사원이름', '관리자번호', '관리자이름'으로 하여 출력하라.
--SELF JOIN (자기 자신테이블의 컬럼을 참조 하는 경우)
select e.empno, e.ename, m.empno , m.ename
from emp e left join emp m
on e.mgr = m.empno;

--------------------------------------------------------------------------------
--사원테이블에서 사원들의 평균 월급보다 더 많은 월급을 받는 사원의 사번, 이름, 급여를 출력하세요
select avg(sal) from emp; 2073

select empno, ename , sal
from emp
where sal > 2073;


--2개의 쿼리 통합 (하나의 쿼리)

select empno, ename , sal
from emp
where sal > select avg(sal) from emp;

--subquery

--사원 테이블에서 jones 의 급여보다 더 많은 급여를 받는 사원의 사번, 이름, 급여를 출력하세요
select sal from emp where ename = 'JONES';

select *
from emp
where sal > (select sal from emp where ename = 'JONES');

--부서번호가 30번인 사원과 같은 급여를 받는 모든 사원의 정보를 출력하세요
select * from emp;
select sal from emp where deptno = 30; --multi row

select *
from emp
where sal in (select sal from emp where deptno = 30);
--sal=1600 or sal=1250 or . . . . .


--부서번호가 30번인 사원과 다른 급여를 받는 모든 사원의 정보를 출력하세요
select *
from emp
where sal not in (select sal from emp where deptno = 30);
--sal != 1600 and sal != 1250 . . . 

--부하직원이 있는 사원의 사번과 이름을 출력하세요
select mgr from emp;

select *
from emp
where empno in (select mgr from emp);

--부하직원이 없는 사원의 사번과 이름을 출력하세요
select *
from emp
where empno not in (select nvl(mgr,0) from emp);
--empno != 7902 and empno != 7698 . . . and null >> null

--king 에게 보고하는 (즉 직속상관)이 king 인 사원의 사번, 이름 , 직종, 관리자사번 을 출력하세요
select empno from emp where ename = 'KING';

select empno, ename, job, mgr
from emp
where mgr = (select empno from emp where ename = 'KING');

--20번 부서의 사원중에서 가장 많은 급여를 받는 사원보다 더 많은 급여를 받는 사원의
--사번, 이름, 급여, 부서번호를 출력하세요

select max(sal) from emp where deptno=20;

select empno, ename, sal, deptno
from emp
where sal > (select max(sal) from emp where deptno=20);



--스칼라 서브 쿼리
select e.empno , e.ename , e.deptno ,(select d.dname from dept d where d.deptno = e.deptno) as dept_name
from emp e
where e.sal >= 3000;

--실무에서 많이 사용

--자기 부서의 평균 월급보다 더 많은 월급을 받는 사원의 사번, 이름, 부서번호, 부서별 평균월급을 출력하세요
--hint1)만약에 부서번호와 부서의 평균 월급을 담고있는 테이블이 있다면 (메모리에)
--hint2)in line view
select * from emp;
select * from dept;

select deptno, avg(sal) as avgsal from emp;

select e.empno, e.ename, e.deptno, m.avgsal , e.sal
from emp e join (select deptno, trunc(avg(sal),0) as avgsal from emp group by deptno) m
on e.deptno = m.deptno
where e.sal > m.avgsal;


--------------------------------------------------------------------------------
--subquery END------------------------------------------------------------------

--1. 'SMITH'보다 월급을 많이 받는 사원들의 이름과 월급을 출력하라.
select sal from emp where ename = 'SMITH';

select ename, sal
from emp
where sal > (select sal from emp where ename = 'SMITH');
?
--2. 10번 부서의 사원들과 같은 월급을 받는 사원들의 이름, 월급,
-- 부서번호를 출력하라.
select sal from emp where deptno=10;

select ename, sal, deptno
from emp
where sal IN (select sal from emp where deptno=10);

--3. 'BLAKE'와 같은 부서에 있는 사원들의 이름과 고용일을 뽑는데
-- 'BLAKE'는 빼고 출력하라.
select * from emp;

select deptno from emp where ename = 'BLAKE';

select ename, hiredate
from emp
where deptno = (select deptno from emp where ename = 'BLAKE') and ename != 'BLAKE';
?

--4. 평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을

-- 출력하되, 월급이 높은 사람 순으로 출력하라.

select trunc(avg(sal)) as avgsal from emp;

select empno, ename, sal
from emp
where sal > (select trunc(avg(sal)) as avgsal from emp)
order by sal desc;

--5. 이름에 'T'를 포함하고 있는 사원들과 같은 부서에서 근무하고
-- 있는 사원의 사원번호와 이름을 출력하라.
select deptno from emp where ename like '%T%';

select empno, ename
from emp
where deptno in (select deptno from emp where ename like '%T%');
?
--6. 30번 부서에 있는 사원들 중에서 가장 많은 월급을 받는 사원보다
-- 많은 월급을 받는 사원들의 이름, 부서번호, 월급을 출력하라.
--(단, ALL(and) 또는 ANY(or) 연산자를 사용할 것)
select max(sal) from emp where deptno = 30;
?
select ename, empno, sal
from emp
where sal > (select max(sal) from emp where deptno = 30);
?
select ename, empno, sal
from emp
where sal > ALL(select sal from emp where deptno=30);

--? 7. 'DALLAS'에서 근무하고 있는 사원과 같은 부서에서 일하는 사원의
-- 이름, 부서번호, 직업을 출력하라.
select * from dept;
select * from emp;

select deptno from dept where loc='DALLAS';

select ?ename, deptno, job
from emp
where deptno in (select deptno 
                 from dept 
                 where loc='DALLAS');

SELECT ENAME, DEPTNO, JOB
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO    -- = 이 맞는데  IN
                FROM DEPT
                WHERE LOC='DALLAS');
                
--8. SALES 부서에서 일하는 사원들의 부서번호, 이름, 직업을 출력하라.
select * from emp;
?
select e.deptno, e.ename, e.job
from emp e join dept d on e.deptno = d.deptno
where dname = 'SALES';

?
--9. 'KING'에게 보고하는 모든 사원의 이름과 급여를 출력하라
--king 이 사수인 사람 (mgr 데이터가 king 사번)
select * from emp;
?
select ename, sal
from emp
where mgr = (select empno from emp where ename = 'KING');
?

--10. 자신의 급여가 평균 급여보다 많고, 이름에 'S'가 들어가는
-- 사원과 동일한 부서에서 근무하는 모든 사원의 사원번호, 이름,
-- 급여를 출력하라.

select trunc(avg(sal)) from emp;

select empno, ename, sal
from emp
where sal > (select avg(sal) from emp)
and deptno in (select deptno from emp where ename like '%S%');


--11. 커미션을 받는 사원과 부서번호, 월급이 같은 사원의
-- 이름, 월급, 부서번호를 출력하라.
select deptno, sal from emp where comm is not null;

select ename, sal, empno
from emp
where deptno in (select deptno from emp where comm is not null)
and sal in (select sal from emp where comm is not null);


--12. 30번 부서 사원들과 월급과 커미션이 같지 않은
-- 사원들의 이름, 월급, 커미션을 출력하라.
select sal,comm
from emp
where deptno = 30;

select ename, sal, comm
from emp
where sal not in (select sal
                  from emp
                  where deptno = 30)
and comm not in (select comm
                  from emp
                  where deptno = 30 
                  and comm is not null);
 
--------------------------------------------------------------------------------
--기본적인 DML 구문 ( 암기 필수 )
 
select * from tab; --사용자(KOSA) 계정이 가지고 있는 테이블 목록
  
--내가 테이블을 생성 . . .그 이름이 있는 지 없는 지
select * from tab where tname='BOARD';
select * from tab where tname='EMP';

select * from col where tname='EMP';
--------------------------------------------------------------------------------
--insert , update , delete 무조건 암기

--1. INSERT
create table temp(
    id number primary key, --not null , unique한 데이터만 받겠다. (회원ID , 주민번호)
    name varchar(20)
);

desc temp;

--1. 일반적이 insert 구문
insert into temp(id,name)
values(100,'홍길동');

--commit , rollback 하기 전까진 실반영 X
select *from temp;
commit;

--2. 컬럼 목록 생략 (insert)   ← 되도록이면 쓰지 말자
insert into temp
values(200,'김유신');

select * from temp;
rollback;

--3. 문제 . . . insert
insert into temp(name)
values('아무개');
--자동으로 id 컬럼 => null >> PK 에 걸림 ORA-01400: cannot insert NULL into ("KOSA"."TEMP"."ID")

insert into temp(id,name)
values(100,'개똥이');
--PK >> id >> 중복 데이터(x) >> ORA-00001: unique constraint (KOSA.SYS_C007000) violated

insert into temp(id,name)
values(200,'정상이');

select * from temp;
commit;

create table temp2(id varchar2(50));

desc temp2;

--PL-SQL
--for(int i=1; i<=100; i++){ }
--
--begin
--    for i in 1..100 loop   
--        insert into temp2(id) values('A' || to_char(i));
--    end loop;
--end;

select * from temp2;

create table temp3(
    memberid number(3) not null, --3자리 정수
    name varchar2(10), --null 허용
    regdate date default sysdate --테이블 기본값 설정 (insert 하지 않으면 자동으로 [날짜]) 들어가게 하겠다.
);

desc temp3;

select sysdate from dual;

--1. 정상
insert into temp3(memberid, name, regdate)
values(100,'홍길동','2023-04-19');

select * from temp3;
commit;

--2. 날짜 생략
insert into temp3(memberid,name)
values(200,'김유신'); --default sysdate

select * from temp3;
commit;

--3. 컬럼 하나만
insert into temp3(memberid)
values(300);

select * from temp3;
commit;

--4. 오류
insert into temp3(name)     -- id null 값 >> not null
values('나누구');

--------------------------------------------------------------------------------
--Tip)
create table temp4(id number);
create table temp5(num number);

desc temp4;
desc temp5;

insert into temp4(id) values(1);
insert into temp4(id) values(2);
insert into temp4(id) values(3);
insert into temp4(id) values(4);
insert into temp4(id) values(5);
insert into temp4(id) values(6);
insert into temp4(id) values(7);
insert into temp4(id) values(8);
insert into temp4(id) values(9);
insert into temp4(id) values(10);
commit;

select * from temp4;
--대량 데이터 삽입하기
select * from temp5;
--temp4 테이블에 있는 모든 데이터를 temp5에 넣고 싶어요.(타입만 일치하면)
--insert into 테이블명(컬럼리스트) values(값)
--insert into 테이블명(컬럼리스트) select 절 *************************
 insert into temp5(num)
 select id from temp4; --대량 데이터 삽입
 
 select * from temp5;
 commit;

--2. 대량 데이터 삽입하기
-- 데이터를 담을 테이블도 없고 >> 테이블 구조(복제):스키마 + 데이터 삽입
-- 단 제약정보는 복제할 수 없다 (PK , FK , not null 등등)
-- 순수한 데이터 구조 + 데이터

create table copyemp
as
    select * from emp;
    
select * from copyemp;

create table copyemp2
as
    select empno, ename, sal
    from emp
    where deptno=30;
    
select * from copyemp2;


--토막 퀴즈
--틀만(스키마) 복제 데이터는 복사하고 싶지 않아요
create table copyemp3
as
    select * from emp where 1=2;
    
select * from copyemp3;

--------------------------------------------------------------------------------
--INSERT END--------------------------------------------------------------------

--UPDATE
select * from copyemp;

update copyemp
set sal = 0;

rollback;

update copyemp
set sal = 1111
where deptno = 20;

select * from copyemp;
commit;
 
update copyemp
set sal = (select sum(sal) from emp);

select * from copyemp;
rollback;

update copyemp
set ename = 'AAA' , job = 'BBB' , hiredate = sysdate , sal = (select sum(sal) from emp)
where empno = 7788;

select * from copyemp where empno=7788;
commit;
--------------------------------------------------------------------------------
--DELETE
delete from copyemp;
select * from copyemp;

rollback;

--조건가지고 지우기
delete from copyemp
where deptno=20;

select * from copyemp where deptno=20;
commit;
--------------------------------------------------------------------------------
--DELETE END--------------------------------------------------------------------

--DDL

select * from tab;

select * from tab where tname = lower('board');

create table board(
    boardid number,
    title nvarchar2(50),
    content nvarchar2(2000),
    regdate date
);
 
desc board;
--Tip)
select * from user_tables where lower(table_name) = 'board';
select * from col where lower(tname) = 'board';
--제약정보 확인하기 (반드시)
select * from user_constraints where lower(table_name) = 'emp';




