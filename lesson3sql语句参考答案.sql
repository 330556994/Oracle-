���ǵ�һ���֣�
Oracle_SQL scottģʽ�µı�

1.ѡ����30�е�����Ա��.

2.�г����а���Ա(CLERK)����������źͲ��ű��.

3.�ҳ�Ӷ�����н���Ա��.

4.�ҳ�Ӷ�����н���60%��Ա��.

5.�ҳ�����10�����о���(MANAGER)�Ͳ���20�����а���Ա(CLERK)����ϸ����.

6.�ҳ�����10�����о���(MANAGER),����20�����а���Ա(CLERK),�Ȳ��Ǿ����ֲ��ǰ���Ա����н����ڻ����2000������Ա������ϸ����.

7.�ҳ���ȡӶ���Ա���Ĳ�ͬ����.

8.�ҳ�����ȡӶ�����ȡ��Ӷ�����100��Ա��.

9.�ҳ����µ�����3���ܹ͵�����Ա��.

10.�ҳ�����12��ǰ�ܹ͵�Ա��.

11.������ĸ��д�ķ�ʽ��ʾ����Ա��������.

12.��ʾ����Ϊ5���ַ���Ա��������.

13.��ʾ������"R"��Ա��������.

14.��ʾ����Ա��������ǰ�����ַ�.

15.��ʾ����Ա��������,��a�滻����"A"

16.��ʾ��10��������޵�Ա�����������ܹ�����.

17.��ʾԱ������ϸ����,����������.

18.��ʾԱ�����������ܹ�����,�������������,�����ϵ�Ա��������ǰ��.

19.��ʾ����Ա����������������н��,�������Ľ�������,��������ͬ��н������.

20.��ʾ����Ա�������������빫˾����ݺ��·�,���ܹ���������������,���·���ͬ��������ݵ�Ա��������ǰ��.

21.��ʾ��һ����Ϊ30����������Ա������н��,��������.

22.�ҳ���(�κ���ݵ�)2����Ƹ������Ա����

23.����ÿ��Ա��,��ʾ����빫˾������.

24.��ʾ�����ֶε��κ�λ�ð���"A"������Ա��������.

25.�������յķ�ʽ��ʾ����Ա���ķ�������.
=========================================
�����ǵڶ�����

create table student (
   sno char(3) primary key,--ѧ��
   sname varchar2(50) not null,--����
   sex char(2),--�л�Ů
   age int,--����
   classNum char(5) --�༶���
);
insert into student values('108','����','��',19,'95033');
insert into student values('105','����','��',20,'95031');
insert into student values('107','����','Ů',20,'95033');
insert into student values('101','���','��',19,'95033');
insert into student values('109','����','Ů',22,'95031');
insert into student values('103','½��','��',20,'95031');
/*2:������ʦ��*/
create table teacher(
   tno char(3) primary key,--��ʦ��
    tname char(4),--����
   sex char(2),
   age int ,
   grade varchar2(20),--����
   marjor  varchar2(20) --רҵ
);
insert into teacher values('804','���','��',42,'������','�����ϵ');
insert into teacher values('856','����','��',35,'��ʦ','���ӹ���');
insert into teacher values('825','��Ƽ','Ů',28,'����','�����ϵ');
insert into teacher values('831','����','Ů',25,'����','���ӹ���');
/*3:�����γ̱�*/
create table course (
   lid char(5) primary key,
   lname varchar2(50), --�γ����� 
   tno char(3)--��� foreign key(��ʦ��) references teacher(��ʦ��)
);
alter table course 
add constraints fk_course_tno foreign key (tno) references teacher(tno);

insert into course values('3-105','���������','825');
insert into course values('3-245','����ϵͳ','804');
insert into course values('6-166','���ֵ�·','856');
insert into course values('9-888','�ߵ���ѧ','831');
/*4:����ѡ�α�*/
create table sc(
   id  int primary key, --��ţ�������������
   sno char(3),--ѧ��
   lid char(5),--�γ̺�
   score int --�ɼ�
);
alter table sc 
add constraints fk_sc_sno foreign key (sno) references student(sno);
alter table sc 
add constraints fk_lid_sno foreign key (lid) references course(lid);
--����id������
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
��ҵ��:
1.��ѯѡ�޿γ�'3-105'�ҳɼ���60��80֮������м�¼��
ע��:����ָ��ĳ����Χʹ��between and,Ҳ����ʹ��and���ӷ�;
select * from sc where lid='3-105' and score between 60 and 80;

