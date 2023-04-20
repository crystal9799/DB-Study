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









