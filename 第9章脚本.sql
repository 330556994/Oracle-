--oracle的游标
-- 如果只是提取一行的话只需into 变量
--问题是，要对一组数据进行操作呢？
--打印部门为20的员工姓名和工资
--可以使用游标(变量，类型)，用来指向一个查询结果（多行），
--可以通过检索该游标，来获得当前行的信息，依次循环，直到处理完毕。
declare
   v_row emp%rowtype;
   --定义一个游标名字叫emp_cursor，指向一条select语句
   cursor emp_cursor is select * from emp where deptno=20;
begin
   open emp_cursor;--打开游标，游标指向与第一条记录的上一条。
   loop
     --游标提取下一行，同时指向下一行。并把当前游标行记录，保存到变量中
     fetch emp_cursor into v_row;
--     emp_cursor%notfound  不存在，%rowcount记录总数,%found存在  %isopen是否打开
     exit when emp_cursor%notfound; 
      --处理业务
      dbms_output.put_line(v_row.ename||'  '||v_row.sal);
    
   end loop;
   close emp_cursor;--关闭游标
end;
-----------------------
--游标中使用变量
declare
   v_row emp%rowtype;
   v_no emp.deptno%type;
   --定义一个游标名字叫emp_cursor，指向一条select语句
   cursor emp_cursor is select * from emp where deptno=v_no;
begin
  v_no:=20;
   open emp_cursor;--打开游标，游标指向与第一条记录的上一条。
   loop
     --游标提取下一行，同时指向下一行。并把当前游标行记录，保存到变量中
     fetch emp_cursor into v_row;
--     emp_cursor%notfound  不存在，%rowcount记录总数,%found存在  %isopen是否打开
     exit when emp_cursor%notfound; 
      --处理业务
      dbms_output.put_line(v_row.ename||'  '||v_row.sal);
    
   end loop;
   close emp_cursor;--关闭游标
end;
-----------------------------------------
-----------------------
--带参数的游标
declare
   v_row emp%rowtype;
   --定义一个游标名字叫emp_cursor，指向一条select语句
   --游标定义中含参数，在select中使用该参数
   cursor emp_cursor(v_no emp.deptno%type) is select * from emp where deptno=v_no;
begin
  --v_no:=20;
   open emp_cursor(20);--打开游标，游标指向与第一条记录的上一条。
   loop
     --游标提取下一行，同时指向下一行。并把当前游标行记录，保存到变量中
     fetch emp_cursor into v_row;
--     emp_cursor%notfound  不存在，%rowcount记录总数,%found存在  %isopen是否打开
     exit when emp_cursor%notfound; 
      --处理业务
      dbms_output.put_line(v_row.ename||'  '||v_row.sal);    
   end loop;
   close emp_cursor;--关闭游标
end;
-----------------------------------------------
--使用for in 简化游标读取
declare
   cursor emp_cursor(v_no emp.deptno%type) is select * from emp where deptno=v_no;
begin
  --无需open，无需fetch，无需close，无需定义变量来提取
   for emp_record in emp_cursor(20) loop
       dbms_output.put_line(emp_record.ename||' 工资'||emp_record.sal);
   end loop;
end;
---------------------------------------------------------------
--隐式游标
--无需定义的，当你执行DML语句 select,insert,update,delete
--自动创建隐式游标，我们可以使用游标属性来检索SQL语句执行的情况
--输入一个部门编号，删除该部门下员工信息,如果删除成功提示，成功的条数
--如果部门不存在，则提示。
declare
    v_no emp.deptno%type;
begin
  v_no:='&请输入要删除的部门名称';
  delete from emp where deptno=v_no;
  if sql%found=true then
     dbms_output.put_line('删除成功,共删除'||sql%rowcount);
  else
     dbms_output.put_line('删除失败，该部门不存在');
  end if;
end;
rollback;
select * from emp where deptno=10
--------------------------------------------------------------------------------------------
--ref 游标的用法
--静态游标，在定义时就指定了sql语句。
--现在，如果在执行时才能确定是哪个sql语句的话。
--ref游标 和游标变量，能够实现，定义时不指定，使用时指定sql
-- type ref_name is ref cursor [return retu_type]  定义一个ref游标类型 
declare
--定义一个ref corsor类型，无规定返回值，叫弱类型
   type ref_type_emp is ref cursor; 
   v_rec dept%rowtype;
   v_row emp%rowtype;--定义一个行变量用来接收游标提取
--定义一个ref corsor类型，规定返回值类型，叫强类型   
 --  type ref_type_emp is ref cursor return emp%rowtype;--    
    mycur ref_type_emp;--用刚刚创建的ref corsor类型去创建一个游标变量
