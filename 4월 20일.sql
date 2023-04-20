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
 













