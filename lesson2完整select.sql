--再次理解模式
--模式就是用户名，一个用户一个模式，模式是用来组织数据对象的
select * from tbemp; --不写模式，表示是当前模式下的表
select * from scott.emp;

--具备权限的账号，如system

grant all on scott.emp to BOOKSHOP;-- 授予某个用户某个模式下某个对象的全部权限

--Create the user 
create user scott2
  identified by "tiger"
  default tablespace USERS;
  
  grant unlimited tablespace to bookshop;
  grant connect to scott;
grant resource to scott;
-------------------------------------------------------------------------------------------------------------
数据完整性：
意义：数据库要保证，存放的数据是正确的。就需要使用完整性来保存数据的正确性
 一、实体完整性
   1.保证实体是完整的，如：在企业运用中，员工编号，不能重复，手机号码不能重复
      主键约束 primary key ：唯一不重复。一张表只有一个主键。不能为空
      唯一键约束 unique  : 唯一不重复，可以多个，可以为空
   --给表添加主键约束
   alter table TBEMP
      add constraint pk_id primary key (id);
   --给表添加唯一键 phone
   alter table TBEMP
  add constraint uk_phone unique (PHONE);
----------------------------------------------------------------
--验证一下
select * from tbemp   
 insert into tbemp(id,name,birthday,phone,sex,salary)
  values(6,'老金',to_date('1998-10-5','yyyy-mm-dd'),'13812345478',1,4500 );

二、域完整性
  保证一个单元格的数据完整
  为单元格，确定相应的数据类型，
  不能为空 not null
   检查约束 
    默认值
    --修改表，把phone修改成not null
  alter table TBEMP modify phone not null;
  --检查约束：一般是验证这个列，如 成绩>90 性别:男或女  0或1
  alter table TBEMP
  add constraint chk_salary  check (salary>1000);
  --默认值 当一个列省略的情况，则用默认值
  alter table TBEMP modify sex default 0;
  --验证下
    insert into tbemp(id,name,birthday,phone,sex,salary)
  values(7,'老王',to_date('1998-10-5','yyyy-mm-dd'),'1234',1,1980 );
  select * from tbemp;
    insert into tbemp(id,name,birthday,phone,salary)
  values(8,'老王',to_date('1998-10-5','yyyy-mm-dd'),'1234666',1980 );
三、引用完整性：又叫参照完整性
 员工部门             员工  姓名  所属部门
   1   市场部          1         aa       1
   2   财务部          2        bb        2
   3  人事部           3       cc         3
 
如果员工3 记录存在，则疑问了，数据不对，不可能出现部门5，为了解决这样的
约束，使用外键约束。（能够实现，该列的值必须是参照表里列的值）
一个表里要添加外键约束，要引用的表的列必须唯一不重复
create table tbDepartment(
   id int primary key,--部门编号
   name varchar2(50) not null unique --唯一约束和不能为空
)
--可以插入时省略列表，那么值必须和列顺序示一一对应
insert into tbdepartment values(1,'市场部');
insert into tbdepartment values(2,'财务部');
insert into tbdepartment values(3,'技术部');
select * from tbdepartment    
 --为员工表添加一个所属部门编号的列
 alter table TBEMP add did int ;  
 select * from tbemp 
  --为tbemp列添加外键约束，引用tbDepartment.id列
  --前提要求：tbDeparment里的id列必须是唯一约束。
  --did列的类型必须和引用列类型一致
  alter table TBEMP
  add constraint fk_did foreign key (DID)
  references tbdepartment (ID);
  --
  select * from tbemp;
  ------------------------------------------
  --简单查询 select * from tbemp
  -- 删除 delete from tbemp where id=1
  --修改数据的命令
  -- update tbemp set did=1 where id=2
   update tbemp set did=3 where id=5  
 -----------------------------------------------------------------------------------------------------------------
  --注意：先建表，然后建各种约束。创建完毕后，再添加添加数据。
  --如果表中已经存在了数据，很有可能约束会建立不了。
  ----------------------------------------------------------------------------------------------------------------
  --理解级联删除的含义
  --  tbDepartment  和 tbemp
  --删除 部门编号1 ，再删除部门编号2 
  --哪个可以删除？为什么？
  -- 主从表的概念，把tbDepartment主表 tbemp为从表
  -- 一个部门里有多个员工，一个员工只在一个部门里
  --当从表中存在主表的记录时，无法删除主表记录。
  --级联删除呢？在建立外键时，加上 on delete cascade;允许级联删除
  --当删除主表记录时，会删除从表记录。一般不提供级联删除
  select  * from tbdepartment;
  select * from tbemp;
  delete from tbdepartment where id=2
  
 =========================================================
 --DCL 例如授权，添加用户
 --DDL 数据库定义语言 create ,alter
 --DML 数据库操作语言  select,insert,update,delete等
 --
 --插入 
 -- insert into 表名 (列表) values(值表)
   insert into tbemp(id,name,birthday,phone,sex,salary)
  values(1,'张三',to_date('1998-10-5','yyyy-mm-dd'),'13812345678',1,4500 );
  -- update 更新
  -- update 表名 set 列名=值,列2=值2,列3=值3 where 条件
  --没有条件，全部更新
  select * from tbemp; 
  -- 更新 工资大于4000元的 员工，把did改成2
  update tbemp set did=2 where salary>4000;
 insert into tbdepartment values(2,'工程部');
 --删除 
 --delete from 表名 where 条件，无条件是全部删除
 -----------------------------------------------------------------------------------
 --select 查询
 --非常非常重要
 -- select 列表 from 表名 where 条件   *代表全部列
 select * from emp;
 select empno,ename from emp;
 --可以给列别名
 select empno as 编号,ename as 姓名 from emp;
 --可以有虚拟列，既该列不在表里，