begin
  open mycur for select * from emp;--打开这个游标变量，并绑定一条sql语句
 fetch mycur into v_row;--提取游标 
 while  mycur%found
  loop 
      dbms_output.put_line(v_row.ename||'   '||v_row.sal);
      fetch mycur into v_row;--提取游标 
  end loop;
  close mycur;
  --指向另一张表
  open mycur for select * from dept;
   fetch mycur into v_rec;--提取游标 
 while  mycur%found
  loop 
      dbms_output.put_line(v_rec.dname||'   '||v_rec.deptno);
      fetch mycur into v_rec;--提取游标 
  end loop;
  close mycur;
end;
-------------------------------------------------------------
--动态游标绑定变量案例
declare
--type sys_refcursor is ref cursor
  cur sys_refcursor;--这是系统已经定义好的弱类型ref cursoe
  rec emp%rowtype;
  v_deptno emp.deptno%type;
  v_sal emp.sal%type;
begin
  v_deptno:=20;
  v_sal:=2000;
  --执行动态sql并绑定变量。:1,:2只是占位符
  open cur for 'select * from emp where deptno=:1 and sal>:2' using v_deptno,v_sal;
  loop
    fetch cur into rec;
    exit when cur%notfound ;
    dbms_output.put_line(rec.ename||'   '||rec.sal);
  end loop;
  close cur;
  
end;
-------------------------------------------------------------------------
--执行动态sql
--动态sql，是不确定的。还有在块中，是不可以使用DDL语句
declare
   v_sql varchar2(50);
begin
  v_sql:='create table t1(id int,name varchar2(50))';
  execute immediate v_sql;--执行那个动态sql
 exception
    when others then 
      dbms_output.put_line('error: '||sqlcode||sqlerrm);
end;
select * from tab;
----------------------------------------------------------------------------------
--执行动态sql绑定变量
declare
       v_sql varchar2(50);
begin 
   v_sql:='delete from emp  where deptno=:1';
   execute immediate v_sql  using 20;--执行的时候绑定变量
end;
----------------------------------------------------------------
--执行动态sql，得到值，绑定变量
declare
       v_sql varchar2(50);
       v_count int;
begin 
   v_sql:='select count(*)  from emp  where deptno=:1';
   execute immediate v_sql into v_count  using 20;--执行的时候绑定变量
   dbms_output.put_line('记录总数为:'||v_count);
end;

--------------------------------
 tborder(id,totalprice,flag,userid)     
   create table tborder (
          id int primary key,
          totalprice  number(8,2) not null,
          flag int default 1,
          userid varchar2(50) not null
   )
   insert into tborder  values(1,50,1,'13312121212');
      insert into tborder  values(2,35,1,'13312121212');
               1      50  1    13312121212       flag 1:未处理   2：送货中 3已完成  4已合并
               2      35   1    13312121212
               
 tbOrderDetail(id,oid,productid,price,qty)
 create table tbOrderDetail(
        id int primary key,
        oid int ,
        productid varchar(50) not null,
        price number(8,2) not null,
        qty int not null
 )
--alter table tbOrderDetail  add constraint fk_oid foreign key (oid) reference tborder(id)
alter table tbOrderDetail   add constraint fk_oid foreign key (OID)
  references tborder (ID);
  
  
   insert into tbOrderDetail values(1,1,'a',10,1);
   insert into tbOrderDetail values(2,1,'b',20,2);
   insert into tbOrderDetail values(3,2,'a',10,2);
   insert into tbOrderDetail values(4,2,'c',5,3);
commit;

select * from tborder;
select * from tborderdetail;



     1  1   a   10  1 
     2  1  b    20  2
     3  2  a    10  2
     4  2  c     5   3
--要求 将  订单编号2合并到1里面
--结果
-----------------
--合并的前提是 同一个用户下的订单，并且订单状态为1
  1      85  1  13312121212
    2    35   4  13312121212

     1   1   a  10   3
     2  1   b   20  2
     3  2   a  10   2
     4   2  c    5  3
     5  1  c     5  3
     select * from tborder;
     select * from tborderdetail;
----------------------------------------------------------------
create sequence seq_orderdetail_id 
---------------
select * from tborderdetail
select seq_orderdetail_id.nextval from dual;
--
declare
  v_oid1 tborder.id%type;--源订单编号
  v_oid2  tborder.id%type; --合并到目标订单编号
  v_rec1 tborder%rowtype;--这是原订单记录变量
  v_rec2 tborder%rowtype;--合并到目标订单记录变量
  v_rec3 tborderdetail%rowtype;--这是源订单明细变量
  curOrder sys_refcursor;--定义游标变量 指向源订单明细
  v_count int ;--临时变量，用来检索记录数
  v_sql varchar2(500);--动态sql
