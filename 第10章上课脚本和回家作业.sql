--��10��
--�ӳ���ʹ�����
--�ӳ����Ǳ������ֵ�PL/SQL��
-- ������̣���һ�����̣������һ��������
--�ô����������ã��ṹ����̣���һЩ���ӵ�ҵ����з�װ������Ԥ�����
--ִ���ٶȷǳ��졣�����������ܣ������ݿ⿪�����ձ�ʹ�á�
--���Ƕ����﷨
--�����ֳɣ�
--�����������ֵ����������̵� input
--�����������ֵ�Ӵ�������ڲ������ⲿ�����ϣ��һ��������̷��ض��ֵ
--��ô���Զ������������ out  
--˵���������б��еĲ�����������������,ֻ����������
create or replace procedure  proc_getTriangleArea
(
--���ܣ����������ε����ߣ������
   --�����ǲ����б�
   v_a int  ,--���������ʾ�߳�a
   v_b int,--ʡ��ģʽ��������� �߳�b
   v_c int,--�߳�C
   v_area out number,--��ʾ�����������������
   v_errcode out int --��ʾ������� 0 �ɹ�  -1������������  -2��������
   )
as
--�����Ƕ������
  v_s number(8,2);
begin
  v_s:=(v_a+v_b+v_c)/2 ;--��ʱ��������ʾ s
 --������ִ�д���
--���жϲ����Ƿ����Ҫ��
  if v_a<=0 or v_b <=0 or v_c<=0 then
    v_errcode:=-2;--��������
    return ;--������
  end if; 
  --�ж��Ƿ񹹳�������
  if v_a+v_b>v_c and v_a+v_c>v_b and v_c+v_b>v_a then
    --���������
    v_area:= sqrt( v_s*(v_s-v_a)*(v_s-v_b)*(v_s-v_c));
    v_errcode:=0;
    return ;
  else
     v_errcode:=-1;--������������
   return ;--������
  end if;  
 --�쳣������ѡ
end proc_getTriangleArea;
--������������涨�������������
declare
   area number(8,2);
   errcode int ;
begin
  --���ô洢���̣����ղ�������˳��ֵ
   proc_getTriangleArea(3,4,5, area , errcode );
   if errcode=0 then
        dbms_output.put_line('���Ϊ'||area);
   end if;
      if errcode=-1 then
        dbms_output.put_line('������������');
   end if;
         if errcode=-2 then
        dbms_output.put_line('��������');
   end if;
end;
-------------------------
select sal+nvl( comm,0) as salary   from emp where empno=7369;
----
create or replace procedure
--���ݴ����Ա����ţ���ø�Ա���Ĺ���
--ע�⣬�����̲������쳣
 proc_getEmpSalary(
 v_empno emp.empno%type,--Ҫ���Ա�����
 v_salary out number--���ʣ���н+���
 )
 is
 begin
    select sal+nvl( comm,0) into v_salary   from emp 
    where empno=v_empno;
end proc_getEmpSalary;
--��������¸ô洢����
declare
    v_empno emp.empno%type;
    v_salary number(8,2);
begin
  v_empno:='&������Ա�����';
  --����洢������û�д����쳣����Ϊִ����sql��ѯ��
  --�Ǿ��ɵ����ߴ����쳣��һ�㴢����������������ڲ������쳣
  proc_getEmpSalary(v_empno,v_salary);
  dbms_output.put_line(''||v_empno||' �Ĺ�����'||v_salary);
  exception 
    when others then 
      dbms_output.put_line(sqlcode||sqlerrm);
end;
-------------------------------------------------------------------------
�ؼ���ҵ��
 ���涼��д�������
 1.  proc_isLeapYear( year) ������̣�������ݣ��ж��Ƿ�������
  ��������ǲ���ֵ
  
 2. proc_getValue(a,b,c ,x1,x2)  ������̣�����a,b,c����ϵ���������
 һԪ���η��̵Ľ⣬x1,x2�������������ʾ�⡣
 3. proc_isRouseNumber(num,ret) �ж���������Ƿ���õ�廨������������ǽ��
 ����ֵ
 4. proc_getMoney(int cardid,string opt ,out val number)
 ���������̵Ĺ����ǣ����뿨�ţ��Ͳ������ͣ��õ��ÿ���ֵ
 opt ��ֵΪ  '����'��֧����ת�룬ת��
 5. proc_insert_score
  ���������̵Ĺ����ǣ�ѭ������������ˮ������Ǵ��룬��������
  ������10Ԫ��1����
 �ȴ����� bankscore
                      id int primary key ��������
                      bankaccountid int --��ˮ��ţ������������ˮ�������
                      money number(8,2)
                     
                      score  int --����
���ű��ǿյ�                      
 select * from bankaccountinfor
 
 
 
 
 
 
 