2.��ѯ�ɼ�Ϊ85��86��88�ļ�¼��
ע��:�����ƶ�ĳ������ʹ�� in �ؼ���,Ҳ����ʹ�� or ���ӷ�;
select * from sc where score in (85,86,88);

3.��ѯ'95031'���ѧ��������
ע��:count(*)���ڼ���������;
   select count(*) as studentcount from student where classnum='95031';
   
4.��ѯ��ͷִ���70,����߷�С��90��ѧ���С�
ע��:having������ۺϺ���:avg,min,max,count;having���ֻ�ܸ���:group by���
select sno ,min(score),max(score) from sc group by sno having min(score)>70 and 
max(score)<90;

5.��ѯ������5��ѧ��ѡ�޲���3��ͷ�Ŀγ̵�ƽ���ɼ���
ע��:group by �������where�������ʾ����ʲô����������;
select lid,count(*) studentcount,avg(score) scoreAvg
 from sc where lid like '3%' group by lid having count(*)>=5
6.��ѯƽ���ִ���80�ֵ�ѧ���ĳɼ���
ע��:having������ۺϺ���avg();
select sno,avg(score) avg from sc group by sno having avg(score)>80;
7.��ѯ'95033'��ÿ��ѧ����ѡ�γ̵�ƽ���֡�
  select sno from student where classnum='95033';
   select sno,avg(score) avg from sc where
    sno in (  select sno from student where classnum='95033')
   group by sno ;
ע��:�����Ǹ��� '95033'��ѧ����ѧ�Ž��еķ���,ʹ��where�������group by���ķ�������;

8.��ѡ�� '3-105'Ϊ��,��ѯ�ɼ�����'109'��ͬѧ������ͬѧ�ļ�¼��
ע��:����ʹ�õ��͵�Ƕ�ײ�ѯ,�������;
select * from student where sno in (
 select sno from sc where lid='3-105' 
 and score>( select score from sc where sno='109' and lid='3-105')
 );
 
9.��ѯ��ѧ��Ϊ'108'��ͬѧͬ�������ѧ����ѧ�š����������䡣
ע��:����ѯ�Ľ��������ֻ��һ��ʱ�ؼ���in�����õȼ���'='������,
����ע��'='ֻ
  select * from student where age=(select age from student where sno='108')

10.��ѯ'����'��ʦ�οεĿγ̺ţ�ѡ����γ�ѧ����ѧ�źͳɼ���
ע��:����ʹ���˱������:inner join
,�������������һ�����һ���µı�,������ӵ������Ǳ��������ͬ����;
   select tno from teacher where tname='����'  ;
   --������
   select sc.lid, sc.sno,sc.score from course 
      inner join teacher
      on teacher.tno=course.tno 
     inner join sc 
     on course.lid=sc.lid 
      where teacher.tname='����'
     ; 
     --�Ӳ�ѯ
   select sno,score from sc where lid in (
   select lid from course where tno =( select tno from teacher where tname='����' )
   );


11.��ѯѡ����γ̵�ѧ����������5�˵Ľ�ʦ������
:�������Ƕ�ײ�ѯ�����ӱ����ַ���,���ֳ���ͬ����Ч��;
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
      
        



12.��ѯ'�����ϵ'��'���ӹ���'��ְͬ�ƵĽ�ʦ��������ְ�ơ�
ע��:��ְͬ����ζ�ŷ����ķ��ؽ����ֻ��һ��;
  select tname,grade from teacher where marjor in ('�����ϵ','���ӹ���') 
  group by grade ,tname;
  
13.��ѯѡ�ޱ��Ϊ'3-105'�γ��ҳɼ����ٸ���ѡ�ޱ��Ϊ'3-245'�γ̵�ͬѧ��
�γ̺š�ѧ�� ���ɼ������ɼ��Ӹߵ��ʹ������С�
  select lid,sno,score from sc where lid='3-105' 
  and score  >any (   select score from sc where lid='3-245')
  order by score desc;
