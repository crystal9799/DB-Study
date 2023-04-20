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
--�������� Ȯ���ϱ� (�ݵ��)
select * from user_constraints where lower(table_name) = 'emp';

-- oracle 11g >> �ǹ� >> �����÷�(�����÷�)
-- �л� ���� ���̺�(���� , ���� , ����)
-- �հ� , ��� ...
-- �л� ���� ���̺�(���� , ���� , ����, ���)
-- ������ ���� ��ȭ >> ��հ��� ��ȭ ����Ǿ�� ��

create table vtable(
    no1 number,
    no2 number,
    no3 number GENERATED ALWAYS as (no1 + no2) VIRTUAL
);

select * from col where lower(tname) = 'vtable';

insert into vtable(no1,no2) values(100,50);
select * from vtable;

--insert into vtable(no1,no2,no3) values(10,20,30);

--�ǹ����� Ȱ��Ǵ� �ڵ�
--��ǰ���� (�԰�) : �б⺰ ������ ����(4�б�)
create table vtable2(
  no number, --����
  p_code char(4), --��ǰ�ڵ�(A001, B003)
  p_date char(8), --�԰��� (20230101)
  p_qty number, --����
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
--1. ���̺� �����ϱ�
create table temp6(id number);

desc temp6;

--2. ���̺� ���� �Ŀ� �÷� �߰��ϱ�
alter table temp6
add ename varchar2(20);

desc temp6

--3. ���� ���̺� �ִ� �÷��̸� �߸� ǥ�� (ename -> username)
--���� ���̺� �ִ� ���� �÷����� �ٲٱ� (rename)
alter table temp6
rename column ename to username;

--4. ���� ���̺� �ִ� ���� �÷��� Ÿ�� ũ�� ���� (���) modify
alter table temp6
modify (username varchar2(2000));

desc temp6;

--5. ���� ���̺� ���� �÷� ����
alter table temp6
drop column username;

desc temp6;
--��� �۾��� TOOL ���� ���� . . .

--���̺� ����
drop table temp6;

desc temp6; --ORA-04043: temp6 ��ü�� �������� �ʽ��ϴ�.

--------------------------------------------------------------------------------

--���̺� ���� �ɱ�

--����Ȯ��
select * from user_constraints where table_name = 'EMP';

create table temp7(
    --id number primary key �������� �ʾƿ� (������ �̸��� �ڵ����� ... ���� ���� ...)
    id number constraint pk_temp7_id primary key, --�����ڰ� ���� �̸� : pk_temp7_id
    name varchar2(20) not null , 
    addr varchar2(50)
);

desc temp7;
select * from user_constraints where lower(table_name)='temp7';

insert into temp7(name,addr) values('ȫ�浿','����� ������');
--ORA-01400: cannot insert NULL into ("KOSA"."TEMP7"."ID")

insert into temp7(id,name,addr) values(10,'ȫ�浿','����� ������');
select * from temp7;
commit;

insert into temp7(id,name,addr) values(10,'�߹�����','����� ������');
--ORA-00001: unique constraint (KOSA.PK_TEMP7_ID) violated

--UNIQUE

create table temp8(
    id number constraint pk_temp8_id primary key, --�����ڰ� ���� �̸� : pk_temp7_id
    name varchar2(20) not null , 
    jumin nvarchar2(6) constraint uk_temp8_jumin unique,
    addr varchar2(50)
);
select * from user_constraints where lower(table_name)='temp8';

insert into temp8(id,name,jumin,addr)
values(10,'ȫ�浿',123456,'��⵵');

select * from temp8;

insert into temp8(id,name,jumin,addr)
values(20,'�浿',123456,'����');
--ORA-00001: unique constraint (KOSA.UK_TEMP8_JUMIN) violated

insert into temp8(id,name,addr)
values(20,'�浿','����'); --unique ������ null ���

select * from temp8;

--�׷� null�� �ߺ�üũ(�ƴϿ�)
insert into temp8(id,name,addr)
values(30,'����','����');

select * from temp8;
commit;


--not null �������� ������
--jumin nvarchar2(6) not null constraint uk_temp8_jumin unique,

--���̺� ���� �Ŀ� ���� �ɱ�(��õ)
create table temp9(id number);
--���� ���̺� ���� �߰��ϱ� (��κ��� ���� �� ���)
alter table temp9
add constraint pk_temp9_id primary key(id);

select * from user_constraints where lower(table_name)='temp9';

--create table temp9(id number, num number)
--alter table temp9
--add constraint pk_temp9_id primary key(id,num); -- ����Ű
--������ �Ѱ��� row >> where id=100 and num=1
 













