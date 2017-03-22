--数据库对象
--table ，constraint
--有时经常需要用到一种列，叫自动增长。某个表的id
-- 1.序列发生器   sequence
--创建了一个序列，名字叫seq
create sequence seq
start with 1000
increment by 1;
--
select seq.nextval from dual
select seq.currval from dual
--
select * from tbemp
--序列用在insert中
  insert into tbemp(id,name,birthday,phone,sex,salary)
  values(seq.nextval,'玉帝',to_date('1955-10-5','yyyy-mm-dd'),'13812340999',0,8600 );
----------------------------------------------  

--------------------------------------------------------------------------------------------------------
--PL/SQL 编程
--过程语言/sql  
-- PL/SQL块 
[ declare] --变量定义
 
 begin --代码段
   
 [exception] --异常捕获
 end;
 --------
--一个块
 declare
   --这里是定义快中局部变量
   v_id int;--定义一个变量名字是v_id 整形
   v_name varchar2(50);
   v_age number:=100 ;--定义变量的时候赋初值  赋值用:=
   v_sal number;
   v_empno int :=7369;
 begin    
   v_age:=20;--给变量赋值 
  --还可以使用sql语句的方式赋值,注意，这里的where条件中，用到了变量
  select ename,sal into v_name,v_sal from emp where empno=v_empno;
  dbms_output.put_line('姓名'||v_name||'工资'||to_char(v_sal));--dbms_output 这是系统提供的一个包
  --什么是包，包像一个类，类中包含的是静态方法
  -- emp表中
 end; 
 --定义三个变量，年月日，得到当前的年月日
 --打印 2017年1月13号
 declare
      v_year int;
      v_month int;
      v_date int;
 begin
    v_year:= to_number( to_char( sysdate,'yyyy'));
    --获得月份
     v_month:=extract(month from sysdate);--获得月份
    -- select extract(month from sysdate)   into v_month  from dual ;
     v_date:= extract(day from sysdate);--获得日期
   dbms_output.put_line(to_char(v_year)||'年'||to_char(v_month)||'月'||to_char(v_date));
 end;
 --控制语句
 --条件语句
 --判断今年是不是闰年
 declare
     v_year int;
 begin
   v_year:=extract(year from sysdate);--得到年份
   v_year:='&请输入一个年份';--接受用户输入
   if (mod(v_year,4)=0 and  mod(v_year,100)!=0) or mod(v_year,400)=0 then
     dbms_output.put_line(to_char(v_year)||'是闰年');
   else
     dbms_output.put_line(to_char(v_year)||'不是闰年'); 
   end if;
 end; 
 --输入成绩
 --如果成绩>90分，输出 优秀
 -->80  良好
 -->60  合格
 --<60 不合格
 --其他，输入有误
 declare 
       v_score int;--成绩
       v_msg varchar2(100);
 begin 
     v_score:='&请输入成绩';
     if v_score>=90 then
        v_msg:='优秀';
     elsif v_score>=80 then 
           v_msg:='良好' ;
      elsif v_score>=60 then 
           v_msg:='合格' ;
      elsif v_score>=0 then
           v_msg:='不合格';
       else 
         v_msg:='输入不合法';
      end if;
      dbms_output.put_line(v_msg);
 end;
--case语句
 declare 
       v_score int;--成绩
       v_msg varchar2(100);
       v_flag char :='b';
 begin 
     v_score:='&请输入成绩';
     --case语句第一种格式
     case v_flag
          when 'a' then
            dbms_output.put_line('成绩大于90');
          when 'b' then
            dbms_output.put_line('成绩大于80');     
        when 'c' then
            dbms_output.put_line('成绩大于60');     
             when 'd' then
            dbms_output.put_line('不及格');     
      else
            dbms_output.put_line('格式错误');     
     end case;
     --case 语句
     case 
       when v_score>=90 then
         dbms_output.put_line('优秀');
        when v_score>=80 then
         dbms_output.put_line('良好');   
      when v_score>=60 then
         dbms_output.put_line('合格');  
       else        
           dbms_output.put_line('不合格');  
       end case;
       -- case表达式
       v_msg:=case 
       when v_score>=90 then '优秀'
        when v_score>=80 then '良好'
      when v_score>=60 then '合格'
       else        '不合格' 
       end;
       dbms_output.put_line(v_msg);
 end;
 --sql 语句中用case   部门是20 市场部  10技术部 30  工程部
 select empno,ename,deptno,
     case deptno when 10 then '技术部'
          when 20  then '市场部'
           when 30 then '工程部'
             else '未知' end as dname 
       from emp;
