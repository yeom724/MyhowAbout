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