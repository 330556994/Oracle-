1.
  银行账户信息表
 bankInfor
   cardId卡号自增长,pwd 密码，username户名,phone手机号码,address地址,
   createtime开户日期，totalmoney余额（每次账户变动，都得更新这个余额）
  cardid  pwd     username  phone    address createtime  totalmoney
   1      123456   张三    138888888  上海     2016-1-1   1201
   create table bankInfor (
          cardid int primary key,--已自增长的列作为主键，序列seq_bankinfor_id
          pwd char(6)  not null ,
          username varchar2(50) not null,--户名
          phone varchar2(50) ,
          address varchar2(50),
          createtime date default sysdate,
          --该帐号余额,这个列虽然有点多余，但应该设计进来，因为客户大量
          --会查询余额，为了加快查询速度。
          totalmoney number(8,2)    
   );
   create sequence seq_bankinfor_id start with 1;
   insert into bankInfor(cardid,pwd,Username,phone,address,Totalmoney)
   values(seq_bankinfor_id.nextval,'111111','张三','13312345678','上海浦东',1  );
   --这是银行业务流水表，任何一张卡的所有资金出入都必须记录
   create table bankAccountInfor(
          id int primary key,--自增长的列，序列seq_bankaccountinfor_id
          cardid int not null ,--外键，所属主帐号
          money number(8,2) not null,--如果是正则转入，负则转出
          opt varchar2(10) not null check (opt in('存入','转出','传入','支取')),--操作类型
          opttime date default sysdate
   );
   alter table bankAccountInfor 
   add constraints fk_cardid foreign key (cardid) references bankInfor(cardid);
   create sequence seq_bankaccountinfor_id start with 1;
   insert into bankAccountInfor(id,cardid,money, opt)
   values(seq_bankaccountinfor_id.nextval,2,1,'存入' );
      insert into bankAccountInfor(id,cardid,money, opt)
   values(seq_bankaccountinfor_id.nextval,2,1500,'存入' );
      insert into bankAccountInfor(id,cardid,money, opt)
   values(seq_bankaccountinfor_id.nextval,2,-300,'支取' );
   update bankInfor set totalmoney=1201 where cardid=2
   
   select * from bankInfor;
select * from    bankAccountInfor
   commit;
  银行账户流水表（这里存放所有账户流水信息）
  bankAccountInfor
   id 流水序号自增长，cardid卡号 money金额  opt操作类型(存入，转出，转入，支取)  opttimte 操作日期
  id  cardid  money   opt    opttime
  1     1      1       存入   2016-1-1
  2     1      1500    存入   2016-5-5
  3     1      -300    支取   2016-5-9
  =====================================================
    1.  银行开户要求，至少账户里保存1元钱。
      写一个PLSQL块，用来开户
       输入户名,密码，和手机号码地址。
       declare
         v_rec bankinfor%rowtype;
       begin
         v_rec.username:='&请输入户名';
         v_rec.pwd:='&请输入密码';
         v_rec.phone:='&请输入手机号码';
         v_rec.address:='&请输入地址';
  --创建主账户 
          insert into bankInfor(cardid,pwd,Username,phone,address,Totalmoney)
   values(seq_bankinfor_id.nextval,v_rec.pwd,v_rec.username,v_rec.phone,v_rec.address,1  );
      insert into bankAccountInfor(id,cardid,money, opt)
   values(seq_bankaccountinfor_id.nextval,seq_bankinfor_id.currval,1,'存入' );
   commit;--没有问题，提交
   dbms_output.put_line(v_rec.username||'您好，您的卡已经生成，卡号为'||seq_bankinfor_id.currval);
   exception
       when others then 
         dbms_output.put_line(v_rec.username||'您好，开卡失败,失败的原因是'||sqlerrm);
         rollback;--事务回滚
   --再存入金额1元
       end;
       select * from bankinfor;
       select * from bankaccountinfor;
   -------------------------------------------------------------------------------------------------------------------
