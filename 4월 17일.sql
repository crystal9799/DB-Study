/*
1���� ����

1. ����Ʈ���� �ٿ�ε�  (11g)
https://www.oracle.com/database/technologies/xe-prior-release-downloads.html

2. Oracle ��ġ ( SYS , SYSTEM ������ ���� ��ȣ ����: 1004)

3. sqlplus ���α׷� ����(CMD) : ���� GUI  ȯ�� �������� �ʾƿ�

4. ������ ���α׷�  ����  Tool
4.1 SqlDeveloper ���� , dbeaver  ����
4.2 ��� , ������ , SqlGate  ȸ�� .....

5. SqlDeveloper ����  >> Oracle ���� ���� >> GUI
5.1 HR ���� ��� (unlock)
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

5.2 KOSA ���� ����
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
�ǽ��ڵ�

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



DB�о�
������ (CRUD)(insert, select , update , delete) >> DML + DDL(create, alter ,drop)

������(DBA) ����ϰ� ���� , ��Ʈ��ũ ���� , �ڿ����� , �ϵ���� ����

Ʃ�� : SQL Ʃ��(����) >> �ӵ� >> index >> �ڷᱸ�� 
      �ϵ����(��Ʈ��ũ) Ʃ��
      
�𵨷�  : ���� (PM) -ERD -�䱸���� �м� ERD 

�м��� (������ �м�)  ������̻� .... �� read .....(SCI) 


*/
show user;

select * from emp;
select * from dept;
select * from salgrade;
--------------------------------------------------------------------------------
--1. ������̺��� ��� �����͸� ����ϼ���
select * from emp;
SELECT * FROM EMP;
SELECT * FROM emp;

--2. Ư�� �÷� ������ ����ϱ�
select empno , ename , sal 
from emp;

select ename from emp;

--3. ����Ī ����ϱ� (��Ī: alias)
select empno ��� , ename �̸�
from emp;

select empno "��  ��" , ename "��   ��"
from emp;

--���� ����(ANSI) >> ǥ�� >> ������ �ۼ��ϸ� (Oracle , Ms-sql , Mysql) ��� ����
select empno as "�� ��" , ename as "�� ��"
from emp;

--Oracle ���ڿ� ������ �����ϰ� ��ҹ��� ����
/*
JAVA : ����> 'A' , ���ڿ�> "AAAA"
ORACLE : ���ڿ� 'A'   ,  'AAAA'  , 'AVBWEDWED'
ORACLE : �����ͷ� 'a' 'A' �ٸ����ڿ�
*/
select * 
from emp
where ename='king'; --��ҹ���

select * 
from emp
where ename='KING'; --��ҹ���


/*
select ��     3
from ��       1
where ��      2
*/

--Oracle Query (���Ǿ�) : ���
/*
������
JAVA : + ����(�������) , + ���ڿ�(���տ���)
----------------------------------------
ORACLE :
���� ������  ||
��� ������  + (�������)

MS-SQL : + (���, ����)
*/

select '����� �̸���' || ename || ' �Դϴ�' as �������
from emp;

--���̺��� �⺻ ���� ( �÷� , Ÿ��)
desc emp;
--ENAME             VARCHAR2(10)   ���ڿ� Ÿ��  ���հ��� ...����

/*
JAVA : class Emp {private int emnpno , private String ename}
ORACLE : create Table Emp( empno number , ename varchar2(20));
*/

--����ȯ(�ڵ�) >> ���ڸ� ���ڿ��� ��ȯ 
select empno || ename from emp;

select empno + ename from emp; --01722. 00000 -  "invalid number"

--����� ... �츮 ȸ�翡 ������ ��� �ֳ�
select job from emp;

--�ߺ� �� ���� Ű���� : distinct

select distinct job from emp;
--grouping

--distinct 
--��̷� >> grouping
select distinct job , deptno
from emp
order by job;

--Oracle SQL ���
--JAVA     : ( + , - , * /)  ������ %
--ORACLE   : ( + , - , * /)  ������ % �� �ٸ� ���� ��� ...  �Լ� mod()
--���ڿ� ���� �˻� : ename like '%��%'

--������̺��� ����� �޿��� 100�޶� �λ��� ����� ����ϼ���
select empno, ename , sal , sal + 100 as �λ�޿� from emp;

--dual �ӽ� ���̺�
select 100 + 100 from dual;
select 100 || 100 from dual; -- 100100
select '100' + 100 from dual; --200 --'100' ������ ���� ex)'123456'
select 'A100' + 100 from dual; --Error

--�񱳿�����
-- <  >   <=  
--����
--JAVA : ���� (==)  �Ҵ�(=) , JavaScript : (== , ===)
--ORACLE : ���� =    �����ʴ� !=

--�������� (AND , OR , NOT)

select empno , ename ,sal
from emp
where sal >= 2000;

--����� 7788���� ����� ��� , �̸� , ���� , �Ի����� ����ϼ���
select empno, ename , job , hiredate
from emp
where empno=7788;

--����� �̸��� king ����� ��� , �̸� , �޿� ������ ����ϼ���
select empno , ename, sal
from emp
where ename ='KING';

/*    AND  , OR
 0 0   0     0
 1 0   0     1
 0 1   0     1
 1 1   1     1

*/
--�ʰ� , �̸�
--�̻� , ���� (=)

--�޿��� 2000�޷� �̻��̸鼭 ������ manager �� ����� ��� ������ ����ϼ���
select *
from emp
where sal >= 2000 and job='MANAGER';