begin
  v_oid1:=2;
  v_oid2:=1;
  --先检查是否可以合并，要求是同一个用户下的，并且状态为1
  select * into v_rec1 from tborder where id=v_oid1;--取出源订单订单
  select * into v_rec2 from tborder where id=v_oid2;--取出目标订单
 if v_rec1.userid!=v_rec2.userid then  --这是检查是否同一个用户的
   raise_application_error(-20111,'错误：无法合并，不是同一个用户得订单');
 end if;
 if v_rec1.flag=v_rec2.flag and v_rec2.flag=1 then
     --可以合并了
     --思路：取出源订单下的每一条明细，判断该明细在目标订单里是否存在，
     --如果存在，则目标订单该明细数量相加，不存在呢，则插入到目标订单
     open curOrder for 'select * from tborderdetail where oid=:1' using v_oid2;
    loop
          fetch curOrder into v_rec3;
          exit when curOrder%notfound ;
          --处理
          --判断该条记录在目标订单明细里是否存在
            select count(*) into v_count from tborderdetail where productid=v_rec3.productid
                and oid=v_oid1;
            if v_count>0 then 
              --存在，则做更新数量
             v_sql:= 'update tborderdetail set qty=qty+:1 where productid=:2 and oid=:3';
             --执行动态sql并绑定变量
              execute immediate v_sql using v_rec3.qty ,v_rec3.productid,v_rec3.oid;
            else
              --不存在，则做插入
                 insert into tbOrderDetail values(seq_orderdetail_id.nextval,v_oid2,
                 v_rec3.productid,v_rec3.price,v_rec3.qty);              
            end if;
  end loop;  
  close curOrder;
  --更新源订单的状态为4
  update tborder set flag=4 where id=v_oid1;
  --更新目标订单的总价
  update tborder set totalprice=(select sum(qty*price) from tborderdetail where oid=v_oid2)
   where id=v_oid2;
 else
   --不能合并
   raise_application_error(-20111,'错误：无法合并，订单状态不为1');
 end if;

exception 
  when others then
    dbms_output.put_line('错误'||sqlcode||sqlerrm);  
  
  
end ;
--
  update tborder set totalprice=(select sum(qty*price) from tborderdetail where oid=2)
   where id=2
求订单编号2的总价
update tborder set flag=1
commit;
-----
  判断订单编号2 是否购买产品a
  select count(*) into v_count from tborderdetail where productid='a' and oid=2
 更新订单编号2 ，购买的产品a，数量累加3
 update tborderdetail set qty=qty+3 where productid='a' and oid=2
select * from  tborderdetail where productid='a' and oid=2
rollback;

--------------------------
--第二道回家作业
-- 使用动态sql 创建表     t2( id,a,b,c,area ) 
  --  循环 10000 次，往表里插入1万条数据id要求自增长,a,b,c为100-500之间随机整数
--如果存在t2,则删除
-------------------------
--b部分，对10000条记录，进行求解，abc起始就是三角形的三个边，如果构成三角形，则求面积
--不构成，则删除该记录


select * from emp where deptno=20
rollback
=====================================================================
事务，事务是非常重要的sql概念。好好掌握
转账操作：
   bankaccount
   
      id         userid     money   flag(类型)   optdate
      1         张三      1000       存入         2012-1-1
      2        张三       -200        支取        2012-1-4
      3        李四       5000       存入        2012-1-5
      4        张三       -500        转出        2012-1-9
      5       李四       500         转入         2012-1-9
     create table bankaccount(
            id int primary key,
            userid varchar2(50) not null,
            money number(8,2) not null,
            flag   char(8) not null,--存入，支取，转入，转出 
            optdate date default sysdate 
     )

     create sequence bankaccount_id start with 1;--为该id创建一个序列
     insert into bankaccount values(bankaccount_id.nextval,
     '张三',1000,'存入',to_date('2012-1-1','yyyy-mm-dd'));
     insert into bankaccount values(bankaccount_id.nextval,
     '张三',-200,'支取',to_date('2012-1-4','yyyy-mm-dd'));
          insert into bankaccount values(bankaccount_id.nextval,
     '李四',5000,'存入',to_date('2012-1-5','yyyy-mm-dd'));
     
   select * from bankaccount
   commit;
      --就如转账操作，一个账号扣500，转到另一个账号
      多条sql语句，这些sql语句，其实是一个整体，不能分割，具备，要么一起成功
      要么一起失败，决不允许一条成功，一条失败。
      这就需要事务处理。
      事务的特点：原子性（是一个整体，不能分割），
         一致性：要么是改变前的状态，要么是改变后的状态，
         隔离性：事务之间互不影响
         持久性：要么成功，永久改变，要么回滚，当啥都没发生。
    --
    --oracle中事务机制
    --启动事务
    --1自上一次提交后自动开启
    --2. insert,update,delete语句会自动启动事务
   --结束事务：
   -- commit/rollback
   --原理的角度：事务中，数据会放到回滚段中。提交时，从回滚段中数据永久提交到数据里
    select * from bankaccount
    --转账操作
    declare
       v_name1 bankaccount.userid%type; --转出账号
       v_name2 bankaccount.userid%type; --转入账号
       v_money bankaccount.money%type;--待转金额    
     --  v_bank bankaccount%rowtype;--定义一个记录类型
     v_count int; --临时变量，用来处理账号是否存在
     v_sum bankaccount.money%type;--临时变量，用来保存，转出账号余额。
    begin
      v_name1:='&请输入转出账号';
      v_name2:='&请输入转入账号';
      v_money:='&请输入转出金额';

      --下面是必要的验证
      --先验证账号有效性，再验证金额是否够  只要留1元
      select count(*)  into v_count from bankaccount where userid=v_name1;
       if v_count<1 then 
          raise_application_error(-20111,'转出账号无效') ;
       end if;
       select count(*)  into v_count from bankaccount where userid=v_name2;
       if v_count<1 then 
          raise_application_error(-20111,'转入账号无效') ;
       end if;
       --再验证账户余额是否足够
       --获得转出账号余额
     
      --开始转账操作
       --先转出
       insert into bankaccount values(bankaccount_id.nextval,
     v_name1,-v_money,'转出',sysdate);