select empno,ename,sal,comm,sal+comm as totalsal from emp; 
--因为comm有的行是空，那怎么办，引入一个函数 nvl(exp1,exp2)
--exp1的值是null，则函数值为exp2.否则是exp1
select empno,ename,sal,comm,nvl(sal,0)+nvl(comm,0)  as totalsal from emp; 
--使用where条件
--只有数字不要加单引号，其他都要,数字也可以加单引号。
--   =  > >=  < <= != ,between ... and ...
--  and 与  or 或
--查询出部门编号为30的员工，并且基本工资>2000
select * from emp where deptno=30 and sal>2000;
--查询出所有岗位是经理 manager的并且薪资在1500-3000之间员工，
--显示编号和姓名和岗位,薪资
select empno,ename,job,sal from emp 
    where job='MANAGER' and  sal between 1500 and 3000; --sal>=1500 and sal<=3000
   --使用 distinct 删除重复行
   select distinct deptno from emp;
   --
   --使用order by来排序
   --语法order by 列名 [asc/desc],[列2 asc/desc]
   --按照工资来排序 asc升 desc降 ,默认是asc
   select * from emp order by sal desc
   --排序，按照部门编号排序，从高到低，如果部门相同，则按照工资从低到高
   select * from emp order by deptno desc ,sal 
   --聚合函数--统计
   -- sum() 求和,avg()平均值 count()计数,max()最大值  min()最小值
   select  count(*) as 记录总数,round(avg(sal),2) 平均工资,sum(sal) 工资总和,
     max(sal) 最大工资 ,min(sal) 最小工资 from emp where deptno=20;
   --分组统计
   --group by 列1[,列2]
    select deptno,  count(*) as 记录总数,round(avg(sal),2) 平均工资,sum(sal) 工资总和,
     max(sal) 最大工资 ,min(sal) 最小工资 from emp group by deptno
     --带where的group
    select deptno,  count(*) as 记录总数,round(avg(sal),2) 平均工资,sum(sal) 工资总和,
     max(sal) 最大工资 ,min(sal) 最小工资 from emp where job!='MANAGER' 
      group by deptno;
   -- 带having的group
   --where 和having区别？
   --先where过滤，然后，分组，最后having
    select deptno,  count(*) as 记录总数,round(avg(sal),2) 平均工资,sum(sal) 工资总和,
     max(sal) 最大工资 ,min(sal) 最小工资 from emp where job!='MANAGER' 
      group by deptno having avg(sal)>2000
--
--看看下面两条查询，having有时可以根where，对调   
--所以，第一条，性能更好点。
  select deptno,  count(*) as 记录总数,round(avg(sal),2) 平均工资,sum(sal) 工资总和,
     max(sal) 最大工资 ,min(sal) 最小工资 from emp where job!='MANAGER' and  deptno=20
      group by deptno 
      --
      select deptno,  count(*) as 记录总数,round(avg(sal),2) 平均工资,sum(sal) 工资总和,
     max(sal) 最大工资 ,min(sal) 最小工资 from emp where job!='MANAGER'   
      group by deptno having deptno=20