--�޿��� 2000�޷� �̻��̰ų� (�Ǵ�) ������ manager �� ����� ��� ������ ����ϼ���
select *
from emp
where sal >= 2000 or job='MANAGER';

--�޿��� 2000�޷� �ʰ��̸鼭 ������ manager �� ����� ��� ������ ����ϼ���
select *
from emp
where sal > 2000 and job='MANAGER';

--����Ŭ ��¥ (DB ������ ��¥)
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
--���� >> ȯ�漳�� >> �����ͺ��̽� Ȯ�� >> NLS >> ��¥���� �����ϼŵ� �˴ϴ�

select * from emp;

--��¥ ������ �˻� >> ���ڿ� �˻� ó�� >>  '��¥'
select * from emp
where hiredate ='1980-12-17';

select * from emp
where hiredate ='1980/12/17';

select * from emp
where hiredate ='1980.12.17';

select * from emp
where hiredate ='80-12-17'; --���� ��¥ (yyyy-MM-dd)

--����� �޿��� 2000�̻��̰� 4000������ ��� ����� ������ ����ϼ���
select *
from emp
where sal >= 2000 and sal <= 4000;
-- �÷��� between A and B ������ (= ����)

select *
from emp
where sal between 2000 and 4000;

--����� �޿��� 2000�ʰ� 4000�̸� �� ��� ����� ������ ����ϼ���
select *
from emp
where sal > 2000 and sal < 4000;

--�μ���ȣ�� 10�� �Ǵ� 20�� �Ǵ� 30���� ����� ��� , �̸� , �޿� , �μ���ȣ�� ����ϼ���
select *
from emp
where deptno=10 or deptno=20 or deptno=30;
-- IN ������ 
select *
from emp
where deptno in (10,20,30); --where deptno=10 or deptno=20 or deptno=30;

--�μ���ȣ�� 10�� �Ǵ� 20�� �� �ƴ� ����� ��� , �̸� , �޿� , �μ���ȣ�� ����ϼ���
select empno , ename,  sal , deptno
from emp
where deptno != 10 and deptno != 20;

-- IN �� ���� ( NOT IN)
select *
from, emp
where deptno not in (10,20); --where deptno != 10 and deptno != 20;
--POINT : not in >>  != and 

--Today POINT
-- null �� ���� �̾߱�
-- ���� ����
-- �ʿ��


create table member (
 userid varchar2(20) not null, --null�� ������� �ʰڴ� (�ʼ� �Է»���)
 name varchar2(20) not null, --�Է� ����
 hobby varchar2(50)--default null ��� (���� �Է�)
);
desc member;
insert into member(userid,hobby) values('kim','��');
--ORA-01400: cannot insert NULL into ("KOSA"."MEMBER"."NAME")

insert into member(userid,name) values('hong','ȫ�浿');
commit;
select * from member;

--------------------------------------------------------------------------------
/*
DB���� ����
Oracle
insert , update , delete ���
�⺻������ ������ ����� begin tran ������ �ڵ� ~~~~ �����ڴ� end(�Ϸ� , ���)
����Ŭ�� ������ . . . . ������ ��� (commit ���� �ݿ� , rollback ���� ���) �۾��Ϸ�

Ms-sql
�ڵ� auto-commit
delete from emp; �ڵ� commit

begin tran
    delete from emp;
    
    commit or rollback ���� ������ ������ ó�� �ȵ�
    
DB Transaction : ������ �۾� ���� (���� , ����)
OLTP (�� ȯ�� : �ǽð� ������ ó��) >> Ʈ����� 
������� ��ü
begin tran
    update . . . ���� - 1000
    update . . . �������� + 1000
end

OLAP (������ �м� : �����Ⱓ �����͸� ��Ƽ� �м�)

*********����Ŭ ���� insert , update , delete �ϸ� �ݵ��
*********commit , rollback �� ���ؼ� ó�� ���θ� �����ؾ� �Ѵ�.
*/
--------------------------------------------------------------------------------
--����(comm) �� ���� �ʴ� ��� ����� ������ ����ϼ���.
select *
from emp
where comm=null; --������ �����

--null�� ���� �񱳴� is null�� ��� �Ѵ�.
select *
from emp
where comm is null;
--�ϱ� ( null �� �񱳴� is null)

--comm�� �޴� ����� (comm �÷��� �����Ͱ� null �� �ƴ� ��)
select *
from emp
where comm is not null;

--������̺��� ��� , �̸� , �޿� , ���� , �ѱ޿�(�޿�+����) �� ����ϼ���
select empno , ename , sal , comm , sal+comm as �ѱ޿�
from emp;
/*
null �̶� �ʼ�
1. null ���� ��� ���� ����� null ex) null + 100 -> null 
2. null �̶� . . . . �Լ� > mvl() , mvl2() �ϱ�

ex) nvl(�÷��� , ��ü��) >> ġȯ

Tip)
Mysql   > null > IFNULL()   > select ifnull(null,' ')
MS-sql  > null > Convert()  
*/

select empno, ename ,sal , comm , sal+nvl(comm,0) as �ѱ޿�
from emp;

select 100 + null from dual;
select 1000 + nvl(null,0) from dual;
select comm , nvl(comm,111111) from emp;
select nvl(null,'hello world') from dual;

--����� �޿��� 1000�̻��̰� ������ ���� �ʴ� ����� ��� , �̸� , ���� , �޿� , ������ ����ϼ���.

select empno , ename , job , sal , comm
from emp
where sal>=1000 and comm is not null;

--���ڿ� �˻�
--�ּҰ̻� >> ���� >> ���� �ܾ �ִ� ��� �ּҰ� ������ �� 
--Like ���ڿ� ���� �˻�
--���ϵ� ī��( %(����) , _ (�ѹ���))

