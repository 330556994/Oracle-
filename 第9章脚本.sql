--oracle���α�
-- ���ֻ����ȡһ�еĻ�ֻ��into ����
--�����ǣ�Ҫ��һ�����ݽ��в����أ�
--��ӡ����Ϊ20��Ա�������͹���
--����ʹ���α�(����������)������ָ��һ����ѯ��������У���
--����ͨ���������α꣬����õ�ǰ�е���Ϣ������ѭ����ֱ��������ϡ�
declare
   v_row emp%rowtype;
   --����һ���α����ֽ�emp_cursor��ָ��һ��select���
   cursor emp_cursor is select * from emp where deptno=20;
begin
   open emp_cursor;--���α꣬�α�ָ�����һ����¼����һ����
   loop
     --�α���ȡ��һ�У�ͬʱָ����һ�С����ѵ�ǰ�α��м�¼�����浽������
     fetch emp_cursor into v_row;
--     emp_cursor%notfound  �����ڣ�%rowcount��¼����,%found����  %isopen�Ƿ��
     exit when emp_cursor%notfound; 
      --����ҵ��
      dbms_output.put_line(v_row.ename||'  '||v_row.sal);
    
   end loop;
   close emp_cursor;--�ر��α�
end;
-----------------------
--�α���ʹ�ñ���
declare
   v_row emp%rowtype;
   v_no emp.deptno%type;
   --����һ���α����ֽ�emp_cursor��ָ��һ��select���
   cursor emp_cursor is select * from emp where deptno=v_no;
begin
  v_no:=20;
   open emp_cursor;--���α꣬�α�ָ�����һ����¼����һ����
   loop
     --�α���ȡ��һ�У�ͬʱָ����һ�С����ѵ�ǰ�α��м�¼�����浽������
     fetch emp_cursor into v_row;
--     emp_cursor%notfound  �����ڣ�%rowcount��¼����,%found����  %isopen�Ƿ��
     exit when emp_cursor%notfound; 
      --����ҵ��
      dbms_output.put_line(v_row.ename||'  '||v_row.sal);
    
   end loop;
   close emp_cursor;--�ر��α�
end;
-----------------------------------------
-----------------------
--���������α�
declare
   v_row emp%rowtype;
   --����һ���α����ֽ�emp_cursor��ָ��һ��select���
   --�α궨���к���������select��ʹ�øò���
   cursor emp_cursor(v_no emp.deptno%type) is select * from emp where deptno=v_no;
begin
  --v_no:=20;
   open emp_cursor(20);--���α꣬�α�ָ�����һ����¼����һ����
   loop
     --�α���ȡ��һ�У�ͬʱָ����һ�С����ѵ�ǰ�α��м�¼�����浽������
     fetch emp_cursor into v_row;
--     emp_cursor%notfound  �����ڣ�%rowcount��¼����,%found����  %isopen�Ƿ��
     exit when emp_cursor%notfound; 
      --����ҵ��
      dbms_output.put_line(v_row.ename||'  '||v_row.sal);    
   end loop;
   close emp_cursor;--�ر��α�
end;
-----------------------------------------------
--ʹ��for in ���α��ȡ
declare
   cursor emp_cursor(v_no emp.deptno%type) is select * from emp where deptno=v_no;
begin
  --����open������fetch������close�����趨���������ȡ
   for emp_record in emp_cursor(20) loop
       dbms_output.put_line(emp_record.ename||' ����'||emp_record.sal);
   end loop;
end;
---------------------------------------------------------------
--��ʽ�α�
--���趨��ģ�����ִ��DML��� select,insert,update,delete
--�Զ�������ʽ�α꣬���ǿ���ʹ���α�����������SQL���ִ�е����
--����һ�����ű�ţ�ɾ���ò�����Ա����Ϣ,���ɾ���ɹ���ʾ���ɹ�������
--������Ų����ڣ�����ʾ��
declare
    v_no emp.deptno%type;
begin
  v_no:='&������Ҫɾ���Ĳ�������';
  delete from emp where deptno=v_no;
  if sql%found=true then
     dbms_output.put_line('ɾ���ɹ�,��ɾ��'||sql%rowcount);
  else
     dbms_output.put_line('ɾ��ʧ�ܣ��ò��Ų�����');
  end if;
end;
rollback;
select * from emp where deptno=10
--------------------------------------------------------------------------------------------
--ref �α���÷�
--��̬�α꣬�ڶ���ʱ��ָ����sql��䡣
--���ڣ������ִ��ʱ����ȷ�����ĸ�sql���Ļ���
--ref�α� ���α�������ܹ�ʵ�֣�����ʱ��ָ����ʹ��ʱָ��sql
-- type ref_name is ref cursor [return retu_type]  ����һ��ref�α����� 
declare
--����һ��ref corsor���ͣ��޹涨����ֵ����������
   type ref_type_emp is ref cursor; 
   v_rec dept%rowtype;
   v_row emp%rowtype;--����һ���б������������α���ȡ
