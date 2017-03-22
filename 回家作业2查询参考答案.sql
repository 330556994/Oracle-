1.列出所有员工的姓名及其直接上司的姓名。
    select a.ename,b.ename mgrname  from
emp a,emp b where a.mgr=b.empno
（2）列出受雇日期早于其直接上司的员工的姓名、
    员工编号、部门号。
    select a.empno,a.ename,a.deptno  from
emp a,emp b where a.mgr=b.empno and a.hiredate<b.hiredate
    
（5）列出在每个部门的员工数量、平均工资和平均工作年数。
select  empno,ename, hiredate,
to_number(   to_char(sysdate,'yyyy'))-to_number(   to_char(hiredate,'yyyy')) years,deptno
 from emp;
 --sysdate 得到当前日期
 --to_char 转换到字符串,round() 四舍五入
select  deptno,count(*) as counts,round(avg(sal),2),round( avg(
to_number(   to_char(sysdate,'yyyy'))-to_number(   to_char(hiredate,'yyyy'))),2) as  countyears
 from emp group by deptno;
（7）列出各种职位的最低工资。
select * from emp;
select job,min(sal) as minsal from emp group by job

(8)列出部门经理中工资最低的那个经理的姓名、工资、部门号。
select ename,sal,deptno from emp where job='MANAGER'
 and sal=(select  min(sal) as minsal  from emp where job='MANAGER') 
（9）列出所有员工的年工资（含佣金），按年薪从低到高排序。
select empno,ename ,((sal+nvl(comm,0))*12) as yearsal from emp order by sal asc ;
--(10)将“SALES”部门所有员工的佣金提高至其月薪的30%。
update emp set comm=sal*0.3 WHERE deptno in (
select deptno from dept where dname='SALES')
 --
 select * from tab;
 select * from employees
 ---------------------------------------------------------
 --使用oracle提供的虚拟表，dual 来测试函数
 ---------------------------------------------------------
 select months_between(to_date('2015-2-9','yyyy-mm-dd'),to_date('2011-1-10','yyyy-mm-dd'))
from dual 
2、对HR用户的EMPLOYEES表中的每个雇员，
查询显示雇员名字LAST_NAME，
并计算每个雇员从被聘用起（HIRE_DATE）到今天的工作月数，
对该列设置别名MONTH_WORKED。
工作月数保留到整数位数，结果按工作月数升序排序。
select last_name,round(months_between(sysdate,hire_date),0) MONTH_WORKED
  from employees
 2
 从HR用户的EMPLOYEES表查询
 晚于Davies被聘用的雇员名字
 LAST_NAME和聘用日期HIRE_DATE。
 SELECT LAST_NAME,HIRE_DATE FROM employees where hire_date >(
 select HIRE_DATE from employees where last_name='Davies')
 ==========================================================
 --第二章中函数部分
  ---------------------------------------------------------
 --使用oracle提供的虚拟表，dual 来测试函数
 ---------------------------------------------------------
 select initcap('hello') from dual
 
 select instr('abcde','a') from dual
 
 select decode(deptno,20,'市场部',30,'技术部','未知') dname from emp;
 
 
 
 
 



