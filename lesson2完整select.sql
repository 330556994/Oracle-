--�ٴ����ģʽ
--ģʽ�����û�����һ���û�һ��ģʽ��ģʽ��������֯���ݶ����
select * from tbemp; --��дģʽ����ʾ�ǵ�ǰģʽ�µı�
select * from scott.emp;

--�߱�Ȩ�޵��˺ţ���system

grant all on scott.emp to BOOKSHOP;-- ����ĳ���û�ĳ��ģʽ��ĳ�������ȫ��Ȩ��

--Create the user 
create user scott2
  identified by "tiger"
  default tablespace USERS;
  
  grant unlimited tablespace to bookshop;
  grant connect to scott;
grant resource to scott;
-------------------------------------------------------------------------------------------------------------
���������ԣ�
���壺���ݿ�Ҫ��֤����ŵ���������ȷ�ġ�����Ҫʹ�����������������ݵ���ȷ��
 һ��ʵ��������
   1.��֤ʵ���������ģ��磺����ҵ�����У�Ա����ţ������ظ����ֻ����벻���ظ�
      ����Լ�� primary key ��Ψһ���ظ���һ�ű�ֻ��һ������������Ϊ��
      Ψһ��Լ�� unique  : Ψһ���ظ������Զ��������Ϊ��
   --�����������Լ��
   alter table TBEMP
      add constraint pk_id primary key (id);
   --�������Ψһ�� phone
   alter table TBEMP
  add constraint uk_phone unique (PHONE);
----------------------------------------------------------------
--��֤һ��
select * from tbemp   
 insert into tbemp(id,name,birthday,phone,sex,salary)
  values(6,'�Ͻ�',to_date('1998-10-5','yyyy-mm-dd'),'13812345478',1,4500 );

������������
  ��֤һ����Ԫ�����������
  Ϊ��Ԫ��ȷ����Ӧ���������ͣ�
  ����Ϊ�� not null
   ���Լ�� 
    Ĭ��ֵ
    --�޸ı���phone�޸ĳ�not null
  alter table TBEMP modify phone not null;
  --���Լ����һ������֤����У��� �ɼ�>90 �Ա�:�л�Ů  0��1
  alter table TBEMP
  add constraint chk_salary  check (salary>1000);
  --Ĭ��ֵ ��һ����ʡ�Ե����������Ĭ��ֵ
  alter table TBEMP modify sex default 0;
  --��֤��
    insert into tbemp(id,name,birthday,phone,sex,salary)
  values(7,'����',to_date('1998-10-5','yyyy-mm-dd'),'1234',1,1980 );
  select * from tbemp;
    insert into tbemp(id,name,birthday,phone,salary)
  values(8,'����',to_date('1998-10-5','yyyy-mm-dd'),'1234666',1980 );
�������������ԣ��ֽв���������
 Ա������             Ա��  ����  ��������
   1   �г���          1         aa       1
   2   ����          2        bb        2
   3  ���²�           3       cc         3
 
