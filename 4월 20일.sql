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

-- oracle 11g >> 실무 >> 가상컬럼(조합컬럼)
-- 학생 성적 테이블(국어 , 영어 , 수학)
-- 합계 , 평균 ...
-- 학생 성적 테이블(국어 , 영어 , 수학, 평균)
-- 각각의 점수 변화 >> 평균값도 변화 보장되어야 함

create table vtable(
    no1 number,
    no2 number,
    no3 number GENERATED ALWAYS as (no1 + no2) VIRTUAL
);

select * from col where lower(tname) = 'vtable';

insert into vtable(no1,no2) values(100,50);
select * from vtable;

--insert into vtable(no1,no2,no3) values(10,20,30);

--실무에서 활용되는 코드
--제품정보 (입고) : 분기별 데이터 추출(4분기)
create table vtable2(
  no number, --순번
  p_code char(4), --제품코드(A001, B003)
  p_date char(8), --입고일 (20230101)
  p_qty number, --수량
  p_bungi number(1) GENERATED ALWAYS as (
                                            case when substr(p_date,5,2) in ('01','02','03') then 1
                                                 when substr(p_date,5,2) in ('04','05','06') then 2
                                                 when substr(p_date,5,2) in ('07','08','09') then 3
                                            else 4
                                            end
                                         ) VIRTUAL
);

select * from col where lower(tname) = 'vtable2';

insert into vtable2(p_date) values('20220101');
insert into vtable2(p_date) values('20220522');
insert into vtable2(p_date) values('20220601');
insert into vtable2(p_date) values('20221111');
insert into vtable2(p_date) values('20221201');
commit;

select * from vtable2 where p_bungi = 2;

select * from vtable2;
--------------------------------------------------------------------------------
--1. 테이블 생성하기
create table temp6(id number);

desc temp6;

--2. 테이블 생성 후에 컬럼 추가하기
alter table temp6
add ename varchar2(20);

desc temp6

--3. 기존 테이블에 있는 컬럼이름 잘못 표기 (ename -> username)
--기존 테이블에 있는 기존 컬럼명을 바꾸기 (rename)
alter table temp6
rename column ename to username;

--4. 기존 테이블에 있는 기존 컬럼의 타입 크기 수정 (기억) modify
alter table temp6
modify (username varchar2(2000));

desc temp6;

--5. 기존 테이블에 기존 컬럼 삭제
alter table temp6
drop column username;

desc temp6;
--모든 작업은 TOOL 에서 가능 . . .

--테이블 삭제
drop table temp6;

desc temp6; --ORA-04043: temp6 객체가 존재하지 않습니다.

--------------------------------------------------------------------------------

--테이블에 제약 걸기

--제약확인
select * from user_constraints where table_name = 'EMP';

create table temp7(
    --id number primary key 권장하지 않아요 (제약의 이름이 자동설정 ... 제약 편집 ...)
    id number constraint pk_temp7_id primary key, --개발자가 제약 이름 : pk_temp7_id
    name varchar2(20) not null , 
    addr varchar2(50)
);

desc temp7;
select * from user_constraints where lower(table_name)='temp7';

insert into temp7(name,addr) values('홍길동','서울시 강남구');
--ORA-01400: cannot insert NULL into ("KOSA"."TEMP7"."ID")

insert into temp7(id,name,addr) values(10,'홍길동','서울시 강남구');
select * from temp7;
commit;

insert into temp7(id,name,addr) values(10,'야무지개','서울시 강남구');
--ORA-00001: unique constraint (KOSA.PK_TEMP7_ID) violated

--UNIQUE

create table temp8(
    id number constraint pk_temp8_id primary key, --개발자가 제약 이름 : pk_temp7_id
    name varchar2(20) not null , 
    jumin nvarchar2(6) constraint uk_temp8_jumin unique,
    addr varchar2(50)
);
select * from user_constraints where lower(table_name)='temp8';

insert into temp8(id,name,jumin,addr)
values(10,'홍길동',123456,'경기도');

select * from temp8;

insert into temp8(id,name,jumin,addr)
values(20,'길동',123456,'서울');
--ORA-00001: unique constraint (KOSA.UK_TEMP8_JUMIN) violated

insert into temp8(id,name,addr)
values(20,'길동','서울'); --unique 제약은 null 허용

select * from temp8;

--그럼 null도 중복체크(아니요)
insert into temp8(id,name,addr)
values(30,'순신','서울');

select * from temp8;
commit;


--not null 가져가고 싶으면
--jumin nvarchar2(6) not null constraint uk_temp8_jumin unique,

