create database howAbout;
use howAbout;

create table aboutMember(
	userName varchar(10),
    userId varchar(20) primary key,
    userPw varchar(20),
    userTel char(12),
    userAddr varchar(100),
    userDate char(10)
);

drop table aboutMember;
select * from aboutMember;

create table aboutReview(
	userId varchar(20),
    reviewText varchar(500),
    reviewDate char(10),
    millisId bigint primary key,
    foreign key (userId) references aboutMember(userId) on delete cascade
);

drop table aboutReview;
select * from aboutReview;
