--���ݿ����
--table ��constraint
--��ʱ������Ҫ�õ�һ���У����Զ�������ĳ�����id
-- 1.���з�����   sequence
--������һ�����У����ֽ�seq
create sequence seq
start with 1000
increment by 1;
--
select seq.nextval from dual
select seq.currval from dual
--
select * from tbemp
--��������insert��
  insert into tbemp(id,name,birthday,phone,sex,salary)
  values(seq.nextval,'���',to_date('1955-10-5','yyyy-mm-dd'),'13812340999',0,8600 );
----------------------------------------------  

--------------------------------------------------------------------------------------------------------
--PL/SQL ���
--��������/sql  
-- PL/SQL�� 
[ declare] --��������
 
 begin --�����
   
 [exception] --�쳣����
 end;
 --------
--һ����
 declare
   --�����Ƕ�����оֲ�����
   v_id int;--����һ������������v_id ����
   v_name varchar2(50);
   v_age number:=100 ;--���������ʱ�򸳳�ֵ  ��ֵ��:=
   v_sal number;
   v_empno int :=7369;
 begin    
   v_age:=20;--��������ֵ 
  --������ʹ��sql���ķ�ʽ��ֵ,ע�⣬�����where�����У��õ��˱���
  select ename,sal into v_name,v_sal from emp where empno=v_empno;
  dbms_output.put_line('����'||v_name||'����'||to_char(v_sal));--dbms_output ����ϵͳ�ṩ��һ����
  --ʲô�ǰ�������һ���࣬���а������Ǿ�̬����
  -- emp����
 end; 
 --�������������������գ��õ���ǰ��������
 --��ӡ 2017��1��13��
 declare
      v_year int;
      v_month int;
      v_date int;
 begin
    v_year:= to_number( to_char( sysdate,'yyyy'));
    --����·�
     v_month:=extract(month from sysdate);--����·�
    -- select extract(month from sysdate)   into v_month  from dual ;
     v_date:= extract(day from sysdate);--�������
   dbms_output.put_line(to_char(v_year)||'��'||to_char(v_month)||'��'||to_char(v_date));
 end;
 --�������
 --�������
 --�жϽ����ǲ�������
 declare
     v_year int;
 begin
   v_year:=extract(year from sysdate);--�õ����
   v_year:='&������һ�����';--�����û�����
   if (mod(v_year,4)=0 and  mod(v_year,100)!=0) or mod(v_year,400)=0 then
     dbms_output.put_line(to_char(v_year)||'������');
   else
     dbms_output.put_line(to_char(v_year)||'��������'); 
   end if;
 end; 
 --����ɼ�
 --����ɼ�>90�֣���� ����
 -->80  ����
 -->60  �ϸ�
 --<60 ���ϸ�
 --��������������
 declare 
       v_score int;--�ɼ�
       v_msg varchar2(100);
 begin 
     v_score:='&������ɼ�';
     if v_score>=90 then
        v_msg:='����';
     elsif v_score>=80 then 
           v_msg:='����' ;
      elsif v_score>=60 then 
           v_msg:='�ϸ�' ;
      elsif v_score>=0 then
           v_msg:='���ϸ�';
       else 
         v_msg:='���벻�Ϸ�';
      end if;
      dbms_output.put_line(v_msg);
 end;
--case���
 declare 
       v_score int;--�ɼ�
       v_msg varchar2(100);
       v_flag char :='b';
 begin 
     v_score:='&������ɼ�';
     --case����һ�ָ�ʽ
     case v_flag
          when 'a' then
            dbms_output.put_line('�ɼ�����90');
          when 'b' then
            dbms_output.put_line('�ɼ�����80');     
        when 'c' then
            dbms_output.put_line('�ɼ�����60');     
             when 'd' then
            dbms_output.put_line('������');     
      else
            dbms_output.put_line('��ʽ����');     
     end case;
     --case ���
     case 
       when v_score>=90 then
         dbms_output.put_line('����');
        when v_score>=80 then
         dbms_output.put_line('����');   
      when v_score>=60 then
         dbms_output.put_line('�ϸ�');  
       else        
           dbms_output.put_line('���ϸ�');  
       end case;
       -- case���ʽ
       v_msg:=case 
       when v_score>=90 then '����'
        when v_score>=80 then '����'
      when v_score>=60 then '�ϸ�'
       else        '���ϸ�' 
       end;
       dbms_output.put_line(v_msg);
 end;
 --sql �������case   ������20 �г���  10������ 30  ���̲�
 select empno,ename,deptno,
     case deptno when 10 then '������'
          when 20  then '�г���'
           when 30 then '���̲�'
             else 'δ֪' end as dname 
       from emp;