select *
from emp
where ename like '%A%'; --A�� �����ϴ� ��� �̸�

select *
from emp
where ename like 'A%'; --A�� �����ϴ� ��� �̸� like '��%'

select *
from emp
where ename like '%E'; --E�� ������ ��� �̸� 



select *
from emp
where ename like '%LL%'; -- ALLEN , MILLER

select *
from emp
where ename like '%A%A%'; --A�� �ΰ� ��� �ִ� ��� �̸� ADAMS

select *
from emp
where ename like '_A%'; -- 2��° ���ڴ� A�̰� �ڿ��� ������� . . . WARD , MARTIN , JAMES

--����ǥ���� regexp_like()
select * from emp where regexp_like(ename,'(A-C)');
--���� (����ǥ���� 5�� �����) ���� ī�信 �ö󰡸� �ϼ���.

--������ �����ϱ�
--order by �÷��� : ���� , ���� , ��¥ ���İ���
--�������� : asc : ������ : default
--�������� : desc : ������
--���� (�˰���) >> ����� ���� ��� �۾�(cost)

select *
from emp
order by sal; -- default order by sal asc

select *
from emp
order by sal desc; -- ���� ������ ����

--�Ի����� ���� ���� ������ �����ؼ� ��� , �̸� , �޿� , �Ի��� ����ϼ���
--���� �ֱٿ� �Ի��� ������
select empno , ename , sal , hiredate
from emp
order by hiredate desc;

/*
Select ��    3
From ��      1
Where ��     2
order by ��  4
*/


select empno , ename , sal , job , hiredate
from emp
where job='MANAGER'
order by hiredate desc;


--emp���� job�� deptno�� ����ϴµ� ������ ���ĺ� ������ �����ϰ� ���� deptno�� ���� ������ ����
select job , deptno
from emp
order by job asc , deptno desc; --�߿� (�亯�� �Խ��� . . . ���) >> grouping
--order by �÷��� asc , �÷��� asc ,  . . . . 



--������
--������ (union)       : ���̺�� ���̺��� �����͸� ��ġ�� �� (�ߺ����� ����)
--������ (union all)   : ���̺�� ���̺��� �����͸� ��ġ�� �� (�ߺ��� ���)

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
--ut ���� uta �ı����� ����� �� (�ߺ� ������ ����)

select * from ut
union all
select * from uta;
--ut ���� uta �ı����� ����� �� (�ߺ� ������ ����X)

--union
--1. [����]�Ǵ� [�÷�]�� Ÿ���� �����ؾ� �Ѵ�.

select empno , ename from emp       --���� , ���ڿ�
union
select dname , deptno from dept;    --���ڿ� , ����

--emp �濡 dept �ֵ��� ���� ��
select empno , ename from emp
union
select deptno , dname from dept;
--���� ���߿� subquery �� ����ؼ� ���� ���̺� ....
select *
from (
    select empno , ename from emp
    union
    select deptno , dname from dept
    ) m
order by m.empno desc; -- in-line view

--2. [����]�ϴ� �÷��� ������ ����
-- �ʿ�� (null) �÷��� ��ü
select empno, ename , job , sal from emp
union
select deptno , dname , loc , null from dept;
--------------------------------------------------------------------------------
--�ʱ� ������ �ǹ������� �ؾ� �ϴ� �ڵ� (���� ���̺� select)--------------------------
--����Ŭ.pdf (47 page)
--------------------------------------------------------------------------------

show user;
select sysdate from dual; --��¥�� �ٽ� ���ư� �ִ�.
--alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

--���ڿ� �Լ�
select initcap('the super man') from dual;

select lower('AAA') , upper('aaa') from dual;

select ename , lower(ename) as "ename" from emp;

select * from emp where lower(ename) = 'king';

select length('abcd') from dual; --���ڿ��� ����
select length('ȫ�浿') from dual; -- 3��

select length('   ȫ �� ��a') from dual; --9��

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
������̺��� ename �÷��� �����Ϳ� ���ؼ� ù���ڴ� �ҹ��ڷ� ������ ���ڴ� �빮�ڷ�
����ϵ� �ϳ��� �÷����� ���� ����ϰ� �÷��� ��Ī�� fullname ù���ڿ� ������
���� ���̿��� ���� �ϳ��� ��������
*/

select lower(substr(ename,1,1)) || ' ' || upper(substr(ename,2)) as fullanem from emp;

select lpad('ABC',10,'*') from dual;

select rpad(substr('hong1004',1,2),length('hong1004'),'*') from dual;


--emp ���̺��� ename �÷��� �����͸� ����ϵ� ù���ڸ� ����ϰ� �������� * ����ϼ���
select rpad(substr(ename,1,1),length(ename),'*') from emp;

create table member2(
 id number,
 jumin varchar2(14)
);
insert into member2(id,jumin) values(100,'123456-1234567');
insert into member2(id,jumin) values(200,'234567-1234567');
commit;
 
select * from member2;

--��°��
--100 : 123456-*******
--200 : 234567-*******

select id || ' : ' || rpad(substr(jumin,1,7),length(jumin),'*') as jumin from member2;


--rtrim
--������ ���ڸ� ������
select rtrim('MILLER','ER') from dual; --MILL 

--ltrim
--���� ���ڸ� ������
select ltrim('MILLLLLLLLER','MIL') from dual;

--��������
select '>' || rtrim('MILLER              ',' ') || '<' from dual;


--ġȯ�Լ�
select ename , replace(ename,'A','�Ϳ�') from emp;
--------------------------------------------------------------------------------