--       在转入
     insert into bankaccount values(bankaccount_id.nextval,
     v_name2,v_money,'转入',sysdate);
     
       select sum(money) into v_sum from bankaccount where userid=v_name1;
       
       if v_sum+1<=v_money then
         --余额不足
         rollback; --回滚事务
         dbms_output.put_line('转账失败');
        else
               commit;--提交事务          
                      dbms_output.put_line(v_name1||'成功转入'||v_name2||v_money||'元');
       end if;    
     
       
     exception
        when others then 
          case sqlcode
            when -20111 then
             dbms_output.put_line('错误!账户有误');   
           when -20112 then
             dbms_output.put_line('错误!转出账号余额不足');   
            else 
                        dbms_output.put_line('执行sql时错误!'||sqlcode||sqlerrm);   
                        rollback ;--回滚事务
                        
           end case;
                      
    end;     
         
    select * from bankaccount;
    
rollback;
      
  ---------------------------------------------------------
  很多需要启用事务的案例，如 创建订单
  （订单主表 一条，明细多条）
  select * from  tborder ;
  select * from tborderdetail;
  begin
     insert into tborder values(4,100,1,'13312454545');
     insert into tbOrderDetail values(seq_orderdetail_id.nextval,4,'a',20,1);             
     insert into tbOrderDetail values(seq_orderdetail_id.nextval,4,'b',10,2);  
     insert into tbOrderDetail values(seq_orderdetail_id.nextval,9,'b',10,2);  
     commit;
         dbms_output.put_line('订单插入成功');
  exception 
    when others then
         dbms_output.put_line('订单插入失败'||sqlcode||sqlerrm);
         rollback;   
  end;
  delete from tbOrderDetail where oid=9
  -----------------------------------------------------------------------
  --锁机制
  -- 因为多个用户同时共享一个资源，就会产生竞争。
  --死锁的问题，A,B两个事务，当A要运行下去，必须获得B锁定的资源，而B要
  --运行下去必须要获得A锁定的资源
  --事务执行期间，会锁定资源，不会释放
  -----------------------------------------------------------
   update emp set sal=sal+100 where empno=7499;
      update emp set sal=sal+100 where empno=7369;
   
   select * from emp;
      rollback;
     -------------------------------------------------------------------------------
     --锁分成 行级锁  和表级锁  
     行级锁：
     --加了行级共享，其他进程只能查询，不能更新或删除
     select * from emp where deptno=20 for update --查询数据，并加行级共享锁
     --释放锁定资源，commit  rollback
     select * from emp where deptno=20 for update nowait; --nowait就是不等待
     rollback;
     -----------------
     表级锁
     lock table emp in share mode;--对emp表发出锁定整张表，share
      lock table emp in exclusive  mode;--对emp表发出独占锁定整张表，share
     select * from emp where empno=7369--20 for update
     rollback;
 -------------------------------------------------------------------------------------------
 --售票系统， 
 --如何防止一张票卖给多个人？
 --    
     
     
     
     
     
     
     
     
     
     
     
      
      
















-------------------------------------------

 --select * from emp where deptno=20;