--
--��ϰ��
���������ε������߳� a,b,c
������������Σ����������������ӡ������������
s=(a+b+c)/2
��� =������ s*(s-a)*(s-b)*(s-c)
declare
   v_a real;
   v_b real;
   v_c real;
   v_s number(8,2);
   v_area number(8,2);
begin
   v_a:='&������߳�a';
   v_b:='&������߳�b';
   v_c:='&������߳�c';
   v_s:=(v_a+v_b+v_c)/2;
   if v_a+v_b>v_c and v_a+v_c>v_b and v_b+v_c>v_a then
      v_area:=sqrt(v_s*(v_s-v_a)*(v_s-v_b)*(v_s-v_c));
      dbms_output.put_line('���Ϊ'||v_area);
   else
     dbms_output.put_line('�޷�����������');
   end if;
end;




-------------------------------------------------------------------------------------------------------
--ѭ���ṹ������ѭ����� 
--
------------------------------------------
 declare
   v_i int:=0;
   v_sum int:=0;
 begin
   loop
      v_i:=v_i+1;
     v_sum:=v_sum+v_i;    
     exit when v_i=100;--�˳�����
   end loop;
   v_i:=0;
   v_sum:=0;
   --�ڶ���ѭ�� while
   while v_i<=100
     loop
        v_sum:=v_sum+v_i;  
            v_i:=v_i+1;  
     end loop;
    --�����ֽṹ for
   v_sum:=0;
   for v_i in 1..100
     loop
        v_sum:=v_sum+v_i;  
     end loop;     
   dbms_output.put_line('1-100���ۼ�ֵΪ'||v_sum);
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
 --�������ˮ�ɻ���
 ------------------------------------------------------------------------------------------------
--�������� 
--���Ҫȡ��ĳ��������У���Ҫ�Ȳ���е����ͣ�Ȼ���塣
--���и����⣬������ݱ�����޸����أ�����������ܻ�����⡣
-- %type   ����һ�������������������Ѷ����ĳ�����������
--%rowtype ����һ����¼����������һ����Ϣ��
--����Ա����ţ���ʾԱ������
declare
  v_no emp.empno%type;--����һ������v_no��������emp.empno�е�����
  v_row emp%rowtype; --����һ������v_row������һ����¼���ͣ��е�����
  --������ͱ�ʾemp���һ�С�
begin
   v_no:='&������Ա�����';
   select * into v_row from emp ;-- where empno=v_no;
   dbms_output.put_line(v_row.ename||'  '||v_row.empno||'  '||v_row.job);
exception 
     when no_data_found then  --����ĳ���ض��쳣
       dbms_output.put_line('������ı�Ų���������');
   when others then --ץ�쳣�ϴ�,�൱��java��excepion ���Ҫ�������
      dbms_output.put_line( '�쳣���Ϊ:'|| sqlcode ||' �쳣����Ϊ'||sqlerrm );
end;
--�Զ����쳣
-- ��ʾ���������������ߣ���������������Σ������Զ��崦��
--�����򣬴�ӡ�ܳ�
declare
  a int;
  b int;
  c int;
  trangleException exception; --����һ���Զ����쳣
begin
  a:='&����a�߳�';
  b:='&����b�߳�';
  c:='&����c�߳�';
  if a+b>c and  b+c>a  and a+c>b then
     --��ӡ�ܳ�
     dbms_output.put_line('�ܳ�Ϊ'||(a+b+c));
  else
    --���쳣
    raise trangleException;--�׳��Զ����쳣
  end if;
exception
  when   trangleException then
    dbms_output.put_line('����������߲����������Σ�����');
  when others then --ץ�쳣�ϴ�,�൱��java��excepion ���Ҫ�������
      dbms_output.put_line( '�쳣���Ϊ:'|| sqlcode ||' �쳣����Ϊ'||sqlerrm );
 end; 
--��ϵͳ�쳣���ǳ����� throw new Exception("abc")
declare
  a int;
  b int;
  c int;
begin
  a:='&����a�߳�';
  b:='&����b�߳�';
  c:='&����c�߳�';
  if a+b>c and  b+c>a  and a+c>b then
     --��ӡ�ܳ�
     dbms_output.put_line('�ܳ�Ϊ'||(a+b+c));
  else
     --�׳�һ���쳣
     raise_application_error(-20100,'����:���߲�����������');
  end if;
exception
  when others then --ץ�쳣�ϴ�,�൱��java��excepion ���Ҫ�������
      dbms_output.put_line( '�쳣���Ϊ:'|| sqlcode ||' �쳣����Ϊ'||sqlerrm );
 end; 
-----------------------------------------------------------------------------------
select * from tab;--tab��ǰģʽ��ı�
select * from user_tables--���ص�ǰģʽ�µı�
select * from all_objects where owner='BOOKSHOP';

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 select * from emp
 
 
 
 







  
  
  

