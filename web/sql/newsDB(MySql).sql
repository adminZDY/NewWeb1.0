use sys;

#创建数据库，如果存在则删除
# drop database if exists newdb;
#如果不存在数据库，则创建
create database if not exists newsDB;
use newsDB;

#表存在则删除
drop table if exists userInfo;

# 用户信息表
create table if not exists userInfo
(
    #用户编号
	userId int not null  primary key,
	#用户名（唯一）
	userName varchar(20) not null unique,
	#密码(登录密码)
	password varchar(20) not null
);

#表存在则删除
drop table if exists newsTypeInfo;

#新闻类型表
create table if not exists newsTypeInfo
(
	#类型编号
	typeId int not null auto_increment primary key,
	#类型名称（唯一）
	typeName varchar(20) not null unique,
	#类型备注（可为空）
	remark varchar(50) null
);

drop table if exists newsInfo;

#新闻信息表
create table if not exists newsInfo
(
	#新闻编号
	newsId int not null auto_increment primary key,
	#新闻类型（外键）
	typeId int not null,
	#新闻发表者（外键）
	userId int not null,
	#新闻标题
	title varchar(40) not null,
	#新闻内容
	content text not null,
	#是否推荐新闻（0不推荐，1推荐），默认为0
	recommended int not null default(0),
	#新闻点击次数，默认为0
	click int not null default(0),
	#新闻发布时间，默认为当前时间
	releaseTime Date not null default(curdate()),
	#新闻关键字
	keywords varchar(20) not null,
    FOREIGN KEY(typeId) REFERENCES newsTypeInfo(typeId),
    FOREIGN KEY(userId) REFERENCES userInfo(userId)
);



#添加用户
insert into userInfo values('test','123456');
insert into userInfo values('admin','123456');

#添加类型
insert into newsTypeInfo values('学院新闻','关于学院内部的新闻');
insert into newsTypeInfo values('行业新闻','关于IT行业的新闻');
insert into newsTypeInfo values('就业新闻','关于学院学员的新闻');
insert into newsTypeInfo values('其他新闻','与学员有关的其他新闻');
insert into newsTypeInfo values('学员生活','发布学员在学习生活的相关新闻');
insert into newsTypeInfo values('学院','关于学院内部的新闻');
insert into newsTypeInfo values('行业','关于IT行业的新闻');
insert into newsTypeInfo values('就业','关于学院学员的新闻');
insert into newsTypeInfo values('其他','与学员有关的其他新闻');
insert into newsTypeInfo values('生活','发布学员在学习生活的相关新闻');
insert into newsTypeInfo values('新闻','关于学院内部的新闻');
insert into newsTypeInfo values('行','关于IT行业的新闻');
insert into newsTypeInfo values('就','关于学院学员的新闻');
insert into newsTypeInfo values('其','与学员有关的其他新闻');
insert into newsTypeInfo values('学','发布学员在学习生活的相关新闻');

#添加新闻
insert into newsInfo (typeId,userId,title,content,keywords)
values(2,2,'我们准备进入"物联网时代吗？','不要以为物','物联网，互联网');

insert into newsInfo (typeId,userId,title,content,recommended,keywords)
values(1,2,'传媒对大学校园报道议题研究','近年来，传媒',1,'学员，传媒');

insert into newsInfo (typeId,userId,title,content,keywords)
values(1,2,'我校召开第二次领导干部培训学习会','4月12日晚，...','培训，管理');

insert into newsInfo (typeId,userId,title,content,keywords)
values(1,2,'党报护花花锦绣-东宅中学校园新闻','校园文化建设','治理，改革');

insert into newsInfo (typeId,userId,title,content,keywords)
values(1,2,'我院针对外包而持续开办日语课程','今年我院课程','外包，日语');

insert into newsInfo (typeId,userId,title,content,keywords)
values(1,2,'获市企业维权会副理事长单位','重庆市各界企业','维权，协会');

insert into newsInfo (typeId,userId,title,content,keywords)
values(1,2,'李老师接受重庆日报专访','李老师正式','董事长，专访，媒体');

insert into newsInfo (typeId,userId,title,content,keywords)
values(5,2,'惠普篮球赛总决赛季军争多战报道','今天的篮球总决赛','惠普，篮球，决赛');

#新闻类型

select * from userInfo;
select * from newsTypeInfo where typeId = 1;
update newsTypeInfo set typeName ='',remark = '' where typeId = 1;

#新闻
#insert into newsInfo(typeId,userId,title,content,keywords) values(,,'','','')

select * from newsInfo;

select * from newsInfo where newsId = 1;