--����һ��ref corsor���ͣ��涨����ֵ���ͣ���ǿ����   
 --  type ref_type_emp is ref cursor return emp%rowtype;--    
    mycur ref_type_emp;--�øոմ�����ref corsor����ȥ����һ���α����
begin
  open mycur for select * from emp;--������α����������һ��sql���
 fetch mycur into v_row;--��ȡ�α� 
 while  mycur%found
  loop 
      dbms_output.put_line(v_row.ename||'   '||v_row.sal);
      fetch mycur into v_row;--��ȡ�α� 
  end loop;
  close mycur;
  --ָ����һ�ű�
  open mycur for select * from dept;
   fetch mycur into v_rec;--��ȡ�α� 
 while  mycur%found
  loop 
      dbms_output.put_line(v_rec.dname||'   '||v_rec.deptno);
      fetch mycur into v_rec;--��ȡ�α� 
  end loop;
  close mycur;
end;
-------------------------------------------------------------
--��̬�α�󶨱�������
declare
--type sys_refcursor is ref cursor
  cur sys_refcursor;--����ϵͳ�Ѿ�����õ�������ref cursoe
  rec emp%rowtype;
  v_deptno emp.deptno%type;
  v_sal emp.sal%type;
begin
  v_deptno:=20;
  v_sal:=2000;
  --ִ�ж�̬sql���󶨱�����:1,:2ֻ��ռλ��
  open cur for 'select * from emp where deptno=:1 and sal>:2' using v_deptno,v_sal;
  loop
    fetch cur into rec;
    exit when cur%notfound ;
    dbms_output.put_line(rec.ename||'   '||rec.sal);
  end loop;
  close cur;
  
end;
-------------------------------------------------------------------------
--ִ�ж�̬sql
--��̬sql���ǲ�ȷ���ġ������ڿ��У��ǲ�����ʹ��DDL���
declare
   v_sql varchar2(50);
begin
  v_sql:='create table t1(id int,name varchar2(50))';
  execute immediate v_sql;--ִ���Ǹ���̬sql
 exception
    when others then 
      dbms_output.put_line('error: '||sqlcode||sqlerrm);
end;
select * from tab;
----------------------------------------------------------------------------------
--ִ�ж�̬sql�󶨱���
declare
       v_sql varchar2(50);
begin 
   v_sql:='delete from emp  where deptno=:1';
   execute immediate v_sql  using 20;--ִ�е�ʱ��󶨱���
end;
----------------------------------------------------------------
--ִ�ж�̬sql���õ�ֵ���󶨱���
declare
       v_sql varchar2(50);
       v_count int;
begin 
   v_sql:='select count(*)  from emp  where deptno=:1';
   execute immediate v_sql into v_count  using 20;--ִ�е�ʱ��󶨱���
   dbms_output.put_line('��¼����Ϊ:'||v_count);
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
               1      50  1    13312121212       flag 1:δ����   2���ͻ��� 3�����  4�Ѻϲ�
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
--Ҫ�� ��  �������2�ϲ���1����
--���
-----------------
--�ϲ���ǰ���� ͬһ���û��µĶ��������Ҷ���״̬Ϊ1
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
  v_oid1 tborder.id%type;--Դ�������
  v_oid2  tborder.id%type; --�ϲ���Ŀ�궩�����
  v_rec1 tborder%rowtype;--����ԭ������¼����
  v_rec2 tborder%rowtype;--�ϲ���Ŀ�궩����¼����
  v_rec3 tborderdetail%rowtype;--����Դ������ϸ����
  curOrder sys_refcursor;--�����α���� ָ��Դ������ϸ
  v_count int ;--��ʱ����������������¼��
  v_sql varchar2(500);--��̬sql