2.   写一个PLSQL块，用来存/取钱。（注意，正数是存入，负数是取）
        输入卡号，和密码。存取入金额。
    
declare
   v_rec bankinfor%rowtype;
   exceptionNoCard exception;--卡不存在错误
   excdptionPwdError exception ;--密码错误异常
   noEnoughMoney  exception ;--余额不足异常
   v_count int;--临时变量，用来保存记录总数，做判断用
   v_totalmoney bankinfor.totalmoney%type;--定义临时变量，用来得到帐号余额
   v_str bankaccountinfor.opt%type;--临时变量，用来保存操作类型
begin
  v_rec.cardid:='&请输入卡号';
   v_rec.pwd:='&请输入密码';
   --先判断下是否存在该卡号
   select count(*) into v_count from  bankinfor where cardid=v_rec.cardid;
   if v_count!=1 then  --卡不存在，则抛出卡不存在的异常
      raise exceptionNoCard; 
   end if;
   --下面验证下该卡的密码是否正确
   select count(*)  into v_count from  bankinfor where cardid= v_rec.cardid and pwd=v_rec.pwd;
      if v_count!=1 then  --密码错误，则抛出密码错误
      raise excdptionPwdError; 
   end if;
--下面开始处理存取操作
dbms_output.put_line('开始存取钱，操作，注意：正数为存款，负数为取款');
v_rec.totalmoney:='&请输入存取金额';
 if v_rec.totalmoney>0 then 
   --正数就是存款业务
  v_str:='存入';     
 else
   --负数就是取款业务
   v_str:='支取';
 end if;
   --先插入流水表  
      insert into bankAccountInfor(id,cardid,money, opt)
   values(seq_bankaccountinfor_id.nextval,v_rec.cardid,v_rec.totalmoney,v_str );
   --再更新帐号信息表
   update bankinfor set totalmoney=totalmoney+v_rec.totalmoney where cardid=v_rec.cardid;
   --如果到这里没有异常，则提交。
   select totalmoney into  v_totalmoney from bankinfor  where cardid=v_rec.cardid;
   if v_totalmoney<1 then
     --余额不足了，不能提交，抛出异常
     raise noEnoughMoney;
   end if;
   
   commit;
   --提交完毕后，给出提示信息
   --获得当前卡号的余额

   
   if v_rec.totalmoney<0 then
     dbms_output.put_line('您的取款已完成，您本次提取了'||v_rec.totalmoney||' 您的余额为:'||v_totalmoney);
   else
          dbms_output.put_line('您的存款已完成，您本次存入了'||v_rec.totalmoney||' 您的余额为:'||v_totalmoney);     
   end if;
--异常处理
exception 
when exceptionNoCard then
     dbms_output.put_line('您输入的卡号不存在');
when excdptionPwdError then
     dbms_output.put_line('您输入的密码不正确');
   when noEnoughMoney then
     dbms_output.put_line('您的余额不足，无法支取');
     rollback;--回滚事务
when others then
      rollback;
        dbms_output.put_line(sqlerrm);
end;

select count(*) from  bankinfor where cardid=2 and pwd='111111'
       
  select seq_bankinfor_id.currval from dual;
  
  --------------------------------------------------------------------------------
  --sql 语句会写么？
  卡号   户名    余额  存入总额  --支取总额 转入总额  转出总额
    1         张三    1701  4500
    select a.cardid,a.username,a.totalmoney as 余额,存入总额,
    nvl(支取总额,0) 支取总额 from bankinfor a inner join (
     select cardid,sum(money) 存入总额   from bankaccountinfor where opt='存入' group by cardid)
      b  on a.cardid=b.cardid
      left join (     
          select cardid,sum(money) 支取总额   from bankaccountinfor where opt='支取' group by cardid
          ) c on a.cardid=c.cardid
          
    ----------------------------------------------------------------------------------------------------
    
    
    
    
    
    
    
    
          
    
    
    
    
    
    
    
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
     