--
--练习下
输入三角形的三个边长 a,b,c
如果构成三角形，则求出面积，否则打印不构成三角形
s=(a+b+c)/2
面积 =开根号 s*(s-a)*(s-b)*(s-c)
declare
   v_a real;
   v_b real;
   v_c real;
   v_s number(8,2);
   v_area number(8,2);
begin
   v_a:='&请输入边长a';
   v_b:='&请输入边长b';
   v_c:='&请输入边长c';
   v_s:=(v_a+v_b+v_c)/2;
   if v_a+v_b>v_c and v_a+v_c>v_b and v_b+v_c>v_a then
      v_area:=sqrt(v_s*(v_s-v_a)*(v_s-v_b)*(v_s-v_c));
      dbms_output.put_line('面积为'||v_area);
   else
     dbms_output.put_line('无法构成三角形');
   end if;
end;




-------------------------------------------------------------------------------------------------------
--循环结构，三种循环语句 
--
------------------------------------------
 declare
   v_i int:=0;
   v_sum int:=0;
 begin
   loop
      v_i:=v_i+1;
     v_sum:=v_sum+v_i;    
     exit when v_i=100;--退出条件
   end loop;
   v_i:=0;
   v_sum:=0;
   --第二种循环 while
   while v_i<=100
     loop
        v_sum:=v_sum+v_i;  
            v_i:=v_i+1;  
     end loop;
    --第三种结构 for
   v_sum:=0;
   for v_i in 1..100
     loop
        v_sum:=v_sum+v_i;  
     end loop;     
   dbms_output.put_line('1-100的累加值为'||v_sum);
 end;
 =====================================================
 --   *
 --   **
 --   ***
 declare 
      v_i int;
      v_j int;
 begin
    for v_i  in 1..9
      loop
        for v_j in 1..v_i
            loop
              dbms_output.put('*');
            end loop;
            dbms_output.put_line('');
      end loop;
 end;
 --求出所有水仙花数
 ------------------------------------------------------------------------------------------------
--属性类型 
--如果要取出某个表里的列，需要先查该列的类型，然后定义。
--会有个问题，如果数据表后来修改了呢，这样程序可能会出问题。
-- %type   定义一个变量，数据类型是已定义的某个表的列类型
--%rowtype 定义一个记录，用来描述一组信息。
--输入员工编号，显示员工姓名
declare
  v_no emp.empno%type;--定义一个变量v_no，类型是emp.empno列的类型
  v_row emp%rowtype; --定义一个变量v_row，这是一个记录类型，有点像类
  --这个类型表示emp表的一行。
begin
   v_no:='&请输入员工编号';
   select * into v_row from emp ;-- where empno=v_no;
   dbms_output.put_line(v_row.ename||'  '||v_row.empno||'  '||v_row.job);
exception 
     when no_data_found then  --这是某个特定异常
       dbms_output.put_line('您输入的编号不存在数据');
   when others then --抓异常老大,相当于java中excepion 这个要放在最后
      dbms_output.put_line( '异常编号为:'|| sqlcode ||' 异常描述为'||sqlerrm );
end;
--自定义异常
-- 演示，输入三角形三边，如果不构成三角形，则用自定义处理
--存在则，打印周长
declare
  a int;
  b int;
  c int;
  trangleException exception; --定义一个自定义异常
begin
  a:='&输入a边长';
  b:='&输入b边长';
  c:='&输入c边长';
  if a+b>c and  b+c>a  and a+c>b then
     --打印周长
     dbms_output.put_line('周长为'||(a+b+c));
  else
    --抛异常
    raise trangleException;--抛出自定义异常
  end if;
exception
  when   trangleException then
    dbms_output.put_line('您输入的三边不构成三角形，错误');
  when others then --抓异常老大,相当于java中excepion 这个要放在最后
      dbms_output.put_line( '异常编号为:'|| sqlcode ||' 异常描述为'||sqlerrm );
 end; 
--抛系统异常，非常类似 throw new Exception("abc")
declare
  a int;
  b int;
  c int;
begin
  a:='&输入a边长';
  b:='&输入b边长';
  c:='&输入c边长';
  if a+b>c and  b+c>a  and a+c>b then
     --打印周长
     dbms_output.put_line('周长为'||(a+b+c));
  else
     --抛出一个异常
     raise_application_error(-20100,'错误:三边不构成三角形');
  end if;
exception
  when others then --抓异常老大,相当于java中excepion 这个要放在最后
      dbms_output.put_line( '异常编号为:'|| sqlcode ||' 异常描述为'||sqlerrm );
 end; 
-----------------------------------------------------------------------------------
select * from tab;--tab当前模式里的表
select * from user_tables--返回当前模式下的表
select * from all_objects where owner='BOOKSHOP';

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 select * from emp
 
 
 
 







  
  
  

