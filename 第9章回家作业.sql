1.
  �����˻���Ϣ��
 bankInfor
   cardId����������,pwd ���룬username����,phone�ֻ�����,address��ַ,
   createtime�������ڣ�totalmoney��ÿ���˻��䶯�����ø��������
  cardid  pwd     username  phone    address createtime  totalmoney
   1      123456   ����    138888888  �Ϻ�     2016-1-1   1201
   create table bankInfor (
          cardid int primary key,--��������������Ϊ����������seq_bankinfor_id
          pwd char(6)  not null ,
          username varchar2(50) not null,--����
          phone varchar2(50) ,
          address varchar2(50),
          createtime date default sysdate,
          --���ʺ����,�������Ȼ�е���࣬��Ӧ����ƽ�������Ϊ�ͻ�����
          --���ѯ��Ϊ�˼ӿ��ѯ�ٶȡ�
          totalmoney number(8,2)    
   );
   create sequence seq_bankinfor_id start with 1;
   insert into bankInfor(cardid,pwd,Username,phone,address,Totalmoney)
   values(seq_bankinfor_id.nextval,'111111','����','13312345678','�Ϻ��ֶ�',1  );
   --��������ҵ����ˮ���κ�һ�ſ��������ʽ���붼�����¼
   create table bankAccountInfor(
          id int primary key,--���������У�����seq_bankaccountinfor_id
          cardid int not null ,--������������ʺ�
          money number(8,2) not null,--���������ת�룬����ת��
          opt varchar2(10) not null check (opt in('����','ת��','����','֧ȡ')),--��������
          opttime date default sysdate
   );
   alter table bankAccountInfor 
   add constraints fk_cardid foreign key (cardid) references bankInfor(cardid);
   create sequence seq_bankaccountinfor_id start with 1;
   insert into bankAccountInfor(id,cardid,money, opt)
   values(seq_bankaccountinfor_id.nextval,2,1,'����' );
      insert into bankAccountInfor(id,cardid,money, opt)
   values(seq_bankaccountinfor_id.nextval,2,1500,'����' );
      insert into bankAccountInfor(id,cardid,money, opt)
   values(seq_bankaccountinfor_id.nextval,2,-300,'֧ȡ' );
   update bankInfor set totalmoney=1201 where cardid=2
   
   select * from bankInfor;
select * from    bankAccountInfor
   commit;
  �����˻���ˮ�������������˻���ˮ��Ϣ��
  bankAccountInfor
   id ��ˮ�����������cardid���� money���  opt��������(���룬ת����ת�룬֧ȡ)  opttimte ��������
  id  cardid  money   opt    opttime
  1     1      1       ����   2016-1-1
  2     1      1500    ����   2016-5-5
  3     1      -300    ֧ȡ   2016-5-9
  =====================================================
    1.  ���п���Ҫ�������˻��ﱣ��1ԪǮ��
      дһ��PLSQL�飬��������
       ���뻧��,���룬���ֻ������ַ��
       declare
         v_rec bankinfor%rowtype;
       begin
         v_rec.username:='&�����뻧��';
         v_rec.pwd:='&����������';
         v_rec.phone:='&�������ֻ�����';
         v_rec.address:='&�������ַ';
  --�������˻� 
          insert into bankInfor(cardid,pwd,Username,phone,address,Totalmoney)
   values(seq_bankinfor_id.nextval,v_rec.pwd,v_rec.username,v_rec.phone,v_rec.address,1  );
      insert into bankAccountInfor(id,cardid,money, opt)
   values(seq_bankaccountinfor_id.nextval,seq_bankinfor_id.currval,1,'����' );
   commit;--û�����⣬�ύ
   dbms_output.put_line(v_rec.username||'���ã����Ŀ��Ѿ����ɣ�����Ϊ'||seq_bankinfor_id.currval);
   exception
       when others then 
         dbms_output.put_line(v_rec.username||'���ã�����ʧ��,ʧ�ܵ�ԭ����'||sqlerrm);
         rollback;--����ع�
   --�ٴ�����1Ԫ
       end;
       select * from bankinfor;
       select * from bankaccountinfor;
   -------------------------------------------------------------------------------------------------------------------
