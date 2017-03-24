use TestOrca2
drop table WX_LikeCountRecord
drop table wx_QuestionOrAnswerAgain
drop table WX_Answer
drop table WX_Question
--�����
create table WX_Question(
	PK int primary key identity(1,1) not null,			--������
	Title nvarchar(max) not null,						--�������
	Content nvarchar(max) not null,						--��������
	Associationpk int not null,							--��Ⱥ���
	UserID int not null REFERENCES xt_user(pk),			--�����û� ���                            
	PublishTime datetime not null,						--����ʱ��                            
	IsDelete int default(0) not null,					--�Ƿ�ɾ�� 0:δɾ�� 1:��ɾ�� Ĭ��Ϊ0
	IsDisable int not null default(0),					--�Ƿ񱻽��� 0:δ���� 1:�ѽ��� Ĭ��Ϊ0
	IsStickie int not null default(0),					--�Ƿ����ö�״̬ 0:δ�ö� 1:���ö� Ĭ��Ϊ0
	ViewCount int default(0) not null,					--�鿴����
)

--�ش��
create table WX_Answer(
	PK int primary key identity(1,1) not null,			--������
	Content nvarchar(max) not null,						--����
	UserID int not null REFERENCES xt_user(pk),			--�ش��û� ���
	LikeCount int default(0) not null,					--���޴��� 
	PublishTime datetime not null,						--�ش�ʱ��
	IsRight int default(0) not null,					--�Ƿ�Ϊ��Ѵ� 0:����Ѵ� 1:��Ѵ� Ĭ��Ϊ0
	QuestionID int not null REFERENCES WX_Question(PK),	--����� ��������
)

--׷��׷���
create table WX_QuestionOrAnswerAgain(
	PK int primary key identity(1,1) not null,			--������
	Content nvarchar(max) not null,						--׷�ʻ�׷������
	UserId int not null REFERENCES xt_user(pk),			--׷�ʻ�׷���û� ���
	ContentIndex int not null,							--׷�ʻ�׷���±�
	PublishTime datetime not null,						--׷�ʻ�׷��ʱ��
	ContentType int not null,							--�������� 0:׷�� 1:׷��
	QuestionID int not null REFERENCES WX_Question(PK),	--����� ��������
	AnswerId int not null REFERENCES WX_Answer(PK),	    --����� �����ش�
	IsRight int default(0) not null,					--�Ƿ�Ϊ��Ѵ� 0:��ʾ����Ѵ� 1:��ʾΪ��Ѵ�
)

--���޼�¼��
create table WX_LikeCountRecord(
	PK int primary key identity(1,1) not null,			--������
	UserId int not null REFERENCES xt_user(pk),			--�����û� ���
	QuestionId int not null REFERENCES WX_Question(pk),--����� ��������
	AnswerId int not null REFERENCES WX_Answer(PK),	    --����� �����ش�
)

--�������������
insert into WX_Question values('css��ΰ�ͼƬԲ��?','һ�����Ƭ���Ƿ��εģ���ʲô�취��������Ƭ����ʾ��ʱ����ʾ��Բ���أ�',1,4512,GETDATE(),0,0,0,0)
insert into WX_Question values('where are you come from?','How to ask people where they come from, and say where you come from.languages, try the Phrase Finder.',1,1,GETDATE(),0,0,0,0)
insert into WX_Question values('Do you sometimes use them?','I have a pager. It helps me get messages. But its only one-way communication. Compared to the mobile phones many of my friends and classmates are using, a pager looks rather out-dated. So Im thinking of buying a mobile phone to keep up with the trend',1,1,GETDATE(),0,0,0,0)
insert into WX_Question values('What are good telephone manners? ',' I will do one thing at a time and do it well in a most efficient manner. This way I will be able to meet the demand of my part-time job and to find sufficient time for my studies. ',1,1,GETDATE(),0,0,0,0)
insert into WX_Question values('Are you interested in name-brand products? Why or why not? ','My father, on the other hand, is a very careless shopper. He has quite a few experiences of being cheated by street peddlers. If you are interested and when you have time, I will tell you some of their shopping stories. ',1,1,GETDATE(),0,0,0,0)
insert into WX_Question values('Have you ever had / heard of an interesting / unpleasant shopping experience? ','Im interested in certain name brands and products under such brands. A name brand is usually a symbol of quality and value. Nike, Coca Cola and Motorola, to name a few, are such brand names. When you buy a product, you would want better quality and more value for your money. The easiest way to be sure you will have them is to choose a brand name. ',1,1,GETDATE(),0,0,0,0)
insert into WX_Question values('What do you like about your apartment / room? ','How to ask people where they come from, and say where you come from.',1,1,GETDATE(),0,0,0,0)
insert into WX_Question values('What kind of student accommodation does your college offer?','How to ask people where they come from, and say where you come from.',1,1,GETDATE(),0,0,0,0)
insert into WX_Question values('What is small talk? Are you good at it? ','How to ask people where they come from, and say where you come from.',1,1,GETDATE(),0,0,0,0)
insert into WX_Question values(' If you see somebody you really fancy, what would you do? ','How to ask people where they come from, and say where you come from.',1,1,GETDATE(),0,0,0,0)
insert into WX_Question values('What makes a really good party? ','How to ask people where they come from, and say where you come from.',1,1,GETDATE(),0,0,0,0)
insert into WX_Question values('How many kinds of phones are available today? What are they? ','How to ask people where they come from, and say where you come from.',1,1,GETDATE(),0,0,1,0)