--테이블 생성 후에 제약 걸기(추천)
create table temp9(id number);
--기존 테이블에 제약 추가하기 (대부분의 툴이 이 방법)
alter table temp9
add constraint pk_temp9_id primary key(id);

select * from user_constraints where lower(table_name)='temp9';

--create table temp9(id number, num number)
--alter table temp9
--add constraint pk_temp9_id primary key(id,num); -- 복합키
--유일한 한개의 row >> where id=100 and num=1

--컬럼추가
alter table temp9
add ename varchar2(50);

desc temp9;

--ename 칼럼에 not null 추가
alter table temp9
modify(ename not null);

desc temp9; --ENAME NOT NULL VARCHAR2(50)

--------------------------------------------------------------------------------
--check 제약 (업무 규칙 : where 조건을 쓰는 것 처럼)
--Where gender in ('남' , '여')
create table temp10(
    id number constraint pk_temp10_id primary key,
    name varchar2(20) not null,
    jumin char(6) not null constraint uk_temp10_jumin unique,
    addr varchar2(30),
    age number constraint ck_temp10_age check(age >= 19) --where age >=19
);

select * from user_constraints where table_name = 'TEMP10';

insert into temp10(id,name,jumin,addr,age)
values(100,'홍길동','123456','서울시 강남구',20);

insert into temp10(id,name,jumin,addr,age)
values(200,'아무개','234567','서울시 강남구',18);
--ORA-02290: check constraint (KOSA.CK_TEMP10_AGE) violated


select * from temp10;

--------------------------------------------------------------------------------
--FORIGN KEY(FK) : 열과 참조된 열 사이의 외래키 관계를 적용하고 설정합니다.
--참조제약 (테이블과 테이블과의 관계 설정)

create table c_emp
as
    select empno , ename , deptno from emp where 1=2;
    
select * from c_emp;

create table c_dept
as
    select deptno , dname from dept where 1=2;
    
select * from c_dept;

desc c_emp;
desc c_dept;
--c_emp 테이블에 있는 deptno 컬럼의 데이터는 c_dept 테이블에 있는 deptno 컬럼에 있는 데이터만
--쓰겠다

--강제 (FK)

--c_dept 의 deptno 컬럼이 신용이 없어요 (PK나 UNIQUE)
--alter table c_emp
--add constraint fk_c_emp_deptno foreign key(deptno) references c_dept(deptno);

alter table c_dept
add constraint pk_c_dept_deptno primary key(deptno);

--그리고 나서 참조제약
alter table c_emp
add constraint fk_c_emp_deptno foreign key(deptno) references c_dept(deptno);


select * from user_constraints where table_name = 'C_DEPT';
select * from user_constraints where table_name = 'C_EMP';


--부서
insert into c_dept(deptno,dname) values(100,'인사팀');
insert into c_dept(deptno,dname) values(200,'관리팀');
insert into c_dept(deptno,dname) values(300,'회계팀');
commit;

select * from c_dept;

--신입사원 입사
insert into c_emp(empno,ename,deptno)
values(1,'신입이',100);

select * from c_emp;

insert into c_emp(empno,ename,deptno)
values(2,'아무개',101);
--ORA-02291: integrity constraint (KOSA.FK_C_EMP_DEPTNO) violated - parent key not found

commit;
--------------------------------------------------------------------------------
--제약 END----------------------------------------------------------------------

--개발자 관점에서 FK 살펴보기--
--MASTER DETAIL 관계
--부모 - 자식 관계

--c_emp과 c_dept (관계 FK) >> c_emp(deptno) 컬럼이 c_dept(deptno) 컬럼을 참조
--FK 관계 : master(c_dept) - detail(c_emp) >> 화면 (부서 출력) >> 부서번호 클릭 >> 사원정보 출력
--deptno 참조 관계 부모(c_dept) - 자식(c_emp)

--관계 PK가지고 있는 쪽 (master) , FK (detail)

select * from c_dept;

select * from c_emp;

--1. 위 상황에서 c_emp 테이블에 있는 신입이를 삭제할 수 있을 까요? 
delete from c_dept where deptno=100;
delete from c_emp where empno=100;

delete from c_dept where deptno=200; -- 삭제 가능 (c_emp가 빌려쓰고 있지 않아요)

delete from c_dept where deptno=100;
delete from c_emp where empno=1; -- 참조하지 않게 . . . .

--자식 삭제
--부모 삭제 하시면 됩니다.
commit;

