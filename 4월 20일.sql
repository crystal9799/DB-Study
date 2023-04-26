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

--�÷��߰�
alter table temp9
add ename varchar2(50);

desc temp9;

--ename Į���� not null �߰�
alter table temp9
modify(ename not null);

desc temp9; --ENAME NOT NULL VARCHAR2(50)

--------------------------------------------------------------------------------
--check ���� (���� ��Ģ : where ������ ���� �� ó��)
--Where gender in ('��' , '��')
create table temp10(
    id number constraint pk_temp10_id primary key,
    name varchar2(20) not null,
    jumin char(6) not null constraint uk_temp10_jumin unique,
    addr varchar2(30),
    age number constraint ck_temp10_age check(age >= 19) --where age >=19
);

select * from user_constraints where table_name = 'TEMP10';

insert into temp10(id,name,jumin,addr,age)
values(100,'ȫ�浿','123456','����� ������',20);

insert into temp10(id,name,jumin,addr,age)
values(200,'�ƹ���','234567','����� ������',18);
--ORA-02290: check constraint (KOSA.CK_TEMP10_AGE) violated


select * from temp10;

--------------------------------------------------------------------------------
--FORIGN KEY(FK) : ���� ������ �� ������ �ܷ�Ű ���踦 �����ϰ� �����մϴ�.
--�������� (���̺�� ���̺���� ���� ����)

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
--c_emp ���̺� �ִ� deptno �÷��� �����ʹ� c_dept ���̺� �ִ� deptno �÷��� �ִ� �����͸�
--���ڴ�

--���� (FK)

--c_dept �� deptno �÷��� �ſ��� ����� (PK�� UNIQUE)
--alter table c_emp
--add constraint fk_c_emp_deptno foreign key(deptno) references c_dept(deptno);

alter table c_dept
add constraint pk_c_dept_deptno primary key(deptno);

--�׸��� ���� ��������
alter table c_emp
add constraint fk_c_emp_deptno foreign key(deptno) references c_dept(deptno);


select * from user_constraints where table_name = 'C_DEPT';
select * from user_constraints where table_name = 'C_EMP';


--�μ�
insert into c_dept(deptno,dname) values(100,'�λ���');
insert into c_dept(deptno,dname) values(200,'������');
insert into c_dept(deptno,dname) values(300,'ȸ����');
commit;

select * from c_dept;

--���Ի�� �Ի�
insert into c_emp(empno,ename,deptno)
values(1,'������',100);

select * from c_emp;

insert into c_emp(empno,ename,deptno)
values(2,'�ƹ���',101);
--ORA-02291: integrity constraint (KOSA.FK_C_EMP_DEPTNO) violated - parent key not found

commit;
--------------------------------------------------------------------------------
--���� END----------------------------------------------------------------------

--������ �������� FK ���캸��--
--MASTER DETAIL ����
--�θ� - �ڽ� ����

--c_emp�� c_dept (���� FK) >> c_emp(deptno) �÷��� c_dept(deptno) �÷��� ����
--FK ���� : master(c_dept) - detail(c_emp) >> ȭ�� (�μ� ���) >> �μ���ȣ Ŭ�� >> ������� ���
--deptno ���� ���� �θ�(c_dept) - �ڽ�(c_emp)

--���� PK������ �ִ� �� (master) , FK (detail)

select * from c_dept;

select * from c_emp;

--1. �� ��Ȳ���� c_emp ���̺� �ִ� �����̸� ������ �� ���� ���? 
delete from c_dept where deptno=100;
delete from c_emp where empno=100;

delete from c_dept where deptno=200; -- ���� ���� (c_emp�� �������� ���� �ʾƿ�)

delete from c_dept where deptno=100;
delete from c_emp where empno=1; -- �������� �ʰ� . . . .

--�ڽ� ����
--�θ� ���� �Ͻø� �˴ϴ�.
commit;

/*
column datatype [CONSTRAINT constraint_name]
 REFERENCES table_ name (column1[,column2,..] [ON DELETE CASCADE])
 
 ON DELETE CASCADE �θ� ���̺�� ������ ���� �ϰڴ�
 
 alter table c_emp
 add constraint fk_c_emp_deptno foreign key(deptno) fererences c_dept(deptno) on delete cascade;
 
 delete from c_emp where empno=1 >> deptno >> 100��
 
 delete from c_dept where deptno=100; ���� �ȵǿ� (�����ϰ� �����ϱ�)
 on delete cascade �ɸ� �����ǿ�
 
 �θ���� >> �����ϰ� �ִ� �ڽĵ� ����
 
 Oracle
 ON DELETE CASCADE �� ����
 
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

insert into grade(kor,eng,math,stuno,name,deptno) values(10,20,30,400,'ȫ�浿',10);
insert into grade(kor,eng,math,stuno,name,deptno) values(44,22,33,500,'�浿',20);
insert into grade(kor,eng,math,stuno,name,deptno) values(55,66,33,600,'��',30);

insert into stu_dept(deptno,dname) values(10,'��ǻ��');
insert into stu_dept(deptno,dname) values(20,'���');
insert into stu_dept(deptno,dname) values(30,'����');

alter table grade
add constraint fk_grade_deptno foreign key(deptno) references stu_dept(deptno);


select g.stuno, g.name, g.total, g.avg, g.deptno, s.dname
from grade g join stu_dept s
on g.deptno = s.deptno;

--------------------------------------------------------------------------------
--��������� �ʱ� ���� END--
--�� 12�� VIEW (���߱�)
--���� ���̺� (subquery >> in line view >> from())
--�ʿ��� �������̺��� ��ü���·� ����� (����������)

/*
CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW view_name [(alias[,alias,...])]
AS Subquery 
[WITH CHECK OPTION [CONSTRAINT constraint ]]
[WITH READ ONLY]

�ɼ�
OR REPLACE �̹� �����Ѵٸ� �ٽ� �����Ѵ�.
FORCE Base Table ������ ������� VIEW �� �����.
NOFORCE �⺻ ���̺��� ������ ��쿡�� VIEW �� �����Ѵ�.
view_name VIEW �� �̸�
Alias Subquery �� ���� ���õ� ���� ���� Column ���� �ȴ�.
Subquery SELECT ������ ����Ѵ�.
WITH CHECK OPTION VIEW �� ���� �׼��� �� �� �ִ� �ุ�� �Է�,���ŵ� �� �ִ�. 
Constraint CHECK OPTON ���� ���ǿ� ���� ������ �̸��̴�.
WITH READ ONLY �� VIEW ���� DML �� ����� �� ���� �Ѵ�.
*/