--�����Լ�
--    -3 -2 -1 0(����) 1 2 3

--�ݿø��Լ�
select round(12.345,0) as r from dual;
select round(12.567,0) as r from dual;

select round(12.345,1) as r from dual;
select round(12.345,-1) as r from dual;
select round(15.345,-1) as r from dual;
select round(12.345,-2) as r from dual;

--�����Լ�
select trunc(12.345,0) as r from dual;
select trunc(12.567,0) as r from dual;

select trunc(12.345,1) as r from dual;
select trunc(12.345,-1) as r from dual;
select trunc(15.345,-1) as r from dual;
select trunc(12.345,-2) as r from dual;

--������
select 12/10 from dual; --1.2
select mod(12,10) from dual; --������ �Լ�

select mod(0,0) from dual;

--------------------------------------------------------------------------------
--��¥ �Լ�
select sysdate from dual;

select sysdate + 100 from dual;
select sysdate + 1000 from dual;
select sysdate - 1000 from dual;

select hiredate from emp;

select trunc(months_between('2022-9-27','2020-9-26'),0) from dual; --24����

select trunc(months_between(sysdate,'2020-2-2'),0) from dual;

select '2023-01-01' + 100 from dual; --'2023-01-01' (��¥����) ������ ���ڿ�
--���ڸ� ��¥�� �ٲٴ� �Լ�
select to_date('2023-01-01') + 100 from dual;

--  ������̺��� ������� �Ի��Ͽ��� ���糯¥������ �ټӿ����� ���ϼ���
--  ����̸�, �Ի��� , �ټӿ��� ���

select ename, hiredate , trunc(months_between(sysdate,hiredate),0) as �ټӿ��� from emp;

--�Ѵ��� 31���̶�� �����ϰ� . . . ���ؿ��� �ټӿ����� ���ϼ���
--�Լ��� ������� ������ ( �ݿø� ���� ������ )

select trunc((sysdate-hiredate)/31,0) from emp;
--------------------------------------------------------------------------------
--�����Լ� , �����Լ� , ��¥�Լ� END ----------------------------------------------

--��ȯ�Լ�
select '100' + 100 from dual;
select to_number('100') + 100 from dual;

--��ȯ�� ǥ���� (page 69 ~ 71 ����)
--���� formant

select sysdate , to_char(sysdate,'YYYY')|| '��' as yyyy from dual;
select to_char(sysdate, 'YEAR') as YEAR from dual;

--�Ի����� 12���� ����� ���, �̸�, �Ի���, �Ի�⵵, �Ի���� ����ϼ���
select empno , ename, hiredate , to_char(hiredate, 'YYYY') as �Ի�⵵ , to_char(hiredate,'MM') as �Ի��
from emp
where to_char(hiredate,'MM') = '12';

select '>' || to_char(12345,'999999999999999999999') || '<' from dual;

select '>' || ltrim(to_char(12345,'999999999999999999999')) || '<' from dual;

select '>' || to_char(12345,'$999,999,999,999,999') || '<' from dual;

select sal , to_char(sal,'$999,999') as �޿� from emp;

--HR���� �̵�
show user;
--USER��(��) "HR" �Դϴ�.
select * from employees;

/*
������̺� (employees) ���� ����� �̸��� last_name , first_name ���ļ� fullname ��Ī
�ο��ؼ� ����ϰ� �Ի����� YYYY-MM-DD �������� ����ϰ� ����(�޿�*12)�� ���ϰ�
���� 10%(���� * 1.1) �λ��� ����
����ϰ� �� ����� 1000���� �޸� ó���ؼ� ����ϼ���
�� 2005�� ���� �Ի��ڵ鸸 ����ϼ��� �׸��� ������ ���� ������ ����ϼ���
*/


select concat(last_name,first_name) as fullname , 
to_char(hire_date,'YYYY-MM-DD') as �Ի���,
salary,
salary*12 as ����,
to_char(salary*12*1.1,'$999,999') as �޿��λ�
from employees
where to_char(hire_date,'YYYY') > 2005
order by ���� desc;

--�ٽ� KOSA USER��
show user;

--Tip
select 'A' as a , 10 as b, null as c, empno
from emp;
--------------------------------------------------------------------------------
--���� , ���� , ��¥ , ��ȯ�Լ�(to_...)
--------------------------------------------------------------------------------

--�Ϲ��Լ� (���α׷��� ������ ���ϴ�)

select comm , nvl(comm,0) from emp;

create table t_emp(
 id number(6), --���� 6�ڸ�
 job nvarchar2(20) -- unicode ������ , �ѱ� ��� 2byte . . . . 20�� =>40����Ʈ
);

desc t_emp;

insert into t_emp(id,job) values(100,'IT');
insert into t_emp(id,job) values(200,'SALES');
insert into t_emp(id,job) values(300,'MANAGER');
insert into t_emp(id,job) values(400);
insert into t_emp(id,job) values(500,'MANAGER');
COMMIT;

select * from t_emp;

select id,decode(id,100,'����Ƽ',
                    200,'������',
                    300,'������',
                        '��Ÿ�μ�') as �μ��̸�
from t_emp;


select empno , ename , deptno , decode(deptno, 10 , '�λ��',
                                               20 , '������',
                                               30 , 'ȸ���',
                                               40 , '�Ϲݺμ�',
                                                    'ETC') as �μ��̸�
from emp;

create table t_emp2(
  id number(2),
  jumin char(7) --�������� ���ڿ�
);

desc t_emp2;

insert into t_emp2(id,jumin) values(1,'1234567');
insert into t_emp2(id,jumin) values(2,'2234567');
insert into t_emp2(id,jumin) values(3,'3234567');
insert into t_emp2(id,jumin) values(4,'4234567');
insert into t_emp2(id,jumin) values(5,'5234567');
commit;

select * from t_emp2;

select id,jumin,decode(substr(jumin,1,1), 1 , '����',
                                          2 , '����',
                                          3 , '�߼�',
                                              '��Ÿ') as ����
from t_emp2;


/*
���빮�� : hint) if�� �ȿ� if��
�μ���ȣ�� 20���� ����߿��� SMITH ��� �̸��� ���� ����̶�� HELLO ���� ����ϰ�
�μ���ȣ�� 20���� ����߿��� SMITH ��� �̸��� ���� ����� �ƴ϶�� WORLD ���� ���
�μ���ȣ�� 20���� ����� �ƴ϶�� ETC��� ���ڸ� ����ϼ���
EMP ���̺��� . . . 
*/
select deptno,ename,decode(deptno , 20 , decode(ename , 'SMITH' , 'HELLO','WORLD')
                                       , 'ETC')
from emp;


--CASE ��

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


select '0' || to_char(zipcode) , case zipcode when 2 then '����'
                                              when 31 then '���'
                                              when 41 then '����'
                                              else '��Ÿ'
                                 end �����̸�
from t_zip;


/*
������̺��� ����޿��� 100�޷� ���ϸ� 4��
1001�޷� 2000�޷� ���ϸ� 3��
2001�޷� 3000�޷� ���ϸ� 2��
3001�޷� 4000�޷� ���ϸ� Ư���̶�� �����͸� ����ϼ���

1.
CASE �÷��� WHEN ���1 THEN ���1

2. 
���ǽ��� �ʿ��ϴٸ�
CASE WHEN ���� �񱳽� THEN
     WHEN ���� �񱳽� THEN
END
*/

select * from emp;

select ename , sal , case when (sal<100) then '4��'
                              when sal between 1001 and 2000 then '3��'
                              when sal between 2001 and 3000 then '2��'
                              when sal between 3001 and 4000 then 'Ư��'
                     end �޼�
from emp;

--------------------------------------------------------------------------------
--�����Լ� , �����Լ� , ��¥�Լ� , ��ȯ�Լ�(to_) , �Ϲ��Լ� (nvl , decode , case) END-
--------------------------------------------------------------------------------

--�����Լ�(�׷�)
--75page
--count(*) �� row �� , count(�÷���) �� ������ �Ǽ�

select count(*) from emp; --14���� row

select count(empno) from emp; --14��

select count(comm) from emp; --6 (null�� �ƴ� �����͸� counting)

select count(nvl(comm,0)) from emp; --14��

--�޿��� ��
select sum(sal) from emp;

select trunc(avg(sal)) from emp;

--����� . . . �� ������ �󸶳� ���޵Ǿ���
select sum(comm) from emp;
--null�� ���� ���
--������ ����� ���� ?
select trunc(avg(comm),0) from emp; --721
select (300+200+30+300+3500+0)/6 from dual; --721
select comm from emp;

--����� ����
select (300+200+30+300+3500+0)/14 from dual; --309
select trunc(avg(nvl(comm,0))) from emp; --309

select max(sal) from emp;
select min(sal) from emp;

select sum(sal) , avg(sal) , max(sal) , min(sal) , count(*) , count(sal)
from emp;

select empno , count(empno) from emp;

--�μ��� ��� �޿��� ���ϼ���
select deptno , avg(sal)
from emp
group by deptno;

--������ ��� �޿��� ���ϼ���
select job , avg(sal)
from emp
group by job;

select avg(sal)
from emp
group by job; --�������� ���� ����� ( ������ �Ǵ� �� �� ���� )

select job, sum(sal) , avg(sal) , max(sal) , min(sal) , count(*) , count(sal)
from emp
group by job;


--�μ��� , ������ �޿��� ���� ���ϼ���

select deptno , job , sum(sal),count(sal)
from emp
group by deptno , job
order by deptno; --�μ���ȣ ... �� �ȿ��� ������ �׷� ... �հ�

/*
select ��    4
from ��      1
where ��     2
group by ��  3
order by ��  5
*/

--������ ��ձ޿��� 3000�޷� �̻��� ����� ������ ��ձ޿��� ����ϼ���
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
select deptno , count(deptno) as �μ��ο�, sum(sal) as "�μ��� �޿��� ��"
from emp
group by deptno
having count(deptno)>4;
--select count(*) from emp where job is null; -- null ���� Ȯ������

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
--create table ���̺�� ( �÷��� Ÿ��, �÷��� Ÿ��)
create table member3(age number);

--������ 1��
insert into member3(age) value(100);

--������ ������
insert into member3(age) value(100);
insert into member3(age) value(200);
insert into member3(age) value(300);

--------------------------------------------------------------------------------

--������ Ÿ��

--����Ŭ �Լ� ......
select * from SYS.NLS_DATABASE_PARAMETERS;
--NLS_CHARACTERSET  : 	AL32UTF8  �ѱ� 3byte �ν�
--KO16KSC5601 2Byte (���� ��ȯ�ϸ� �ѱ� �ٱ���)
select * from nls_database_parameters where parameter like '%CHAR%';
------------------------------------------------------------------------------
create table test2(name varchar2(2));

insert into test2(name) values('a');
insert into test2(name) values('aa');
insert into test2(name) values('��'); --�ѱ� 1�� 3byte ����

-------------------------------------------------------------------------------
?--JOIN ( �ϳ� �̻��� ���̺��� ������ �������� )
--���Կ��� �䱸�ϴ� ���
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


--1. �����(equi join)

--����Ŭ ����
select m.m1 , m.m2 , s.s2
from m, s
where m.m1 = s.s1;

--ANSI ����
select m.m1 , m.m2 , s.s2
from m join s
on m.m1 = s.s1;

select * from emp;

select * from dept;


--�����ȣ , ����̸� , �μ���ȣ , �μ��̸��� ����ϼ��� (ANSI)
select emp.empno, emp.ename, emp.deptno , dept.dname
from emp join dept
on emp.deptno = dept.deptno;

--����(���̺� ����Ī �ο�)
select e.empno, e.ename , e.deptno , d.dname
from emp e join dept d
on e.deptno = d.deptno;


--***������ select * ó���ϰ� ���� �÷��� ����Ѵ�.
select s.s1 , s.s2 , x.x2
from s join x
on s.s1 = x.x1;

select sysdate from dual;
--------------------------------------------------------------------------------
--SQL JOIN ���� (�ܼ�)
select *
from m, s, x
where m.m1 = s.s1 and s.s1 = x.x1;

--ANSI ����(����)
select *
from m join s on m.m1 = s.s1
       join x on s.s1 = x.x1;
--------------------------------------------------------------------------------
--HR �̵�
SHOW USER;
select * from employees;
select * from departments;
select * from locations;

select count(*) from employees;
--��� , �̸�(last_name) , �μ���ȣ , �μ��̸��� ����ϼ���
select e.employee_id, e.first_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id=d.department_id;
--106�� . . .
select * from employees where department_id is null;

--��� , �̸�(last_name) , �μ���ȣ , �μ��̸�, �����ڵ� , ���ø��� ����ϼ���
select e.employee_id, e.last_name, e.department_id, d.department_name, d.location_id, l.city
from employees e join departments d on e.department_id = d.department_id
                 join locations l on d.location_id = l.location_id;
                 
                 
--KOSA ���� �̵�
SHOW USER;

--������ (�÷��� ��ġ�Ǵ� �� ����)
select * from emp;
select * from salgrade;


select *
from emp e join salgrade s 
on e.sal between s.losal and s.hisal;


--outer join (equi ������ ����ǰ� ���� => �����ִ� �����͸� �������� ���)

select *  
from m left outer join s
on m.m1 = s.s1;

select *
from m right outer join s
on m.m1 = s.s1;

select *
from m full outer join s
on m.m1 = s.s1;

--��� , �̸�(last_name) , �μ���ȣ , �μ��̸��� ����ϼ���
--select e.employee_id, e.first_name, e.department_id, d.department_name
--from employees e join departments d
--on e.department_id=d.department_id;

--������ ���� . . �ƿ��� ���� Ȱ���Ͽ�
select e.employee_id, e.first_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id=d.department_id;

--���� ������ (null ��� JOIN >> outer join)
select * from employees where department_id is null; --�����ִٰ� >> outer join

--self join

select * from emp;
--SMITH ����� ��� �̸�
--������̺� , ���������̺� ����� ���� . . . . �ߺ� ������ . . .
select e.empno , e.ename , m.empno , m.ename
from emp e join emp m
on e.mgr = m.empno;
--13�� . . .
--14�� . . . >> outer join

select e.empno , e.ename , m.empno , m.ename
from emp e left join emp m
on e.mgr = m.empno;

select count(*) from emp where mgr is null;
--------------------------------------------------------------------------------
select * from emp;
select * from dept; 
-- 1. ������� �̸�, �μ���ȣ, �μ��̸��� ����϶�.
select e.ename , e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno;
?
-- 2. DALLAS���� �ٹ��ϴ� ����� �̸�, ����, �μ���ȣ, �μ��̸��� ����϶�.
select e.ename , e.job, e.deptno , d.dname
from emp e join dept d on e.deptno = d.deptno
where d.loc = 'DALLAS';

-- 3. �̸��� 'A'�� ���� ������� �̸��� �μ��̸��� ����϶�.
select e.ename, d.dname
from emp e join dept d
on e.deptno = d.deptno
where e.ename like '%A%'; 
?
-- 4. ����̸��� �� ����� ���� �μ��� �μ���, �׸��� ������
--����ϴµ� ������ 3000�̻��� ����� ����϶�.
select e.ename , d.dname, e.sal
from emp e join dept d
on e.deptno = d.deptno
where e.sal > 3000;
?

-- 5. ����(����)�� 'SALESMAN'�� ������� ������ �� ����̸�, �׸���
-- �� ����� ���� �μ� �̸��� ����϶�.
select e.ename , d.dname, e.job
from emp e join dept d
on e.deptno = d.deptno
where e.job='SALESMAN';
?

-- 6. Ŀ�̼��� å���� ������� �����ȣ, �̸�, ����, ����+Ŀ�̼�,
-- �޿������ ����ϵ�, ������ �÷����� '�����ȣ', '����̸�',
-- '����','�Ǳ޿�', '�޿����'���� �Ͽ� ����϶�.
--(�� ) 1 : 1 ���� ��� �÷��� ����
select * from salgrade;

select e.empno as "�����ȣ", e.ename as "����̸�", e.sal*12 as "����", (e.sal*12)+e.comm as "�Ǳ޿�", s.grade as "�޿����"
from emp e join salgrade s
on e.sal between s.losal and s.hisal;
?