2.   дһ��PLSQL�飬������/ȡǮ����ע�⣬�����Ǵ��룬������ȡ��
        ���뿨�ţ������롣��ȡ���
    
declare
   v_rec bankinfor%rowtype;
   exceptionNoCard exception;--�������ڴ���
   excdptionPwdError exception ;--��������쳣
   noEnoughMoney  exception ;--�����쳣
   v_count int;--��ʱ���������������¼���������ж���
   v_totalmoney bankinfor.totalmoney%type;--������ʱ�����������õ��ʺ����
   v_str bankaccountinfor.opt%type;--��ʱ���������������������
begin
  v_rec.cardid:='&�����뿨��';
   v_rec.pwd:='&����������';
   --���ж����Ƿ���ڸÿ���
   select count(*) into v_count from  bankinfor where cardid=v_rec.cardid;
   if v_count!=1 then  --�������ڣ����׳��������ڵ��쳣
      raise exceptionNoCard; 
   end if;
   --������֤�¸ÿ��������Ƿ���ȷ
   select count(*)  into v_count from  bankinfor where cardid= v_rec.cardid and pwd=v_rec.pwd;
      if v_count!=1 then  --����������׳��������
      raise excdptionPwdError; 
   end if;
--���濪ʼ�����ȡ����
dbms_output.put_line('��ʼ��ȡǮ��������ע�⣺����Ϊ������Ϊȡ��');
v_rec.totalmoney:='&�������ȡ���';
 if v_rec.totalmoney>0 then 
   --�������Ǵ��ҵ��
  v_str:='����';     
 else
   --��������ȡ��ҵ��
   v_str:='֧ȡ';
 end if;
   --�Ȳ�����ˮ��  
      insert into bankAccountInfor(id,cardid,money, opt)
   values(seq_bankaccountinfor_id.nextval,v_rec.cardid,v_rec.totalmoney,v_str );
   --�ٸ����ʺ���Ϣ��
   update bankinfor set totalmoney=totalmoney+v_rec.totalmoney where cardid=v_rec.cardid;
   --���������û���쳣�����ύ��
   select totalmoney into  v_totalmoney from bankinfor  where cardid=v_rec.cardid;
   if v_totalmoney<1 then
     --�����ˣ������ύ���׳��쳣
     raise noEnoughMoney;
   end if;
   
   commit;
   --�ύ��Ϻ󣬸�����ʾ��Ϣ
   --��õ�ǰ���ŵ����

   
   if v_rec.totalmoney<0 then
     dbms_output.put_line('����ȡ������ɣ���������ȡ��'||v_rec.totalmoney||' �������Ϊ:'||v_totalmoney);
   else
          dbms_output.put_line('���Ĵ������ɣ������δ�����'||v_rec.totalmoney||' �������Ϊ:'||v_totalmoney);     
   end if;
--�쳣����
exception 
when exceptionNoCard then
     dbms_output.put_line('������Ŀ��Ų�����');
when excdptionPwdError then
     dbms_output.put_line('����������벻��ȷ');
   when noEnoughMoney then
     dbms_output.put_line('�������㣬�޷�֧ȡ');
     rollback;--�ع�����
when others then
      rollback;
        dbms_output.put_line(sqlerrm);
end;

select count(*) from  bankinfor where cardid=2 and pwd='111111'
       
  select seq_bankinfor_id.currval from dual;
  
  --------------------------------------------------------------------------------
  --sql ����дô��
  ����   ����    ���  �����ܶ�  --֧ȡ�ܶ� ת���ܶ�  ת���ܶ�
    1         ����    1701  4500
    select a.cardid,a.username,a.totalmoney as ���,�����ܶ�,
    nvl(֧ȡ�ܶ�,0) ֧ȡ�ܶ� from bankinfor a inner join (
     select cardid,sum(money) �����ܶ�   from bankaccountinfor where opt='����' group by cardid)
      b  on a.cardid=b.cardid
      left join (     
          select cardid,sum(money) ֧ȡ�ܶ�   from bankaccountinfor where opt='֧ȡ' group by cardid
          ) c on a.cardid=c.cardid
          
    ----------------------------------------------------------------------------------------------------
    
    
    
    
    
    
    
    
          
    
    
    
    
    
    
    
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
     