ע��:any ��ʾ����һ��;

14.��ѯѡ�ޱ��Ϊ'3-105'�γ��ҳɼ�����ѡ�ޱ��Ϊ'3-245'�γ̵�ͬѧ�Ŀγ̺š�ѧ�� ���ɼ���
ע��:all ��ʾ����;
  select lid,sno,score from sc where lid='3-105' 
  and score  >all (   select score from sc where lid='3-245')
  order by score desc;


15.�г����н�ʦ��ͬѧ������ ���Ա� �����䡣
ע��:���⽫���б�������һ��:
--ʹ��������     
     select teacher.tname,teacher.sex,teacher.age,
  student.sname,student.sex,student.age from teacher 
        left join course 
     on teacher.tno=course.tno
     left join sc 
     on sc.lid=course.lid
     left join student
     on sc.sno=student.sno
     
     
     
     
     
  --------------------------------------------------------------------------------
  
     

16.��ѯ�ɼ���'3-105'�γ̵�ƽ���ɼ��͵�ѧ���ĳɼ���
��:
  select * from sc where score<(
    select avg(score) from sc where lid='3-105')

17.��ѯ�ɼ��ȸÿγ�ƽ���ɼ��͵�ѧ���ĳɼ���
ע��:�����������������ѵ�,����ķ����ܾ���,��������ĥ,
�Ȱ��տγ̽��з���,���С�ڸ��ſγ�ƽ���ɼ������гɼ�;
select sc.sno,sc.lid,sc.score from sc
inner join (
select lid, avg(score) avgscore from sc group by lid
) b
on sc.lid=b.lid 
where sc.score<b.avgscore
order by sc.score desc


18.�г������ον�ʦ�����������ڿΡ�
ע��:������רҵ�漰������course���teacher��,ֻ����������������ܽ��������;
��:
select tname,lname from teacher,course where teacher.tno=course.tno


19.�г�����δ���ν�ʦ��������רҵ��
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
  
  
  
20.�г�������2�������İ�š�
ע��:�����Ա�='��'�����������student����з���Ϳ�����;
��:
  select classnum ,count(*)  from student 
   where sex='��'
   group by classnum having count(*) >=2

21.��ѯ����'��'��ѧ����¼��
  select * from student where sname not like '��%'

22.��ѯÿ�ſ���߷ֵ�ѧ����ѧ�š��γ̺š��ɼ���
ע��:����ļ������ڸ�����߷�����ɼ���;
select sno,t1.lid,sc.score from sc inner join (
select lid,max(score) max from sc group by lid
) t1  on sc.lid=t1.lid  where sc.score=t1.max;

23.��ѯ��'���'ͬ�Ա�ͬ���ͬѧ���֡�
ע��:Ƕ�ײ�ѯ;
select * from student where classnum=(
    select classnum from student where sname='���')
  and sex=( select sex from student where sname='���')  
  and sname!='���'
    

24.��ѯ'��'��ʦ�������ϵĿγ̡�
ע��:�ȷ��������漰�ı�;
select teacher.tno,teacher.tname,teacher.sex,t1.lid,t1.lname from teacher 
inner join 
(
select tno,lid,lname  from course where lid in (
select distinct lid  from sc
)) t1 on teacher.tno=t1.tno where sex='��'

25.��ѯѡ��'���������'�γ̵�'��'ͬѧ�ĳɼ���
ע��:������Ƕ�ײ�ѯ�ͱ��������ַ������н��;
select * from sc where sno in (
select sno from student where sex='��' and sno in (
  select sno from sc where lid =(  select lid from course where lname='���������')
  )
  )  and sc. lid =(  select lid from course where lname='���������');
--������д��
   select sc.* from student 
    inner join sc 
    on student.sno=sc.sno
    inner join course
    on sc.lid=course.lid
    where course.lname='���������' and student.sex='��'
26. select * from sc
 select * from course
ѡ�����ֵ�·���ſε�ѧ������ѡ����Щ�Σ�
�г����γ̱�ţ����ƣ��ڿ���ʦ��ţ�����







