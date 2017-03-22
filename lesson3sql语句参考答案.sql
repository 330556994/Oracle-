这是第一部分：
Oracle_SQL scott模式下的表

1.选择部门30中的所有员工.

2.列出所有办事员(CLERK)的姓名，编号和部门编号.

3.找出佣金高于薪金的员工.

4.找出佣金高于薪金的60%的员工.

5.找出部门10中所有经理(MANAGER)和部门20中所有办事员(CLERK)的详细资料.

6.找出部门10中所有经理(MANAGER),部门20中所有办事员(CLERK),既不是经理又不是办事员但其薪金大于或等于2000的所有员工的详细资料.

7.找出收取佣金的员工的不同工作.

8.找出不收取佣金或收取的佣金低于100的员工.

9.找出各月倒数第3天受雇的所有员工.

10.找出早于12年前受雇的员工.

11.以首字母大写的方式显示所有员工的姓名.

12.显示正好为5个字符的员工的姓名.

13.显示不带有"R"的员工的姓名.

14.显示所有员工姓名的前三个字符.

15.显示所有员工的姓名,用a替换所有"A"

16.显示满10年服务年限的员工的姓名和受雇日期.

17.显示员工的详细资料,按姓名排序.

18.显示员工的姓名和受雇日期,根据其服务年限,将最老的员工排在最前面.

19.显示所有员工的姓名、工作和薪金,按工作的降序排序,若工作相同则按薪金排序.

20.显示所有员工的姓名、加入公司的年份和月份,按受雇日期所在月排序,若月份相同则将最早年份的员工排在最前面.

21.显示在一个月为30天的情况所有员工的日薪金,忽略余数.

22.找出在(任何年份的)2月受聘的所有员工。

23.对于每个员工,显示其加入公司的天数.

24.显示姓名字段的任何位置包含"A"的所有员工的姓名.

25.以年月日的方式显示所有员工的服务年限.
=========================================
下面是第二部分

create table student (
   sno char(3) primary key,--学号
   sname varchar2(50) not null,--姓名
   sex char(2),--男或女
   age int,--年龄
   classNum char(5) --班级编号
);
insert into student values('108','曾华','男',19,'95033');
insert into student values('105','匡明','男',20,'95031');
insert into student values('107','王丽','女',20,'95033');
insert into student values('101','李军','男',19,'95033');
insert into student values('109','王芳','女',22,'95031');
insert into student values('103','陆君','男',20,'95031');
/*2:建立教师表*/
create table teacher(
   tno char(3) primary key,--教师号
    tname char(4),--姓名
   sex char(2),
   age int ,
   grade varchar2(20),--级别
   marjor  varchar2(20) --专业
);
insert into teacher values('804','李成','男',42,'副教授','计算机系');
insert into teacher values('856','张旭','男',35,'讲师','电子工程');
insert into teacher values('825','王萍','女',28,'助教','计算机系');
insert into teacher values('831','刘冰','女',25,'助教','电子工程');
/*3:建立课程表*/
create table course (
   lid char(5) primary key,
   lname varchar2(50), --课程名称 
   tno char(3)--外键 foreign key(教师号) references teacher(教师号)
);
alter table course 
add constraints fk_course_tno foreign key (tno) references teacher(tno);

insert into course values('3-105','计算机导论','825');
insert into course values('3-245','操作系统','804');
insert into course values('6-166','数字电路','856');
insert into course values('9-888','高等数学','831');
/*4:建立选课表*/
create table sc(
   id  int primary key, --序号，自增长主键列
   sno char(3),--学号
   lid char(5),--课程号
   score int --成绩
);
alter table sc 
add constraints fk_sc_sno foreign key (sno) references student(sno);
alter table sc 
add constraints fk_lid_sno foreign key (lid) references course(lid);
--创建id的序列
create sequence sc_id;
insert into sc values(sc_id.nextval,'103','3-245',86);
insert into sc values(sc_id.nextval,'105','3-245',75);
insert into sc values(sc_id.nextval,'109','3-245',68);
insert into sc values(sc_id.nextval,'103','3-105',92);
insert into sc values(sc_id.nextval,'105','3-105',88);
insert into sc values(sc_id.nextval,'109','3-105',76);
insert into sc values(sc_id.nextval,'101','3-105',64);
insert into sc values(sc_id.nextval,'107','3-105',91);
insert into sc values(sc_id.nextval,'108','3-105',78);
insert into sc values(sc_id.nextval,'101','6-166',85);
insert into sc values(sc_id.nextval,'107','6-166',79);
insert into sc values(sc_id.nextval,'108','6-166',81);
commit;
作业题:
1.查询选修课程'3-105'且成绩在60到80之间的所有记录。
注释:用于指定某个范围使用between and,也可以使用and连接符;
select * from sc where lid='3-105' and score between 60 and 80;