���Ա��3 ��¼���ڣ��������ˣ����ݲ��ԣ������ܳ��ֲ���5��Ϊ�˽��������
Լ����ʹ�����Լ�������ܹ�ʵ�֣����е�ֵ�����ǲ��ձ����е�ֵ��
һ������Ҫ������Լ����Ҫ���õı���б���Ψһ���ظ�
create table tbDepartment(
   id int primary key,--���ű��
   name varchar2(50) not null unique --ΨһԼ���Ͳ���Ϊ��
)
--���Բ���ʱʡ���б���ôֵ�������˳��ʾһһ��Ӧ
insert into tbdepartment values(1,'�г���');
insert into tbdepartment values(2,'����');
insert into tbdepartment values(3,'������');
select * from tbdepartment    
 --ΪԱ�������һ���������ű�ŵ���
 alter table TBEMP add did int ;  
 select * from tbemp 
  --Ϊtbemp��������Լ��������tbDepartment.id��
  --ǰ��Ҫ��tbDeparment���id�б�����ΨһԼ����
  --did�е����ͱ��������������һ��
  alter table TBEMP
  add constraint fk_did foreign key (DID)
  references tbdepartment (ID);
  --
  select * from tbemp;
  ------------------------------------------
  --�򵥲�ѯ select * from tbemp
  -- ɾ�� delete from tbemp where id=1
  --�޸����ݵ�����
  -- update tbemp set did=1 where id=2
   update tbemp set did=3 where id=5  
 -----------------------------------------------------------------------------------------------------------------
  --ע�⣺�Ƚ���Ȼ�󽨸���Լ����������Ϻ������������ݡ�
  --��������Ѿ����������ݣ����п���Լ���Ὠ�����ˡ�
  ----------------------------------------------------------------------------------------------------------------
  --��⼶��ɾ���ĺ���
  --  tbDepartment  �� tbemp
  --ɾ�� ���ű��1 ����ɾ�����ű��2 
  --�ĸ�����ɾ����Ϊʲô��
  -- ���ӱ�ĸ����tbDepartment���� tbempΪ�ӱ�
  -- һ���������ж��Ա����һ��Ա��ֻ��һ��������
  --���ӱ��д�������ļ�¼ʱ���޷�ɾ�������¼��
  --����ɾ���أ��ڽ������ʱ������ on delete cascade;������ɾ��
  --��ɾ�������¼ʱ����ɾ���ӱ��¼��һ�㲻�ṩ����ɾ��
  select  * from tbdepartment;
  select * from tbemp;
  delete from tbdepartment where id=2
  
 =========================================================
 --DCL ������Ȩ������û�
 --DDL ���ݿⶨ������ create ,alter
 --DML ���ݿ��������  select,insert,update,delete��
 --
 --���� 
 -- insert into ���� (�б�) values(ֵ��)
   insert into tbemp(id,name,birthday,phone,sex,salary)
  values(1,'����',to_date('1998-10-5','yyyy-mm-dd'),'13812345678',1,4500 );
  -- update ����
  -- update ���� set ����=ֵ,��2=ֵ2,��3=ֵ3 where ����
  --û��������ȫ������
  select * from tbemp; 
  -- ���� ���ʴ���4000Ԫ�� Ա������did�ĳ�2
  update tbemp set did=2 where salary>4000;
 insert into tbdepartment values(2,'���̲�');
 --ɾ�� 
 --delete from ���� where ��������������ȫ��ɾ��
 -----------------------------------------------------------------------------------
 --select ��ѯ
 --�ǳ��ǳ���Ҫ
 -- select �б� from ���� where ����   *����ȫ����
 select * from emp;
 select empno,ename from emp;
 --���Ը��б���
 select empno as ���,ename as ���� from emp;
 --�����������У��ȸ��в��ڱ��
select empno,ename,sal,comm,sal+comm as totalsal from emp; 
--��Ϊcomm�е����ǿգ�����ô�죬����һ������ nvl(exp1,exp2)
--exp1��ֵ��null������ֵΪexp2.������exp1
select empno,ename,sal,comm,nvl(sal,0)+nvl(comm,0)  as totalsal from emp; 
--ʹ��where����
--ֻ�����ֲ�Ҫ�ӵ����ţ�������Ҫ,����Ҳ���Լӵ����š�
--   =  > >=  < <= != ,between ... and ...
--  and ��  or ��
--��ѯ�����ű��Ϊ30��Ա�������һ�������>2000
select * from emp where deptno=30 and sal>2000;
--��ѯ�����и�λ�Ǿ��� manager�Ĳ���н����1500-3000֮��Ա����
--��ʾ��ź������͸�λ,н��
select empno,ename,job,sal from emp 
    where job='MANAGER' and  sal between 1500 and 3000; --sal>=1500 and sal<=3000
   --ʹ�� distinct ɾ���ظ���
   select distinct deptno from emp;
   --
   --ʹ��order by������
   --�﷨order by ���� [asc/desc],[��2 asc/desc]
   --���չ��������� asc�� desc�� ,Ĭ����asc
   select * from emp order by sal desc
   --���򣬰��ղ��ű�����򣬴Ӹߵ��ͣ����������ͬ�����չ��ʴӵ͵���
   select * from emp order by deptno desc ,sal 
   --�ۺϺ���--ͳ��
   -- sum() ���,avg()ƽ��ֵ count()����,max()���ֵ  min()��Сֵ
   select  count(*) as ��¼����,round(avg(sal),2) ƽ������,sum(sal) �����ܺ�,
     max(sal) ����� ,min(sal) ��С���� from emp where deptno=20;
   --����ͳ��
   --group by ��1[,��2]
    select deptno,  count(*) as ��¼����,round(avg(sal),2) ƽ������,sum(sal) �����ܺ�,
     max(sal) ����� ,min(sal) ��С���� from emp group by deptno
     --��where��group
    select deptno,  count(*) as ��¼����,round(avg(sal),2) ƽ������,sum(sal) �����ܺ�,
     max(sal) ����� ,min(sal) ��С���� from emp where job!='MANAGER' 
      group by deptno;
   -- ��having��group
   --where ��having����
   --��where���ˣ�Ȼ�󣬷��飬���having
    select deptno,  count(*) as ��¼����,round(avg(sal),2) ƽ������,sum(sal) �����ܺ�,
     max(sal) ����� ,min(sal) ��С���� from emp where job!='MANAGER' 
      group by deptno having avg(sal)>2000
--
--��������������ѯ��having��ʱ���Ը�where���Ե�   
--���ԣ���һ�������ܸ��õ㡣
  select deptno,  count(*) as ��¼����,round(avg(sal),2) ƽ������,sum(sal) �����ܺ�,
     max(sal) ����� ,min(sal) ��С���� from emp where job!='MANAGER' and  deptno=20
      group by deptno 
      --
      select deptno,  count(*) as ��¼����,round(avg(sal),2) ƽ������,sum(sal) �����ܺ�,
     max(sal) ����� ,min(sal) ��С���� from emp where job!='MANAGER'   
      group by deptno having deptno=20
------------------------------------------
   --��Ϸ���
   select deptno,job,  count(*) as ��¼����,round(avg(sal),2) ƽ������,sum(sal) �����ܺ�,
     max(sal) ����� ,min(sal) ��С���� from emp group by deptno,job;   
     --
     --�����ڵ������������ְ����Ϊ1981���Ա��
 select * from emp where hiredate between to_date('1981-01-01','yyyy-mm-dd')
    and to_date('1981-12-31','yyyy-mm-dd');
--to_char(date,'����ʽ') ������ת�����ַ���to_number(�ַ�) ת��������
  select * from emp where to_number( to_char( hiredate ,'yyyy'))=1981;
 ======================================================
 -- ģ��ƥ�� �ַ������ң�һ���ַ������Ҷ�����ģ��ƥ��
 --��ѯ�� ��λjob�а��� sale    % �������ַ�  _ ���ⵥ��
 --  where name like '��%'   '%��'   '%��%'  
 --Ӣ���ַ����ִ�Сд�ģ�
 --Ҫ�����ִ�Сд��
 select * from emp where job like '%SALE%'
 --ʹ��lower()ת����Сд�ڱȽ�
  select * from emp where  lower(job) like '%sale%'
 ========================================================
 -- ���ϵĲ���
 -- ���� union(�Զ�ɾ���ظ���) , union all ��ɾ���ظ���
 --�������������۱�2016,2015
 --��������ѯ����Ҫ���㣺�еĸ���һ��,�е�����Ҫһ��
 select empno,ename,deptno from emp where deptno=20
 union
 select empno,ename,deptno from emp where deptno=30
 -- ����  (1,2,3,4) --(1,3)=(2,4)
 --��ѯ����5������10���ļ�¼
 --rownum���α�з��ص���1��ʼ����ţ������һ��ʼ
 --����Ƚ���Ҫ��һ�㳣���ڷ�ҳ��ѯ��
 select  rownum, empno,ename,deptno from emp where rownum<=10
 minus
  select  rownum, empno,ename,deptno from emp where rownum<=5
 --���� intersect ����������������ͬ����Ϣ
 select * from emp where deptno=20 or deptno=30
 intersect
  select * from emp where deptno=10 or deptno=20