/*
column datatype [CONSTRAINT constraint_name]
 REFERENCES table_ name (column1[,column2,..] [ON DELETE CASCADE])
 
 ON DELETE CASCADE 부모 테이블과 생명을 같이 하겠다
 
 alter table c_emp
 add constraint fk_c_emp_deptno foreign key(deptno) fererences c_dept(deptno) on delete cascade;
 
 delete from c_emp where empno=1 >> deptno >> 100번
 
 delete from c_dept where deptno=100; 삭제 안되요 (참조하고 있으니까)
 on delete cascade 걸면 삭제되요
 
 부모삭제 >> 참조하고 있는 자식도 삭제
 
 Oracle
 ON DELETE CASCADE 만 존재
 
 MS-SQL
 ON DELETE CASCADE
 ON UPDATE CASCADE
*/


create table grade(
    stuno number constraint pk_grade_stuno primary key,
    name varchar2(10) not null ,
    kor number default 0,
    eng number default 0,
    math number default 0,
    deptno number,
    total number GENERATED ALWAYS as (kor+eng+math) VIRTUAL,
    avg number GENERATED ALWAYS as ((kor+eng+math)/3) VIRTUAL
);
select * from grade;

create table stu_dept(
    deptno number constraint pk_dept_deptno primary key,
    dname varchar2(10) not null
);
select * from stu_dept;

insert into grade(kor,eng,math,stuno,name,deptno) values(10,20,30,400,'홍길동',10);
insert into grade(kor,eng,math,stuno,name,deptno) values(44,22,33,500,'길동',20);
insert into grade(kor,eng,math,stuno,name,deptno) values(55,66,33,600,'동',30);

insert into stu_dept(deptno,dname) values(10,'컴퓨터');
insert into stu_dept(deptno,dname) values(20,'기계');
insert into stu_dept(deptno,dname) values(30,'전자');

alter table grade
add constraint fk_grade_deptno foreign key(deptno) references stu_dept(deptno);


select g.stuno, g.name, g.total, g.avg, g.deptno, s.dname
from grade g join stu_dept s
on g.deptno = s.deptno;

--------------------------------------------------------------------------------
--여기까지가 초급 과정 END--
--제 12장 VIEW (초중급)
--가상 테이블 (subquery >> in line view >> from())
--필요한 가상테이블을 객체형태로 만들기 (염속적으로)

/*
CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW view_name [(alias[,alias,...])]
AS Subquery 
[WITH CHECK OPTION [CONSTRAINT constraint ]]
[WITH READ ONLY]

옵션
OR REPLACE 이미 존재한다면 다시 생성한다.
FORCE Base Table 유무에 관계없이 VIEW 을 만든다.
NOFORCE 기본 테이블이 존재할 경우에만 VIEW 를 생성한다.
view_name VIEW 의 이름
Alias Subquery 를 통해 선택된 값에 대한 Column 명이 된다.
Subquery SELECT 문장을 기술한다.
WITH CHECK OPTION VIEW 에 의해 액세스 될 수 있는 행만이 입력,갱신될 수 있다. 
Constraint CHECK OPTON 제약 조건에 대해 지정된 이름이다.
WITH READ ONLY 이 VIEW 에서 DML 이 수행될 수 없게 한다.
*/

-- SYSTEM PRIVILEGES
--GRANT CREATE ANY VIEW TO "KOSA" WITH ADMIN OPTION;

create view view001
as 
    select * from emp;

--view001 이라는 객체가 생성 되었어요. (가상 테이블 >> 쿼리 문장을 가지고 있는 객체)
--이 객체는 테이블처럼 사용할 수 있는 객체 

select * from view001; 
select * from view001 where deptno=20;

--VIEW (가상 테이블)
--사용법 : 일반 테이블과 동일 (select , insert , update , delete)
--단 VIEW가 볼 수 있는 데이터에 한해서만
--VIEW 통해서 원본 테이블에 insert , update , delete (DML) 가능 . . . 가능정도만 . . .

--view 목적
--1. 개발자의 편의성 : join , subquery 복잡한 쿼리 미리 생성해두었다가 사용
--2. 쿼리 단순화 : view생성해서 JOIN 편리성
--3. DBA 보안 : 원본테이블은 노출하지 않고 , VIEW 만들어서 제공 (특정 컬럼을 노출하지 않는다)

create or replace view v_001
as
    select empno,ename from emp;

select * from v_001;

create or replace view v_emp
as
    select empno , ename , job , hiredate from emp;
    
--신입이 . . . . v_emp
select * from v_emp;

select * from v_emp where job = 'CLERK';

