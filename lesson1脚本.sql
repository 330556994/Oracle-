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
  is 'Ա�����';
comment on column tbEmp.name
  is '����';
comment on column tbEmp.phone
  is '�ֻ�����';
comment on column tbEmp.birthday
  is '��������';
comment on column tbEmp.sex
  is '�Ա�0���� 1Ů';
comment on column tbEmp.salary
  is '����';
  */
  --����ע�ͣ�������������
  --���з����ֶ��ǵ�����,���ֲ�������
  --����"" ˫����
--ע�⣬����ֵ����Ҫ��Ӧ
--�﷨ insert into ����(�б�)values(ֵ��)
  insert into tbemp(id,name,phone,sex,salary)
  values(1,'����','13812345678',1,4500 );
  --���ڴ���
  --to_date('1998-10-5','yyyy-mm-dd') �ڲ������������ǽ�һ���ַ���ת��
  --������
  insert into tbemp(id,name,birthday,phone,sex,salary)
  values(1,'����',to_date('1998-10-5','yyyy-mm-dd'),'13812345678',1,4500 );
  --
    insert into tbemp(id,name,birthday,phone,sex,salary)
  values(2,'����',to_date('1968-10-5','yyyy-mm-dd'),'13812349999',0,3600 );
   --
   insert into tbemp(id,name,birthday,phone,sex,salary)
  values(3,'����',to_date('1980-9-5','yyyy-mm-dd'),'13312348765',0,8300 );  
  --
  insert into tbemp(id,name,birthday,phone,sex,salary)
  values(4,'С��',to_date('1986-3-5','yyyy-mm-dd'),'13012348765',0,2900 );  
--
  insert into tbemp(id,name,birthday,phone,sex,salary)
  values(5,'С��',to_date('1988-3-5','yyyy-mm-dd'),'13112348765',0,3300 );  
  
  
  commit;--�ύ�޸�
  --��򵥵Ĳ鿴
  select * from tbemp;
  --ɾ��
  select rowid,id,name from tbemp;

  delete from tbemp where rowid='AAASPPAAEAAAAJ0AAB'
    select * from tbemp;