----------------------------------------------------------------------------------------
--������  A-B ֮�����й�ϵ�ģ����ӹ�ϵ  1:�� ��ϵ����(Ψһ)��� 
 --
 -- ���ӷֳɣ� �����ӣ������ӣ�������
 select * from dept;
 select * from emp;
 ��� Ա����ţ���������λ�����ű�ţ��������ƣ��������ڵ�
 --�����ӣ� A��B�� �����ڵ����ݻ���ʾ
 --�������������ӣ��ѿ�������M*N��,
 --where ��������������ͨ�������
 --д��1
 select emp.empno,emp.ename,emp.job
 ,dept.deptno,dept.dname,dept.loc from emp ,dept where emp.deptno=dept.deptno
 --д��2
 select a.*,b.* from emp  a inner join dept  b
 on a.deptno=b.deptno;
select * from emp; Ա����
select * from  salgrade;���ʵȼ���
Ҫ��: empno,ename,sal,grade,losal,hisal 
------------------------------------------------------------
 select empno,ename,sal,grade,losal,hisal from emp 
 inner join salgrade on sal between losal and hisal
=========================================
 select empno,ename,sal,grade,losal,hisal from emp ,salgrade
where sal between losal and hisal
====================================
--�����ӣ������⣬���⡿
--���⣬���ʾ�����ұ�ʾ�ӱ�������ÿһ����¼�ʹӱ���ļ�¼ƥ��
--ƥ�䵽�Ļ���ʾ��ƥ�䲻������null���
select a.* ,b.* from dept a 
left join emp b on a.deptno=b.deptno
--��ѯ���ű���ʾû��Ա���Ĳ�����Ϣ��
--�ر�ע���£����һ����Ϊnull���ж�һ�����Ƿ���null ������ =null Ӧ����
--is null
select a.* from dept a 
left join emp b on a.deptno=b.deptno where empno is null
=================================================
--������ �Լ����Լ����ӣ����԰�һ�ű����Ƕ��ű�
--�и����󣺲�ѯ�����й�Ա�;�������֡�
--һ�ű���Ҳ������һ�Զ�Ĺ�ϵ����emp��empno Ա�����  mgr������
--������У������ţ�һ�������쵼�����Ա��һ����Աֻ��һ������
select * from emp
Ҫ���г� empno,ename,job ,mgr,mgrname,mgrjob 
select a.empno,a.ename,a.job,b.empno mgr,b.ename mgrname,b.job mgrjob from
emp a,emp b where a.mgr=b.empno
------------------
Ҫ�� �г��ĸ���Աû����������ʾempno,ename,job

select a.empno,a.ename,a.job from emp a
left join emp b on a.empno=b.mgr where b.mgr is null
--��֤
select * from emp where mgr=7369

-----------------------------------------------------------------------
--�Ӳ�ѯ  : �ڲ�ѯ��Ƕ�ײ�ѯ
-- �Ƚ������ > ,>=,!=,= ,<,<= ������������ұ��ǵ���ֵ
-- ���ӵ���������ϣ��ұ��Ƕ��ֵ
-- in  ��ʲô�� where id in (3,5,6)
select * from emp where empno in (7369,7499,7844)
--  not in ���ڷ�Χ��
select * from emp where empno not in (7369,7499,7844)
-- any all
-- any ����һ��ֵ��ĳ��ֵ���൱�ڴ�����С��һ��
-- all ȫ��  >all ��������һ��ֵ
--> any  sal >any(100,200,150,500)
-- �ұߵ��б�������ĳ����ѯ��̬�����ģ������ֻ��ѯ
--��ѯ�ĸ�������û��Ա��
--�Ӳ�ѯ�ﷵ�ص��ǵ�����
select * from dept where deptno not in( 
   select distinct deptno from emp
)