-- 7. �μ���ȣ�� 10���� ������� �μ���ȣ, �μ��̸�, ����̸�,
-- ����, �޿������ ����϶�.
select e.deptno, d.dname, e.ename, e.sal, s.grade
from emp e join dept d on e.deptno = d.deptno
           join salgrade s on e.sal between s.losal and s.hisal
where e.deptno = 10;


-- 8. �μ���ȣ�� 10��, 20���� ������� �μ���ȣ, �μ��̸�,
-- ����̸�, ����, �޿������ ����϶�. �׸��� �� ��µ�
-- ������� �μ���ȣ�� ���� ������, ������ ���� ������
-- �����϶�.
select e.deptno, d.dname, e.ename, e.sal, s.grade
from emp e join dept d on e.deptno = d.deptno
           join salgrade s on e.sal between s.losal and s.hisal
where e.deptno in (10,20)
order by e.deptno , e.sal desc;
?
-- 9. �����ȣ�� ����̸�, �׸��� �� ����� �����ϴ� ��������
-- �����ȣ�� ����̸��� ����ϵ� ������ �÷����� '�����ȣ',
-- '����̸�', '�����ڹ�ȣ', '�������̸�'���� �Ͽ� ����϶�.
--SELF JOIN (�ڱ� �ڽ����̺��� �÷��� ���� �ϴ� ���)
select e.empno, e.ename, m.empno , m.ename
from emp e left join emp m
on e.mgr = m.empno;

--------------------------------------------------------------------------------
--������̺��� ������� ��� ���޺��� �� ���� ������ �޴� ����� ���, �̸�, �޿��� ����ϼ���
select avg(sal) from emp; 2073

select empno, ename , sal
from emp
where sal > 2073;


--2���� ���� ���� (�ϳ��� ����)

select empno, ename , sal
from emp
where sal > select avg(sal) from emp;

--subquery

--��� ���̺��� jones �� �޿����� �� ���� �޿��� �޴� ����� ���, �̸�, �޿��� ����ϼ���
select sal from emp where ename = 'JONES';

select *
from emp
where sal > (select sal from emp where ename = 'JONES');

--�μ���ȣ�� 30���� ����� ���� �޿��� �޴� ��� ����� ������ ����ϼ���
select * from emp;
select sal from emp where deptno = 30; --multi row

select *
from emp
where sal in (select sal from emp where deptno = 30);
--sal=1600 or sal=1250 or . . . . .


--�μ���ȣ�� 30���� ����� �ٸ� �޿��� �޴� ��� ����� ������ ����ϼ���
select *
from emp
where sal not in (select sal from emp where deptno = 30);
--sal != 1600 and sal != 1250 . . . 

--���������� �ִ� ����� ����� �̸��� ����ϼ���
select mgr from emp;

select *
from emp
where empno in (select mgr from emp);

--���������� ���� ����� ����� �̸��� ����ϼ���
select *
from emp
where empno not in (select nvl(mgr,0) from emp);
--empno != 7902 and empno != 7698 . . . and null >> null

--king ���� �����ϴ� (�� ���ӻ��)�� king �� ����� ���, �̸� , ����, �����ڻ�� �� ����ϼ���
select empno from emp where ename = 'KING';

select empno, ename, job, mgr
from emp
where mgr = (select empno from emp where ename = 'KING');

--20�� �μ��� ����߿��� ���� ���� �޿��� �޴� ������� �� ���� �޿��� �޴� �����
--���, �̸�, �޿�, �μ���ȣ�� ����ϼ���

select max(sal) from emp where deptno=20;

select empno, ename, sal, deptno
from emp
where sal > (select max(sal) from emp where deptno=20);



--��Į�� ���� ����
select e.empno , e.ename , e.deptno ,(select d.dname from dept d where d.deptno = e.deptno) as dept_name
from emp e
where e.sal >= 3000;

--�ǹ����� ���� ���

--�ڱ� �μ��� ��� ���޺��� �� ���� ������ �޴� ����� ���, �̸�, �μ���ȣ, �μ��� ��տ����� ����ϼ���
--hint1)���࿡ �μ���ȣ�� �μ��� ��� ������ ����ִ� ���̺��� �ִٸ� (�޸𸮿�)
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

--1. 'SMITH'���� ������ ���� �޴� ������� �̸��� ������ ����϶�.
select sal from emp where ename = 'SMITH';

select ename, sal
from emp
where sal > (select sal from emp where ename = 'SMITH');
?
--2. 10�� �μ��� ������ ���� ������ �޴� ������� �̸�, ����,
-- �μ���ȣ�� ����϶�.
select sal from emp where deptno=10;

select ename, sal, deptno
from emp
where sal IN (select sal from emp where deptno=10);

--3. 'BLAKE'�� ���� �μ��� �ִ� ������� �̸��� ������� �̴µ�
-- 'BLAKE'�� ���� ����϶�.
select * from emp;

select deptno from emp where ename = 'BLAKE';

select ename, hiredate
from emp
where deptno = (select deptno from emp where ename = 'BLAKE') and ename != 'BLAKE';
?

--4. ��ձ޿����� ���� �޿��� �޴� ������� �����ȣ, �̸�, ������

-- ����ϵ�, ������ ���� ��� ������ ����϶�.

select trunc(avg(sal)) as avgsal from emp;

select empno, ename, sal
from emp
where sal > (select trunc(avg(sal)) as avgsal from emp)
order by sal desc;

--5. �̸��� 'T'�� �����ϰ� �ִ� ������ ���� �μ����� �ٹ��ϰ�
-- �ִ� ����� �����ȣ�� �̸��� ����϶�.
select deptno from emp where ename like '%T%';