--편리성
create or replace view v_002
as
    select e.empno , e.ename , e.deptno , d.dname
    from emp e join dept d
    on e.deptno = d.deptno;

select * from v_002;    

--직종별 평균 급여를 볼 수 있는 view 작성 (객체) --객체를 drop 하지 않는한 영속적 . . .
create or replace view v_003
as
    select deptno, trunc(avg(sal),0) as avgsal from emp group by deptno;

select e.empno, e.ename, e.deptno, m.avgsal , e.sal
from emp e join v_003 m
on e.deptno = m.deptno
where e.sal > m.avgsal;

/*
view 나름 테이블(가상) view를 (통해서) view가 [볼 수 있는] 데이터에 대해서
DML (insert , update , delete) 가능 . . . .
*/
/*
create or replace view v_emp
as
    select empno, ename , job , hiredate from emp;
*/
select * from v_emp;

update v_emp
set sal = 0;
--sal은 뷰가 볼 수 없는 데이터

update v_emp
set job = 'IT';
--실제로는 원본 emp 테이블에 있는 데이터가 업데이트
select * from emp;
rollback;

/*
30번 부서 사원들의 직종, 이름, 월급을 담는 view를 만드는데,
각각의 컬럼명을 직종, 사원이름, 월급으로 alia를 주고 월급이
300보다 많은 사원들만 추출하도록 해라 . view

부서별 평균월급을 담는 view룰 만들되, 평균월급이 2000이상인
부서만 출력하도록 하라. view102
*/

create or replace view view101
as
    select job as 직종, ename as 사원이름, sal as 월급 from emp where sal>300 and deptno=30;
    
select * from view101;

create or replace view view102
as
    select deptno, avg(sal) as avgsal
    from emp
    group by deptno
    having avg(sal) >= 2000;

select * from view102;
--------------------------------------------------------------------------------
--기본 QUERY END-----------------------------------------------------------------
--개발자 관점

select * from employees;
select * from departments;
select * from locations;

/*
부서별 담당자의 부하직원들의 사번, 이름(Last_name), 부서번호, 월급, 부서 이름을 출력하세요. 
단 담당자는 제외하세요.
*/
create or replace view view_s
as
    select manager_id 
    from departments 
    where manager_id is not null;

select * from view_s;

select e.manager_id, e.employee_id, e.last_name, e.department_id, e.salary, d.department_name
from employees e join departments d
                 on e.department_id=d.department_id
where e.employee_id not in (select manager_id from departments where manager_id is not null)
group by e.manager_id, e.employee_id, e.last_name, e.department_id, e.salary, d.department_name
order by e.manager_id;

/*
부서의 소재지가 미국인 직원중 본인의 부서 평균 월급보다 높은 직원을 추출하고
이름, 월급, 부서번호, 부서이름, 도시이름을 월급이 높은 순으로 출력하세요.
단 이름은 성과 이름이 모두 한 칼럼에 출력되어야 한다 
*/

select to_char(e.first_name+e.last_name), e.sal, d.deptno,d.dname 
from department d join employees e
                  on e.deptno=d.deptno
                  join locations l
                  on d.location_id=l.location_id
where l.country_id = 'US';
     
/*
자신의 급여가 부서별 평균 급여보다 많고 이름에 ‘A’가 들어가는 사원들 중 가장 많은 country_ID의 급여 평균을 출력하라.
*/
select * from employees;
select * from departments;
select * from locations;

--country_id 개수 카운트
select country_id , count(country_id)
from locations
group by country_id;

select * from v_avg;
--부서 평균 급여

select department_id, trunc(avg(salary),0) as avgsal 
from employees
group by department_id;
--
select m.avgsal
from employees e join (select department_id, trunc(avg(salary),0) as avgsal from employees group by department_id) m
on e.department_id = m.department_id;

select a.avgsal
from departments m join locations l 
                  on m.location_id=l.location_id
                  join (select department_id, trunc(avg(salary),0) as avgsal from employees group by department_id) a
                  on m.department_id = a.department_id
                  join employees e
                  on m.department_id=e.department_id;
--------------------------------------------------------------------------------
create table test(
    phone nvarchar2(13)
);

select * from emp where regexp_like(ename,'(A-C)');

--------------------------------------------------------------------------------
show user;

create table dmlemp
as 
    select * from emp;
    
select * from dmlemp;

select * from user_constraints where table_name='DMLEMP';

alter table dmlemp
add constraint pk_dmlemp_empno primary key(empno);

select * from dmlemp;
commit;