-- SYSTEM PRIVILEGES
--GRANT CREATE ANY VIEW TO "KOSA" WITH ADMIN OPTION;

create view view001
as 
    select * from emp;

--view001 �̶�� ��ü�� ���� �Ǿ����. (���� ���̺� >> ���� ������ ������ �ִ� ��ü)
--�� ��ü�� ���̺�ó�� ����� �� �ִ� ��ü 

select * from view001; 
select * from view001 where deptno=20;

--VIEW (���� ���̺�)
--���� : �Ϲ� ���̺�� ���� (select , insert , update , delete)
--�� VIEW�� �� �� �ִ� �����Ϳ� ���ؼ���
--VIEW ���ؼ� ���� ���̺� insert , update , delete (DML) ���� . . . ���������� . . .

--view ����
--1. �������� ���Ǽ� : join , subquery ������ ���� �̸� �����صξ��ٰ� ���
--2. ���� �ܼ�ȭ : view�����ؼ� JOIN ����
--3. DBA ���� : �������̺��� �������� �ʰ� , VIEW ���� ���� (Ư�� �÷��� �������� �ʴ´�)

create or replace view v_001
as
    select empno,ename from emp;

select * from v_001;

create or replace view v_emp
as
    select empno , ename , job , hiredate from emp;
    
--������ . . . . v_emp
select * from v_emp;

select * from v_emp where job = 'CLERK';

--����
create or replace view v_002
as
    select e.empno , e.ename , e.deptno , d.dname
    from emp e join dept d
    on e.deptno = d.deptno;

select * from v_002;    

--������ ��� �޿��� �� �� �ִ� view �ۼ� (��ü) --��ü�� drop ���� �ʴ��� ������ . . .
create or replace view v_003
as
    select deptno, trunc(avg(sal),0) as avgsal from emp group by deptno;

select e.empno, e.ename, e.deptno, m.avgsal , e.sal
from emp e join v_003 m
on e.deptno = m.deptno
where e.sal > m.avgsal;

/*
view ���� ���̺�(����) view�� (���ؼ�) view�� [�� �� �ִ�] �����Ϳ� ���ؼ�
DML (insert , update , delete) ���� . . . .
*/
/*
create or replace view v_emp
as
    select empno, ename , job , hiredate from emp;
*/
select * from v_emp;

update v_emp
set sal = 0;
--sal�� �䰡 �� �� ���� ������

update v_emp
set job = 'IT';
--�����δ� ���� emp ���̺� �ִ� �����Ͱ� ������Ʈ
select * from emp;
rollback;

/*
30�� �μ� ������� ����, �̸�, ������ ��� view�� ����µ�,
������ �÷����� ����, ����̸�, �������� alia�� �ְ� ������
300���� ���� ����鸸 �����ϵ��� �ض� . view

�μ��� ��տ����� ��� view�� �����, ��տ����� 2000�̻���
�μ��� ����ϵ��� �϶�. view102
*/

create or replace view view101
as
    select job as ����, ename as ����̸�, sal as ���� from emp where sal>300 and deptno=30;
    
select * from view101;

create or replace view view102
as
    select deptno, avg(sal) as avgsal
    from emp
    group by deptno
    having avg(sal) >= 2000;

select * from view102;
--------------------------------------------------------------------------------
--�⺻ QUERY END-----------------------------------------------------------------
--������ ����

select * from employees;
select * from departments;
select * from locations;

/*
�μ��� ������� ������������ ���, �̸�(Last_name), �μ���ȣ, ����, �μ� �̸��� ����ϼ���. 
�� ����ڴ� �����ϼ���.
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
�μ��� �������� �̱��� ������ ������ �μ� ��� ���޺��� ���� ������ �����ϰ�
�̸�, ����, �μ���ȣ, �μ��̸�, �����̸��� ������ ���� ������ ����ϼ���.
�� �̸��� ���� �̸��� ��� �� Į���� ��µǾ�� �Ѵ� 
*/

select to_char(e.first_name+e.last_name), e.sal, d.deptno,d.dname 
from department d join employees e
                  on e.deptno=d.deptno
                  join locations l
                  on d.location_id=l.location_id
where l.country_id = 'US';
     
/*
�ڽ��� �޿��� �μ��� ��� �޿����� ���� �̸��� ��A���� ���� ����� �� ���� ���� country_ID�� �޿� ����� ����϶�.
*/
select * from employees;
select * from departments;
select * from locations;

--country_id ���� ī��Ʈ
select country_id , count(country_id)
from locations
group by country_id;

select * from v_avg;
--�μ� ��� �޿�

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