2.查询成绩为85、86或88的记录。
注释:用于制定某个集合使用 in 关键字,也可以使用 or 连接符;
select * from sc where score in (85,86,88);

3.查询'95031'班的学生人数。
注释:count(*)用于计算结果总数;
   select count(*) as studentcount from student where classnum='95031';
   
4.查询最低分大于70,且最高分小于90的学号列。
注释:having后面跟聚合函数:avg,min,max,count;having语句只能跟在:group by语句
select sno ,min(score),max(score) from sc group by sno having min(score)>70 and 
max(score)<90;

5.查询至少有5名学生选修并以3开头的课程的平均成绩。
注释:group by 语句置于where语句后面表示根据什么条件来分组;
select lid,count(*) studentcount,avg(score) scoreAvg
 from sc where lid like '3%' group by lid having count(*)>=5
6.查询平均分大于80分的学生的成绩表
注释:having后面跟聚合函数avg();
select sno,avg(score) avg from sc group by sno having avg(score)>80;
7.查询'95033'班每个学生所选课程的平均分。
  select sno from student where classnum='95033';
   select sno,avg(score) avg from sc where
    sno in (  select sno from student where classnum='95033')
   group by sno ;
注释:此题是根据 '95033'班学生的学号进行的分组,使用where语句限制group by语句的分组条件;

8.以选修 '3-105'为例,查询成绩高于'109'号同学的所有同学的记录。
注释:此题使用典型的嵌套查询,层层深入;
select * from student where sno in (
 select sno from sc where lid='3-105' 
 and score>( select score from sc where sno='109' and lid='3-105')
 );
 
9.查询与学号为'108'的同学同岁的所有学生的学号、姓名和年龄。
注释:当查询的结果集返回只有一个时关键字in的作用等价于'='的作用,
但是注意'='只
  select * from student where age=(select age from student where sno='108')

10.查询'张旭'教师任课的课程号，选修其课程学生的学号和成绩。
注释:此题使用了表的连接:inner join
,将多个表连接在一起组成一个新的表,标的连接的条件是必须存在相同的列;
   select tno from teacher where tname='张旭'  ;
   --表连接
   select sc.lid, sc.sno,sc.score from course 
      inner join teacher
      on teacher.tno=course.tno 
     inner join sc 
     on course.lid=sc.lid 
      where teacher.tname='张旭'
     ; 
     --子查询
   select sno,score from sc where lid in (
   select lid from course where tno =( select tno from teacher where tname='张旭' )
   );


11.查询选修其课程的学生人数多于5人的教师姓名。
:此题采用嵌套查询和连接表两种方法,表现出了同样的效果;
   select tno,tname from teacher where tno in (
   select tno from course where lid in (
     select lid from sc group by lid having count(*) >5
     )
     );
   --
   select  teacher.tno,teacher.tname from sc
      inner join course 
      on sc.lid=course.lid
      inner join teacher
      on teacher.tno=course.tno
      group by sc.lid,teacher.tno,teacher.tname having count(sc.lid)>5 ;
      
        



12.查询'计算机系'与'电子工程'不同职称的教师的姓名和职称。
注释:不同职称意味着分组后的返回结果集只有一个;
  select tname,grade from teacher where marjor in ('计算机系','电子工程') 
  group by grade ,tname;
  