--����ش������
insert into WX_Answer values('ʹ��css��ͼƬ��ʾԲ�ǣ�������Ҫ��⣬һ��ͼƬ������һ��div��������һ��Ҫֱ��ȥ��ͼƬ������ȥֱ�Ӹİ���ͼƬ��div��Բ�ǵĻ�������Ҫʹ��css3����ʵ�ֵ�border-radius��ʵ�ֵģ�border-radius:5px 15px 20px 25px;˳����������������',5783,0,GETDATE(),0,1)
insert into WX_Answer values('border-radius: 10px;',6203,0,GETDATE(),0,1)
insert into WX_Answer values('css3�������ԣ�border-radius�ȽϾɰ汾��IE��֧�֣�����������ͨ��һ��HTML5.js���ֲ�������',4512,0,GETDATE(),0,1)
insert into WX_Answer values('border-radius:5px;����IE��֧��������ԣ���������һ�����������һ��Բ�ǵı���ͼƬ',1,0,GETDATE(),0,1)
insert into WX_Answer values('���������̶ȣ���ȻҲ���Էֱ����ã�����ֻ�������½ǣ�border-bottom-left-radius:10px;border-radius:10px;',6354,0,GETDATE(),0,1)
insert into WX_Answer values('���������̶ȣ���ȻҲ���Էֱ����ã�����ֻ�������½ǣ�border-bottom-left-radius:10px;border-radius:10px;',6354,0,GETDATE(),1,1)
insert into WX_Answer values('���������̶ȣ���ȻҲ���Էֱ����ã�����ֻ�������½ǣ�border-bottom-left-radius:10px;border-radius:10px;',6354,0,GETDATE(),1,1)



--����׷��׷���������
insert into WX_QuestionOrAnswerAgain values('��˵���һ���û�����ף�����css�������ذ�?',4512,1,GETDATE(),0,1,1,0)
insert into WX_QuestionOrAnswerAgain values('����������ȼ���ö��ˣ�������������˲ţ�˵���к�����������ϲ��',5783,1,GETDATE(),1,1,1,0)
insert into WX_QuestionOrAnswerAgain values('��˵���һ���û�����ף�����css�������ذ�?',4512,2,GETDATE(),0,1,1,0)
insert into WX_QuestionOrAnswerAgain values('����������ȼ���ö��ˣ�������������˲ţ�˵���к�����������ϲ��',5783,2,GETDATE(),1,1,1,0)





--��ȡͷ���б�
select xp.LargePK,xu.PK from XT_USER xu Inner join XT_PROFILE xp on xp.UserID = xu.USERID 


select wqa.*,CONVERT(varchar(100), wqa.publishtime, 120) convertwqapublishtime,xu.userid xuuserid,xp.LargePK xplargepk from WX_QuestionOrAnswerAgain wqa inner join xt_user xu on xu.pk=wqa.userid left join XT_PROFILE xp on xp.UserID = xu.USERID where wqa.QuestionID=1 and wqa.AnswerID=1



select wa.pk wapk,wa.content wacontent,wa.likecount,CONVERT(varchar(100), wa.publishtime, 120) convertwapublishtime, wa.isright waIsRight,wq.pk wqpk,xu.USERID xuuserid,xp.LargePK xplargepk 
      from wx_question wq left join WX_Answer wa on  wq.pk = wa.questionid left join XT_USER xu on xu.pk=wa.userid left join XT_PROFILE xp on xp.UserID = xu.USERID  
      where wq.pk=1 order by wapk
      
      
      update WX_Answer set likecount = likecount + 1 where pk =1
      
      select * from wx_question where isstickie = 1
      update wx_question set isstickie=0 where isstickie = 1
      
      select wq.*,CONVERT(varchar(100), wq.publishtime, 120) convertwqpublishtime,xu.userid xuuserid,xp.LargePK xplargepk
      from wx_question wq inner join XT_USER xu on xu.pk=wq.userid left join XT_PROFILE xp on xp.UserID = xu.USERID 
      where 1 is null or wq.pk=1 and  css null or wq.title like '%css%'
      
      
        select wq.*,xu.userid xuuserid,xp.LargePK xplargepk from wx_question wq inner join XT_USER xu on xu.pk=wq.userid left join XT_PROFILE xp on xp.UserID = xu.USERID 
delete from wx_question where pk = 4

select * from wx_question

select * from wx_answer 

select * from WX_LikeCountRecord

select COUNT(1) from WX_LikeCountRecord where AnswerId = 4 and UserId=1

select * from WX_QuestionOrAnswerAgain

delete from WX_QuestionOrAnswerAgain where AnswerId = 1


insert into WX_Question values('What is small talk? Are you good at it? ','How to ask people where they come from, and say where you come from.',2,1,GETDATE(),0,0,0,0)
update wx_question set isdisable = 0
  
   select wq.*,CONVERT(varchar(100), wq.publishtime, 120) convertwqpublishtime,xu.userid xuuserid,xp.LargePK xplargepk
      from wx_question wq inner join XT_USER xu on xu.pk=wq.userid left join XT_PROFILE xp on xp.UserID = xu.USERID 
      where  (wq.pk=1)
      
      select COUNT(1) from wx_answer where wx_answer.questionid=1
      
      select wa.pk wapk,wa.content wacontent,wa.likecount,CONVERT(varchar(100), wa.publishtime, 120) convertwapublishtime, wa.isright waIsRight,wq.pk wqpk,xu.USERID xuuserid,xp.LargePK xplargepk 
      from wx_question wq left join WX_Answer wa on  wq.pk = wa.questionid left join XT_USER xu on xu.pk=wa.userid left join XT_PROFILE xp on xp.UserID = xu.USERID 
      where wq.pk=1 order by wapk
    
    
    delete from WX_LikeCountRecord where AnswerId = 1
    delete from WX_QuestionOrAnswerAgain where AnswerId = 1
     delete from WX_Answer where pk = 1