begin
  v_oid1:=2;
  v_oid2:=1;
  --�ȼ���Ƿ���Ժϲ���Ҫ����ͬһ���û��µģ�����״̬Ϊ1
  select * into v_rec1 from tborder where id=v_oid1;--ȡ��Դ��������
  select * into v_rec2 from tborder where id=v_oid2;--ȡ��Ŀ�궩��
 if v_rec1.userid!=v_rec2.userid then  --���Ǽ���Ƿ�ͬһ���û���
   raise_application_error(-20111,'�����޷��ϲ�������ͬһ���û��ö���');
 end if;
 if v_rec1.flag=v_rec2.flag and v_rec2.flag=1 then
     --���Ժϲ���
     --˼·��ȡ��Դ�����µ�ÿһ����ϸ���жϸ���ϸ��Ŀ�궩�����Ƿ���ڣ�
     --������ڣ���Ŀ�궩������ϸ������ӣ��������أ�����뵽Ŀ�궩��
     open curOrder for 'select * from tborderdetail where oid=:1' using v_oid2;
    loop
          fetch curOrder into v_rec3;
          exit when curOrder%notfound ;
          --����
          --�жϸ�����¼��Ŀ�궩����ϸ���Ƿ����
            select count(*) into v_count from tborderdetail where productid=v_rec3.productid
                and oid=v_oid1;
            if v_count>0 then 
              --���ڣ�������������
             v_sql:= 'update tborderdetail set qty=qty+:1 where productid=:2 and oid=:3';
             --ִ�ж�̬sql���󶨱���
              execute immediate v_sql using v_rec3.qty ,v_rec3.productid,v_rec3.oid;
            else
              --�����ڣ���������
                 insert into tbOrderDetail values(seq_orderdetail_id.nextval,v_oid2,
                 v_rec3.productid,v_rec3.price,v_rec3.qty);              
            end if;
  end loop;  
  close curOrder;
  --����Դ������״̬Ϊ4
  update tborder set flag=4 where id=v_oid1;
  --����Ŀ�궩�����ܼ�
  update tborder set totalprice=(select sum(qty*price) from tborderdetail where oid=v_oid2)
   where id=v_oid2;
 else
   --���ܺϲ�
   raise_application_error(-20111,'�����޷��ϲ�������״̬��Ϊ1');
 end if;

exception 
  when others then
    dbms_output.put_line('����'||sqlcode||sqlerrm);  
  
  
end ;
--
  update tborder set totalprice=(select sum(qty*price) from tborderdetail where oid=2)
   where id=2
�󶩵����2���ܼ�
update tborder set flag=1
commit;
-----
  �ж϶������2 �Ƿ����Ʒa
  select count(*) into v_count from tborderdetail where productid='a' and oid=2
 ���¶������2 ������Ĳ�Ʒa�������ۼ�3
 update tborderdetail set qty=qty+3 where productid='a' and oid=2
select * from  tborderdetail where productid='a' and oid=2
rollback;

--------------------------
--�ڶ����ؼ���ҵ
-- ʹ�ö�̬sql ������     t2( id,a,b,c,area ) 
  --  ѭ�� 10000 �Σ����������1��������idҪ��������,a,b,cΪ100-500֮���������
--�������t2,��ɾ��
-------------------------
--b���֣���10000����¼��������⣬abc��ʼ���������ε������ߣ�������������Σ��������
--�����ɣ���ɾ���ü�¼


select * from emp where deptno=20
rollback
=====================================================================
���������Ƿǳ���Ҫ��sql����ú�����
ת�˲�����
   bankaccount
   
      id         userid     money   flag(����)   optdate
      1         ����      1000       ����         2012-1-1
      2        ����       -200        ֧ȡ        2012-1-4
      3        ����       5000       ����        2012-1-5
      4        ����       -500        ת��        2012-1-9
      5       ����       500         ת��         2012-1-9
     create table bankaccount(
            id int primary key,
            userid varchar2(50) not null,
            money number(8,2) not null,
            flag   char(8) not null,--���룬֧ȡ��ת�룬ת�� 
            optdate date default sysdate 
     )

     create sequence bankaccount_id start with 1;--Ϊ��id����һ������
     insert into bankaccount values(bankaccount_id.nextval,
     '����',1000,'����',to_date('2012-1-1','yyyy-mm-dd'));
     insert into bankaccount values(bankaccount_id.nextval,
     '����',-200,'֧ȡ',to_date('2012-1-4','yyyy-mm-dd'));
          insert into bankaccount values(bankaccount_id.nextval,
     '����',5000,'����',to_date('2012-1-5','yyyy-mm-dd'));
     
   select * from bankaccount
   commit;
      --����ת�˲�����һ���˺ſ�500��ת����һ���˺�
      ����sql��䣬��Щsql��䣬��ʵ��һ�����壬���ָܷ�߱���Ҫôһ��ɹ�
      Ҫôһ��ʧ�ܣ���������һ���ɹ���һ��ʧ�ܡ�
      �����Ҫ������
      ������ص㣺ԭ���ԣ���һ�����壬���ָܷ��
         һ���ԣ�Ҫô�Ǹı�ǰ��״̬��Ҫô�Ǹı���״̬��
         �����ԣ�����֮�以��Ӱ��
         �־��ԣ�Ҫô�ɹ������øı䣬Ҫô�ع�����ɶ��û������
    --
    --oracle���������
    --��������
    --1����һ���ύ���Զ�����
    --2. insert,update,delete�����Զ���������
   --��������
   -- commit/rollback
   --ԭ��ĽǶȣ������У����ݻ�ŵ��ع����С��ύʱ���ӻع��������������ύ��������
    select * from bankaccount
    --ת�˲���
    declare
       v_name1 bankaccount.userid%type; --ת���˺�
       v_name2 bankaccount.userid%type; --ת���˺�
       v_money bankaccount.money%type;--��ת���    
     --  v_bank bankaccount%rowtype;--����һ����¼����
     v_count int; --��ʱ���������������˺��Ƿ����
     v_sum bankaccount.money%type;--��ʱ�������������棬ת���˺���
    begin
      v_name1:='&������ת���˺�';
      v_name2:='&������ת���˺�';
      v_money:='&������ת�����';

      --�����Ǳ�Ҫ����֤
      --����֤�˺���Ч�ԣ�����֤����Ƿ�  ֻҪ��1Ԫ
      select count(*)  into v_count from bankaccount where userid=v_name1;
       if v_count<1 then 
          raise_application_error(-20111,'ת���˺���Ч') ;
       end if;
       select count(*)  into v_count from bankaccount where userid=v_name2;
       if v_count<1 then 
          raise_application_error(-20111,'ת���˺���Ч') ;
       end if;
       --����֤�˻�����Ƿ��㹻
       --���ת���˺����
     
      --��ʼת�˲���
       --��ת��
       insert into bankaccount values(bankaccount_id.nextval,
     v_name1,-v_money,'ת��',sysdate);
--       ��ת��
     insert into bankaccount values(bankaccount_id.nextval,
     v_name2,v_money,'ת��',sysdate);
     
       select sum(money) into v_sum from bankaccount where userid=v_name1;
       
       if v_sum+1<=v_money then
         --����
         rollback; --�ع�����
         dbms_output.put_line('ת��ʧ��');
        else
               commit;--�ύ����          
                      dbms_output.put_line(v_name1||'�ɹ�ת��'||v_name2||v_money||'Ԫ');
       end if;    
     
       
     exception
        when others then 
          case sqlcode
            when -20111 then
             dbms_output.put_line('����!�˻�����');   
           when -20112 then
             dbms_output.put_line('����!ת���˺�����');   
            else 
                        dbms_output.put_line('ִ��sqlʱ����!'||sqlcode||sqlerrm);   
                        rollback ;--�ع�����
                        
           end case;
                      
    end;     
         
    select * from bankaccount;
    
rollback;
      
  ---------------------------------------------------------
  �ܶ���Ҫ��������İ������� ��������
  ���������� һ������ϸ������
  select * from  tborder ;
  select * from tborderdetail;
  begin
     insert into tborder values(4,100,1,'13312454545');
     insert into tbOrderDetail values(seq_orderdetail_id.nextval,4,'a',20,1);             
     insert into tbOrderDetail values(seq_orderdetail_id.nextval,4,'b',10,2);  
     insert into tbOrderDetail values(seq_orderdetail_id.nextval,9,'b',10,2);  
     commit;
         dbms_output.put_line('��������ɹ�');
  exception 
    when others then
         dbms_output.put_line('��������ʧ��'||sqlcode||sqlerrm);
         rollback;   
  end;
  delete from tbOrderDetail where oid=9
  -----------------------------------------------------------------------
  --������
  -- ��Ϊ����û�ͬʱ����һ����Դ���ͻ����������
  --���������⣬A,B�������񣬵�AҪ������ȥ��������B��������Դ����BҪ
  --������ȥ����Ҫ���A��������Դ
  --����ִ���ڼ䣬��������Դ�������ͷ�
  -----------------------------------------------------------
   update emp set sal=sal+100 where empno=7499;
      update emp set sal=sal+100 where empno=7369;
   
   select * from emp;
      rollback;
     -------------------------------------------------------------------------------
     --���ֳ� �м���  �ͱ���  
     �м�����
     --�����м�������������ֻ�ܲ�ѯ�����ܸ��»�ɾ��
     select * from emp where deptno=20 for update --��ѯ���ݣ������м�������
     --�ͷ�������Դ��commit  rollback
     select * from emp where deptno=20 for update nowait; --nowait���ǲ��ȴ�
     rollback;
     -----------------
     ����
     lock table emp in share mode;--��emp�����������ű�share
      lock table emp in exclusive  mode;--��emp������ռ�������ű�share
     select * from emp where empno=7369--20 for update
     rollback;
 -------------------------------------------------------------------------------------------
 --��Ʊϵͳ�� 
 --��η�ֹһ��Ʊ��������ˣ�
 --    
     
     
     
     
     
     
     
     
     
     
     
      
      
















-------------------------------------------

 --select * from emp where deptno=20;

