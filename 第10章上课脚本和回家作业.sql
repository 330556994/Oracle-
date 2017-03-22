--第10章
--子程序和触发器
--子程序：是保存名字的PL/SQL块
-- 储存过程：是一个过程，相等于一个方法。
--好处：反复调用，结构化编程，将一些复杂的业务进行封装，经过预编译的
--执行速度非常快。极大的提高性能，在数据库开发中普遍使用。
--这是定义语法
--参数分成：
--输入参数：将值传给储存过程的 input
--输出参数：将值从储存过程内部传给外部，如果希望一个储存过程返回多个值
--那么可以定义多个输出参数 out  
--说明：参数列表中的参数，不能声明长度,只能申明类型
create or replace procedure  proc_getTriangleArea
(
--功能：根据三角形的三边，求面积
   --这里是参数列表
   v_a int  ,--输入参数表示边长a
   v_b int,--省略模式是输入参数 边长b
   v_c int,--边长C
   v_area out number,--表示输出参数，求出的面积
   v_errcode out int --表示错误情况 0 成功  -1不构成三角形  -2参数错误
   )
as
--这里是定义变量
  v_s number(8,2);
begin
  v_s:=(v_a+v_b+v_c)/2 ;--临时变量，表示 s
 --这里是执行代码
--先判断参数是否符合要求
  if v_a<=0 or v_b <=0 or v_c<=0 then
    v_errcode:=-2;--参数错误
    return ;--结束了
  end if; 
  --判断是否构成三角形
  if v_a+v_b>v_c and v_a+v_c>v_b and v_c+v_b>v_a then
    --构成求面积
    v_area:= sqrt( v_s*(v_s-v_a)*(v_s-v_b)*(v_s-v_c));
    v_errcode:=0;
    return ;
  else
     v_errcode:=-1;--不构成三角形
   return ;--结束了
  end if;  
 --异常处理，可选
end proc_getTriangleArea;
--下面调用下上面定义的这个储存过程
declare
   area number(8,2);
   errcode int ;
begin
  --调用存储过程，按照参数定义顺序赋值
   proc_getTriangleArea(3,4,5, area , errcode );
   if errcode=0 then
        dbms_output.put_line('面积为'||area);
   end if;
      if errcode=-1 then
        dbms_output.put_line('不构成三角形');
   end if;
         if errcode=-2 then
        dbms_output.put_line('参数错误');
   end if;
end;
-------------------------
select sal+nvl( comm,0) as salary   from emp where empno=7369;
----
create or replace procedure
--根据传入的员工编号，获得该员工的工资
--注意，本过程不处理异常
 proc_getEmpSalary(
 v_empno emp.empno%type,--要查的员工编号
 v_salary out number--工资，底薪+提成
 )
 is
 begin
    select sal+nvl( comm,0) into v_salary   from emp 
    where empno=v_empno;
end proc_getEmpSalary;
--下面调用下该存储过程
declare
    v_empno emp.empno%type;
    v_salary number(8,2);
begin
  v_empno:='&请输入员工编号';
  --这个存储过程中没有处理异常，因为执行了sql查询，
  --那就由调用者处理异常，一般储存过程作者无需再内部处理异常
  proc_getEmpSalary(v_empno,v_salary);
  dbms_output.put_line(''||v_empno||' 的工资是'||v_salary);
  exception 
    when others then 
      dbms_output.put_line(sqlcode||sqlerrm);
end;
-------------------------------------------------------------------------
回家作业：
 下面都是写储存过程
 1.  proc_isLeapYear( year) 储存过程，输入年份，判断是否是闰年
  输出参数是布尔值
  
 2. proc_getValue(a,b,c ,x1,x2)  储存过程，输入a,b,c三个系数，求出该
 一元二次方程的解，x1,x2是输出参数，表示解。
 3. proc_isRouseNumber(num,ret) 判断输入的数是否是玫瑰花数，输出参数是结果
 布尔值
 4. proc_getMoney(int cardid,string opt ,out val number)
 这个储存过程的功能是，输入卡号，和操纵类型，得到该卡的值
 opt 的值为  '存入'，支出，转入，转出
 5. proc_insert_score
  这个储存过程的功能是，循环变量银行流水表，如果是存入，则插入积分
  积分是10元等1积分
 先创建表 bankscore
                      id int primary key 自增长，
                      bankaccountid int --流水编号，外键对于与流水表的主键
                      money number(8,2)
                     
                      score  int --积分
这张表是空的                      
 select * from bankaccountinfor
 
 
 
 
 
 
 