------------------------------------------
   --组合分组
   select deptno,job,  count(*) as 记录总数,round(avg(sal),2) 平均工资,sum(sal) 工资总和,
     max(sal) 最大工资 ,min(sal) 最小工资 from emp group by deptno,job;   
     --
     --带日期的条件，查出入职日期为1981年的员工
 select * from emp where hiredate between to_date('1981-01-01','yyyy-mm-dd')
    and to_date('1981-12-31','yyyy-mm-dd');
--to_char(date,'‘格式') 将日期转换成字符，to_number(字符) 转换成数字
  select * from emp where to_number( to_char( hiredate ,'yyyy'))=1981;
 ======================================================
 -- 模糊匹配 字符串查找，一般字符串查找都会用模糊匹配
 --查询出 岗位job中包含 sale    % 任意多个字符  _ 任意单个
 --  where name like '王%'   '%琴'   '%玉%'  
 --英文字符区分大小写的，
 --要不区分大小写？
 select * from emp where job like '%SALE%'
 --使用lower()转换成小写在比较
  select * from emp where  lower(job) like '%sale%'
 ========================================================
 -- 集合的操作
 -- 并集 union(自动删除重复行) , union all 不删除重复行
 --比如有两张销售表，2016,2015
 --这两个查询的列要满足：列的个数一样,列的类型要一致
 select empno,ename,deptno from emp where deptno=20
 union
 select empno,ename,deptno from emp where deptno=30
 -- 减集  (1,2,3,4) --(1,3)=(2,4)
 --查询出第5条到第10条的记录
 --rownum这个伪列返回的是1开始的序号，必须从一开始
 --这个比较重要，一般常用在分页查询中
 select  rownum, empno,ename,deptno from emp where rownum<=10
 minus
  select  rownum, empno,ename,deptno from emp where rownum<=5
 --交集 intersect 返回两个集合中相同的信息
 select * from emp where deptno=20 or deptno=30
 intersect
  select * from emp where deptno=10 or deptno=20
----------------------------------------------------------------------------------------
--表连接  A-B 之间是有关系的，主从关系  1:多 关系，主(唯一)外键 
 --
 -- 连接分成： 内连接，外链接，自连接
 select * from dept;
 select * from emp;
 查出 员工编号，姓名，岗位，部门编号，部门名称，部门所在地
 --内连接： A表，B表 都存在的数据会显示
 --不加条件的连接，笛卡尔积，M*N条,
 --where 加上连接条件，通常是外键
 --写法1
 select emp.empno,emp.ename,emp.job
 ,dept.deptno,dept.dname,dept.loc from emp ,dept where emp.deptno=dept.deptno
 --写法2
 select a.*,b.* from emp  a inner join dept  b
 on a.deptno=b.deptno;
select * from emp; 员工表
select * from  salgrade;工资等级表
要求: empno,ename,sal,grade,losal,hisal 
------------------------------------------------------------
 select empno,ename,sal,grade,losal,hisal from emp 
 inner join salgrade on sal between losal and hisal
=========================================
 select empno,ename,sal,grade,losal,hisal from emp ,salgrade
where sal between losal and hisal
====================================
--外链接：【左外，右外】
--左外，左表示主表，右表示从表，主表里每一条记录和从表里的记录匹配
--匹配到的会显示，匹配不到的用null填充
select a.* ,b.* from dept a 
left join emp b on a.deptno=b.deptno
--查询部门表，显示没有员工的部门信息。
--特别注意下：如果一个列为null，判断一个列是否是null 不能用 =null 应该用
--is null
select a.* from dept a 
left join emp b on a.deptno=b.deptno where empno is null
=================================================
--自连接 自己和自己连接，可以把一张表看成是多张表
--有个需求：查询出所有雇员和经理的名字。
--一张表中也存在着一对多的关系，如emp，empno 员工编号  mgr经理编号
--这个表中，存在着，一个经理领导多个雇员，一个雇员只有一个经理
select * from emp
要求：列出 empno,ename,job ,mgr,mgrname,mgrjob 
select a.empno,a.ename,a.job,b.empno mgr,b.ename mgrname,b.job mgrjob from
emp a,emp b where a.mgr=b.empno
------------------
要求： 列出哪个雇员没有下属，显示empno,ename,job

select a.empno,a.ename,a.job from emp a
left join emp b on a.empno=b.mgr where b.mgr is null
--验证
select * from emp where mgr=7369

-----------------------------------------------------------------------
--子查询  : 在查询中嵌套查询
-- 比较运算符 > ,>=,!=,= ,<,<= 这种运算符的右边是单个值
-- 复杂的情况，集合，右边是多个值
-- in  在什么里 where id in (3,5,6)
select * from emp where empno in (7369,7499,7844)
--  not in 不在范围里
select * from emp where empno not in (7369,7499,7844)
-- any all
-- any 任意一个值，某个值，相当于大于最小的一个
-- all 全部  >all 大于最大的一个值
--> any  sal >any(100,200,150,500)
-- 右边的列表，可以是某个查询动态产生的，这就是只查询
--查询哪个部门里没有员工
--子查询里返回的是单个列
select * from dept where deptno not in( 
   select distinct deptno from emp
)

--员工编号为7369的超过平均工资
select * from emp where sal>(
select avg(sal) from emp where deptno=(
select deptno from emp where empno=7369)
)
 and deptno=(
select deptno from emp where empno=7369
)
改员工所在部门的平均工资 7369
select avg(sal) from emp where deptno=(
select deptno from emp where empno=7369)
-------------------
--emp中查询出，工资超过所在部门平均工资的雇员
select a.* from emp a ,(
 select deptno,avg(sal) avgsal from emp group by deptno) b where a.deptno=b.deptno
  and a.sal>b.avgsal
--
select empno,ename,sal,deptno from emp e1 where sal>(
       select avg(sal) from emp e2 where e1.deptno=e2.deptno
)
--列出在部门“SALES”工作的员工姓名。
--子查询
select ename from emp where deptno in (
  select deptno from dept where Dname='SALES');
--表连接
select ename from emp inner join dept
on emp.deptno=dept.deptno where dept.dname ='SALES';
--列出所有部门的详细信息和部门人数。
-- dept      【  deptno    counts】
select a.*,t1.counts from dept a ,(
select deptno ,count(*) as counts from emp group by deptno
) t1 where a.deptno=t1.deptno


--列出，每个部门的部门编号，部门名称，员工总数，平均工资
  dept   [deptno  counts avgsal]
select a.*,t1.counts,t1.avgsal from dept a ,(
select deptno ,count(*) as counts,avg(sal) avgsal from emp group by deptno
) t1 where a.deptno=t1.deptno


--- 列出，每个部门的部门编号，部门名称，员工总数，平均工资，平均工作年限

select   to_number(   to_char(sysdate,'yyyy')) from dual;
select empno,ename, hiredate,
to_number(   to_char(sysdate,'yyyy'))-to_number(   to_char(hiredate,'yyyy')) years from emp;

select * from emp;
select * from dept
=========================================================
==分析函数
==求排名 rank 非密集排名,  dense_rank,row_number
--需求，对emp表的数据，根据员工工资来排名
--over()开窗函数配合用。 over里的排序表达式可以是多个
--非密集
select empno,ename,sal, rank()over(order by sal desc ) salrank  from emp;
--密集排名
select empno,ename,sal, dense_rank()over(order by sal desc ) salrank  from emp;
--row_number()产生一个唯一序号
select row_number()over(order by sal desc,empno asc ) rownumber , empno,ename,sal  from emp;
--分区排名 --按部门来排名
select empno,ename,sal,deptno,
 rank()over(partition by deptno order by sal desc  ) salrank  from emp;
-- 按照工资升序，显示第5到10条记录。 不能用rownum伪列
==================
--这是使用分析函数row_number()分页。
--说明：一个查询，可以套上括号，变成一张虚拟表。某些复杂情况下
select * from(
select row_number()over(order by sal  ) rownumber , empno,ename,sal  from emp 
) t1 where rownumber between 5 and 10
==================
-- exists 存在
--not exists不存在
--查询雇员薪水大于3000的部门名称
select * from dept d where exists(
      select empno,ename,sal,deptno from emp e where sal>3000 and d.deptno=e.deptno );
--等价的
select * from dept  where deptno in (
      select deptno from emp  where sal>3000 );
--表连接
select a.* from dept a ,emp b where a.deptno=b.deptno and b.sal>3000;

--其实，列里也可以有查询
--列里的查询，其实可以看出就是一个值罢了，返回单行单列
--显示empno,ename,sal,salminus 
--salminus 是自己的工资和平均工资的差额
select empno,ename,round((select avg(sal) from emp),0) avgsal,sal,
round(sal-(select avg(sal) from emp ),0)  as salminus from emp;












insert into dept values(50,'programmer','华盛顿')
  
  create table dept2 (
         dno int primary key,
         dname varchar2(50)
  )
  --批量插入
  insert into dept2 select deptno,dname from dept
  select * from dept2
  ----------------------------------
    commit;






