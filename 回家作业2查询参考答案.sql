1.�г�����Ա������������ֱ����˾��������
    select a.ename,b.ename mgrname  from
emp a,emp b where a.mgr=b.empno
��2���г��ܹ�����������ֱ����˾��Ա����������
    Ա����š����źš�
    select a.empno,a.ename,a.deptno  from
emp a,emp b where a.mgr=b.empno and a.hiredate<b.hiredate
    
��5���г���ÿ�����ŵ�Ա��������ƽ�����ʺ�ƽ������������
select  empno,ename, hiredate,
to_number(   to_char(sysdate,'yyyy'))-to_number(   to_char(hiredate,'yyyy')) years,deptno
 from emp;
 --sysdate �õ���ǰ����
 --to_char ת�����ַ���,round() ��������
select  deptno,count(*) as counts,round(avg(sal),2),round( avg(
to_number(   to_char(sysdate,'yyyy'))-to_number(   to_char(hiredate,'yyyy'))),2) as  countyears
 from emp group by deptno;
��7���г�����ְλ����͹��ʡ�
select * from emp;
select job,min(sal) as minsal from emp group by job

(8)�г����ž����й�����͵��Ǹ���������������ʡ����źš�
select ename,sal,deptno from emp where job='MANAGER'
 and sal=(select  min(sal) as minsal  from emp where job='MANAGER') 
��9���г�����Ա�����깤�ʣ���Ӷ�𣩣�����н�ӵ͵�������
select empno,ename ,((sal+nvl(comm,0))*12) as yearsal from emp order by sal asc ;
--(10)����SALES����������Ա����Ӷ�����������н��30%��
update emp set comm=sal*0.3 WHERE deptno in (
select deptno from dept where dname='SALES')
 --
 select * from tab;
 select * from employees
 ---------------------------------------------------------
 --ʹ��oracle�ṩ�������dual �����Ժ���
 ---------------------------------------------------------
 select months_between(to_date('2015-2-9','yyyy-mm-dd'),to_date('2011-1-10','yyyy-mm-dd'))
from dual 
2����HR�û���EMPLOYEES���е�ÿ����Ա��
��ѯ��ʾ��Ա����LAST_NAME��
������ÿ����Ա�ӱ�Ƹ����HIRE_DATE��������Ĺ���������
�Ը������ñ���MONTH_WORKED��
������������������λ�������������������������
select last_name,round(months_between(sysdate,hire_date),0) MONTH_WORKED
  from employees
 2
 ��HR�û���EMPLOYEES���ѯ
 ����Davies��Ƹ�õĹ�Ա����
 LAST_NAME��Ƹ������HIRE_DATE��
 SELECT LAST_NAME,HIRE_DATE FROM employees where hire_date >(
 select HIRE_DATE from employees where last_name='Davies')
 ==========================================================
 --�ڶ����к�������
  ---------------------------------------------------------
 --ʹ��oracle�ṩ�������dual �����Ժ���
 ---------------------------------------------------------
 select initcap('hello') from dual
 
 select instr('abcde','a') from dual
 
 select decode(deptno,20,'�г���',30,'������','δ֪') dname from emp;
 
 
 
 
 