13.查询选修编号为'3-105'课程且成绩至少高于选修编号为'3-245'课程的同学的
课程号、学号 、成绩并按成绩从高到低次序排列。
  select lid,sno,score from sc where lid='3-105' 
  and score  >any (   select score from sc where lid='3-245')
  order by score desc;
注释:any 表示任意一个;

14.查询选修编号为'3-105'课程且成绩高于选修编号为'3-245'课程的同学的课程号、学号 、成绩。
注释:all 表示所有;
  select lid,sno,score from sc where lid='3-105' 
  and score  >all (   select score from sc where lid='3-245')
  order by score desc;


15.列出所有教师和同学的姓名 、性别 、年龄。
注释:此题将所有表连接在一起:
--使用外链接     
     select teacher.tname,teacher.sex,teacher.age,
  student.sname,student.sex,student.age from teacher 
        left join course 
     on teacher.tno=course.tno
     left join sc 
     on sc.lid=course.lid
     left join student
     on sc.sno=student.sno
     
     
     
     
     
  --------------------------------------------------------------------------------
  
     

16.查询成绩比'3-105'课程的平均成绩低的学生的成绩表。
答案:
  select * from sc where score<(
    select avg(score) from sc where lid='3-105')

17.查询成绩比该课程平均成绩低的学生的成绩表。
注释:此题是所有题中最难的,下面的方法很经典,请认真琢磨,
先按照课程进行分组,查出小于各门课程平均成绩的所有成绩;
select sc.sno,sc.lid,sc.score from sc
inner join (
select lid, avg(score) avgscore from sc group by lid
) b
on sc.lid=b.lid 
where sc.score<b.avgscore
order by sc.score desc


18.列出所有任课教师的姓名和所授课。
注释:姓名和专业涉及两个表course表和teacher表,只需连接这两个表就能解决此题了;
答案:
select tname,lname from teacher,course where teacher.tno=course.tno


19.列出所有未讲课教师的姓名和专业。
 select * from teacher where tno not in (
  select tno from course  where lid in (
   select distinct lid  from sc 
   )
   ) 
   ========
   select teacher.* from teacher 
   inner join course
   on teacher.tno=course.tno
  left join sc 
  on sc.lid=course.lid 
  where  sc.lid is null    
  
  
  
20.列出至少有2名男生的班号。
注释:根据性别='男'这个条件来对student表进行分组就可以了;
答案:
  select classnum ,count(*)  from student 
   where sex='男'
   group by classnum having count(*) >=2

21.查询不姓'王'的学生记录。
  select * from student where sname not like '王%'

22.查询每门课最高分的学生的学号、课程号、成绩。
注释:此题的技巧在于根据最高分来查成绩表;
select sno,t1.lid,sc.score from sc inner join (
select lid,max(score) max from sc group by lid
) t1  on sc.lid=t1.lid  where sc.score=t1.max;

23.查询与'李军'同性别并同班的同学名字。
注释:嵌套查询;
select * from student where classnum=(
    select classnum from student where sname='李军')
  and sex=( select sex from student where sname='李军')  
  and sname!='李军'
    

24.查询'男'教师及其所上的课程。
注释:先分析此题涉及的表;
select teacher.tno,teacher.tname,teacher.sex,t1.lid,t1.lname from teacher 
inner join 
(
select tno,lid,lname  from course where lid in (
select distinct lid  from sc
)) t1 on teacher.tno=t1.tno where sex='男'

25.查询选修'计算机导论'课程的'男'同学的成绩表。
注释:此题用嵌套查询和表连接两种方法进行解答;
select * from sc where sno in (
select sno from student where sex='男' and sno in (
  select sno from sc where lid =(  select lid from course where lname='计算机导论')
  )
  )  and sc. lid =(  select lid from course where lname='计算机导论');
--表连接写法
   select sc.* from student 
    inner join sc 
    on student.sno=sc.sno
    inner join course
    on sc.lid=course.lid
    where course.lname='计算机导论' and student.sex='男'
26. select * from sc
 select * from course
选修数字电路这门课的学生，还选了哪些课？
列出，课程编号，名称，授课老师编号，姓名







