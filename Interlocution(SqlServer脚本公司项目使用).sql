use TestOrca2
drop table WX_LikeCountRecord
drop table wx_QuestionOrAnswerAgain
drop table WX_Answer
drop table WX_Question
--问题表
create table WX_Question(
	PK int primary key identity(1,1) not null,			--主键列
	Title nvarchar(max) not null,						--问题标题
	Content nvarchar(max) not null,						--提问内容
	Associationpk int not null,							--社群外键
	UserID int not null REFERENCES xt_user(pk),			--提问用户 外键                            
	PublishTime datetime not null,						--提问时间                            
	IsDelete int default(0) not null,					--是否被删除 0:未删除 1:已删除 默认为0
	IsDisable int not null default(0),					--是否被禁用 0:未禁用 1:已禁用 默认为0
	IsStickie int not null default(0),					--是否处于置顶状态 0:未置顶 1:已置顶 默认为0
	ViewCount int default(0) not null,					--查看次数
)

--回答表
create table WX_Answer(
	PK int primary key identity(1,1) not null,			--主键列
	Content nvarchar(max) not null,						--内容
	UserID int not null REFERENCES xt_user(pk),			--回答用户 外键
	LikeCount int default(0) not null,					--点赞次数 
	PublishTime datetime not null,						--回答时间
	IsRight int default(0) not null,					--是否为最佳答案 0:非最佳答案 1:最佳答案 默认为0
	QuestionID int not null REFERENCES WX_Question(PK),	--外键列 所属问题
)

--追问追答表
create table WX_QuestionOrAnswerAgain(
	PK int primary key identity(1,1) not null,			--主键列
	Content nvarchar(max) not null,						--追问或追答内容
	UserId int not null REFERENCES xt_user(pk),			--追问或追答用户 外键
	ContentIndex int not null,							--追问或追答下标
	PublishTime datetime not null,						--追问或追答时间
	ContentType int not null,							--内容类型 0:追问 1:追答
	QuestionID int not null REFERENCES WX_Question(PK),	--外键列 所属问题
	AnswerId int not null REFERENCES WX_Answer(PK),	    --外键列 所属回答
	IsRight int default(0) not null,					--是否为最佳答案 0:表示非最佳答案 1:表示为最佳答案
)

--点赞记录表
create table WX_LikeCountRecord(
	PK int primary key identity(1,1) not null,			--主键列
	UserId int not null REFERENCES xt_user(pk),			--点赞用户 外键
	QuestionId int not null REFERENCES WX_Question(pk),--外键列 所属问题
	AnswerId int not null REFERENCES WX_Answer(PK),	    --外键列 所属回答
)

--插入问题表数据
insert into WX_Question values('css如何把图片圆形?','一般的照片都是方形的，有什么办法可以让照片在显示的时候显示成圆角呢？',1,4512,GETDATE(),0,0,0,0)
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

--插入回答表数据
insert into WX_Answer values('使用css让图片显示圆角，首先需要理解，一般图片都是用一个div包裹，不一定要直接去改图片，可以去直接改包裹图片的div，圆角的话，是需要使用css3才能实现的border-radius来实现的，border-radius:5px 15px 20px 25px;顺序依次是上右下左',5783,0,GETDATE(),0,1)
insert into WX_Answer values('border-radius: 10px;',6203,0,GETDATE(),0,1)
insert into WX_Answer values('css3的新属性：border-radius比较旧版本的IE不支持，，不过可以通过一个HTML5.js来弥补。。。',4512,0,GETDATE(),0,1)
insert into WX_Answer values('border-radius:5px;但是IE不支持这个属性，所以现在一般的做法是做一张圆角的背景图片',1,0,GETDATE(),0,1)
insert into WX_Answer values('设置弯曲程度，当然也可以分别设置；比如只设置左下角：border-bottom-left-radius:10px;border-radius:10px;',6354,0,GETDATE(),0,1)
insert into WX_Answer values('设置弯曲程度，当然也可以分别设置；比如只设置左下角：border-bottom-left-radius:10px;border-radius:10px;',6354,0,GETDATE(),1,1)
insert into WX_Answer values('设置弯曲程度，当然也可以分别设置；比如只设置左下角：border-bottom-left-radius:10px;border-radius:10px;',6354,0,GETDATE(),1,1)



--插入追问追答测试数据
insert into WX_QuestionOrAnswerAgain values('你说的我还是没有明白，请问css在哪下载啊?',4512,1,GETDATE(),0,1,1,0)
insert into WX_QuestionOrAnswerAgain values('看守所里面比家里好多了，里面个个都是人才，说话有好听，哎，超喜欢',5783,1,GETDATE(),1,1,1,0)
insert into WX_QuestionOrAnswerAgain values('你说的我还是没有明白，请问css在哪下载啊?',4512,2,GETDATE(),0,1,1,0)
insert into WX_QuestionOrAnswerAgain values('看守所里面比家里好多了，里面个个都是人才，说话有好听，哎，超喜欢',5783,2,GETDATE(),1,1,1,0)





--获取头像列表
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