-- Create table
/*
create table tbEmp
(
  id       int not null,
  name     nvarchar2(50) not null,
  phone    char(11),
  birthday date,
  sex      int,
  salary   number(8,2)
)*/
;
-- Add comments to the columns 
/*
comment on column tbEmp.id
  is '员工编号';
comment on column tbEmp.name
  is '姓名';
comment on column tbEmp.phone
  is '手机号码';
comment on column tbEmp.birthday
  is '出生年月';
comment on column tbEmp.sex
  is '性别0：男 1女';
comment on column tbEmp.salary
  is '工资';
  */
  --这是注释，下面是做插入
  --所有非数字都是单引号,数字不加引号
  --对象"" 双引号
--注意，给的值和列要对应
--语法 insert into 表名(列表)values(值表)
  insert into tbemp(id,name,phone,sex,salary)
  values(1,'张三','13812345678',1,4500 );
  --日期处理
  --to_date('1998-10-5','yyyy-mm-dd') 内部函数，功能是将一个字符串转换
  --成日期
  insert into tbemp(id,name,birthday,phone,sex,salary)
  values(1,'张三',to_date('1998-10-5','yyyy-mm-dd'),'13812345678',1,4500 );
  --
    insert into tbemp(id,name,birthday,phone,sex,salary)
  values(2,'李四',to_date('1968-10-5','yyyy-mm-dd'),'13812349999',0,3600 );
   --
   insert into tbemp(id,name,birthday,phone,sex,salary)
  values(3,'王五',to_date('1980-9-5','yyyy-mm-dd'),'13312348765',0,8300 );  
  --
  insert into tbemp(id,name,birthday,phone,sex,salary)
  values(4,'小红',to_date('1986-3-5','yyyy-mm-dd'),'13012348765',0,2900 );  
--
  insert into tbemp(id,name,birthday,phone,sex,salary)
  values(5,'小明',to_date('1988-3-5','yyyy-mm-dd'),'13112348765',0,3300 );  
  
  
  commit;--提交修改
  --最简单的查看
  select * from tbemp;
  --删除
  select rowid,id,name from tbemp;

  delete from tbemp where rowid='AAASPPAAEAAAAJ0AAB'
    select * from tbemp;