select empno, ename
from emp
where deptno in (select deptno from emp where ename like '%T%');
?
--6. 30�� �μ��� �ִ� ����� �߿��� ���� ���� ������ �޴� �������
-- ���� ������ �޴� ������� �̸�, �μ���ȣ, ������ ����϶�.
--(��, ALL(and) �Ǵ� ANY(or) �����ڸ� ����� ��)
select max(sal) from emp where deptno = 30;
?
select ename, empno, sal
from emp
where sal > (select max(sal) from emp where deptno = 30);
?
select ename, empno, sal
from emp
where sal > ALL(select sal from emp where deptno=30);

--? 7. 'DALLAS'���� �ٹ��ϰ� �ִ� ����� ���� �μ����� ���ϴ� �����
-- �̸�, �μ���ȣ, ������ ����϶�.
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
WHERE DEPTNO IN(SELECT DEPTNO    -- = �� �´µ�  IN
                FROM DEPT
                WHERE LOC='DALLAS');
                
--8. SALES �μ����� ���ϴ� ������� �μ���ȣ, �̸�, ������ ����϶�.
select * from emp;
?
select e.deptno, e.ename, e.job
from emp e join dept d on e.deptno = d.deptno
where dname = 'SALES';

?
--9. 'KING'���� �����ϴ� ��� ����� �̸��� �޿��� ����϶�
--king �� ����� ��� (mgr �����Ͱ� king ���)
select * from emp;
?
select ename, sal
from emp
where mgr = (select empno from emp where ename = 'KING');
?

--10. �ڽ��� �޿��� ��� �޿����� ����, �̸��� 'S'�� ����
-- ����� ������ �μ����� �ٹ��ϴ� ��� ����� �����ȣ, �̸�,
-- �޿��� ����϶�.

select trunc(avg(sal)) from emp;

select empno, ename, sal
from emp
where sal > (select avg(sal) from emp)
and deptno in (select deptno from emp where ename like '%S%');


--11. Ŀ�̼��� �޴� ����� �μ���ȣ, ������ ���� �����
-- �̸�, ����, �μ���ȣ�� ����϶�.
select deptno, sal from emp where comm is not null;

select ename, sal, empno
from emp
where deptno in (select deptno from emp where comm is not null)
and sal in (select sal from emp where comm is not null);


--12. 30�� �μ� ������ ���ް� Ŀ�̼��� ���� ����
-- ������� �̸�, ����, Ŀ�̼��� ����϶�.
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
--�⺻���� DML ���� ( �ϱ� �ʼ� )
 
select * from tab; --�����(KOSA) ������ ������ �ִ� ���̺� ���
  
--���� ���̺��� ���� . . .�� �̸��� �ִ� �� ���� ��
select * from tab where tname='BOARD';
select * from tab where tname='EMP';

select * from col where tname='EMP';
--------------------------------------------------------------------------------
--insert , update , delete ������ �ϱ�

--1. INSERT
create table temp(
    id number primary key, --not null , unique�� �����͸� �ްڴ�. (ȸ��ID , �ֹι�ȣ)
    name varchar(20)
);

desc temp;

--1. �Ϲ����� insert ����
insert into temp(id,name)
values(100,'ȫ�浿');

--commit , rollback �ϱ� ������ �ǹݿ� X
select *from temp;
commit;

--2. �÷� ��� ���� (insert)   �� �ǵ����̸� ���� ����
insert into temp
values(200,'������');

select * from temp;
rollback;

--3. ���� . . . insert
insert into temp(name)
values('�ƹ���');
--�ڵ����� id �÷� => null >> PK �� �ɸ� ORA-01400: cannot insert NULL into ("KOSA"."TEMP"."ID")

insert into temp(id,name)
values(100,'������');
--PK >> id >> �ߺ� ������(x) >> ORA-00001: unique constraint (KOSA.SYS_C007000) violated

insert into temp(id,name)
values(200,'������');

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
    memberid number(3) not null, --3�ڸ� ����
    name varchar2(10), --null ���
    regdate date default sysdate --���̺� �⺻�� ���� (insert ���� ������ �ڵ����� [��¥]) ���� �ϰڴ�.
);

desc temp3;

select sysdate from dual;

--1. ����
insert into temp3(memberid, name, regdate)
values(100,'ȫ�浿','2023-04-19');

select * from temp3;
commit;

--2. ��¥ ����
insert into temp3(memberid,name)
values(200,'������'); --default sysdate

select * from temp3;
commit;

--3. �÷� �ϳ���
insert into temp3(memberid)
values(300);

select * from temp3;
commit;

--4. ����
insert into temp3(name)     -- id null �� >> not null
values('������');

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
--�뷮 ������ �����ϱ�
select * from temp5;
--temp4 ���̺� �ִ� ��� �����͸� temp5�� �ְ� �;��.(Ÿ�Ը� ��ġ�ϸ�)
--insert into ���̺��(�÷�����Ʈ) values(��)
--insert into ���̺��(�÷�����Ʈ) select �� *************************
 insert into temp5(num)
 select id from temp4; --�뷮 ������ ����
 
 select * from temp5;
 commit;

--2. �뷮 ������ �����ϱ�
-- �����͸� ���� ���̺� ���� >> ���̺� ����(����):��Ű�� + ������ ����
-- �� ���������� ������ �� ���� (PK , FK , not null ���)
-- ������ ������ ���� + ������

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


--�丷 ����
--Ʋ��(��Ű��) ���� �����ʹ� �����ϰ� ���� �ʾƿ�
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

--���ǰ����� �����
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
--�������� Ȯ���ϱ� (�ݵ��)
select * from user_constraints where lower(table_name) = 'emp';