--Ա�����Ϊ7369�ĳ���ƽ������
select * from emp where sal>(
select avg(sal) from emp where deptno=(
select deptno from emp where empno=7369)
)
 and deptno=(
select deptno from emp where empno=7369
)
��Ա�����ڲ��ŵ�ƽ������ 7369
select avg(sal) from emp where deptno=(
select deptno from emp where empno=7369)
-------------------
--emp�в�ѯ�������ʳ������ڲ���ƽ�����ʵĹ�Ա
select a.* from emp a ,(
 select deptno,avg(sal) avgsal from emp group by deptno) b where a.deptno=b.deptno
  and a.sal>b.avgsal
--
select empno,ename,sal,deptno from emp e1 where sal>(
       select avg(sal) from emp e2 where e1.deptno=e2.deptno
)
--�г��ڲ��š�SALES��������Ա��������
--�Ӳ�ѯ
select ename from emp where deptno in (
  select deptno from dept where Dname='SALES');
--������
select ename from emp inner join dept
on emp.deptno=dept.deptno where dept.dname ='SALES';
--�г����в��ŵ���ϸ��Ϣ�Ͳ���������
-- dept      ��  deptno    counts��
select a.*,t1.counts from dept a ,(
select deptno ,count(*) as counts from emp group by deptno
) t1 where a.deptno=t1.deptno


--�г���ÿ�����ŵĲ��ű�ţ��������ƣ�Ա��������ƽ������
  dept   [deptno  counts avgsal]
select a.*,t1.counts,t1.avgsal from dept a ,(
select deptno ,count(*) as counts,avg(sal) avgsal from emp group by deptno
) t1 where a.deptno=t1.deptno


--- �г���ÿ�����ŵĲ��ű�ţ��������ƣ�Ա��������ƽ�����ʣ�ƽ����������

select   to_number(   to_char(sysdate,'yyyy')) from dual;
select empno,ename, hiredate,
to_number(   to_char(sysdate,'yyyy'))-to_number(   to_char(hiredate,'yyyy')) years from emp;

select * from emp;
select * from dept
=========================================================
==��������
==������ rank ���ܼ�����,  dense_rank,row_number
--���󣬶�emp������ݣ�����Ա������������
--over()������������á� over���������ʽ�����Ƕ��
--���ܼ�
select empno,ename,sal, rank()over(order by sal desc ) salrank  from emp;
--�ܼ�����
select empno,ename,sal, dense_rank()over(order by sal desc ) salrank  from emp;
--row_number()����һ��Ψһ���
select row_number()over(order by sal desc,empno asc ) rownumber , empno,ename,sal  from emp;
--�������� --������������
select empno,ename,sal,deptno,
 rank()over(partition by deptno order by sal desc  ) salrank  from emp;
-- ���չ���������ʾ��5��10����¼�� ������rownumα��
==================
--����ʹ�÷�������row_number()��ҳ��
--˵����һ����ѯ�������������ţ����һ�������ĳЩ���������
select * from(
select row_number()over(order by sal  ) rownumber , empno,ename,sal  from emp 
) t1 where rownumber between 5 and 10
==================
-- exists ����
--not exists������
--��ѯ��Աнˮ����3000�Ĳ�������
select * from dept d where exists(
      select empno,ename,sal,deptno from emp e where sal>3000 and d.deptno=e.deptno );
--�ȼ۵�
select * from dept  where deptno in (
      select deptno from emp  where sal>3000 );
--������
select a.* from dept a ,emp b where a.deptno=b.deptno and b.sal>3000;

--��ʵ������Ҳ�����в�ѯ
--����Ĳ�ѯ����ʵ���Կ�������һ��ֵ���ˣ����ص��е���
--��ʾempno,ename,sal,salminus 
--salminus ���Լ��Ĺ��ʺ�ƽ�����ʵĲ��
select empno,ename,round((select avg(sal) from emp),0) avgsal,sal,
round(sal-(select avg(sal) from emp ),0)  as salminus from emp;












insert into dept values(50,'programmer','��ʢ��')
  
  create table dept2 (
         dno int primary key,
         dname varchar2(50)
  )
  --��������
  insert into dept2 select deptno,dname from dept
  select * from dept2
  ----------------------------------
    commit;






