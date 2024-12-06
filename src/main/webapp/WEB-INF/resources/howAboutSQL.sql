create database howAbout;
use howAbout;

create table aboutMember(
	userName varchar(10) ,
    userId varchar(20) primary key,
    userPw varchar(20),
    userTel char(12),
    userAddr varchar(100),
    userDate char(10)
);

drop table aboutMember;
select * from aboutMember;

create table schedule_db(
	schedule_id bigint,
    schedule_date char(11),
    schedule_record text,
    weather text
);

insert into schedule_db value(12312312412, '2024-12-01', 'asdfasdfasdfasd', '날');
select * from schedule_db;

create table aboutReview(
	userId varchar(20),
    reviewText varchar(500),
    reviewDate char(10),
    millisId bigint primary key,
    foreign key (userId) references aboutMember(userId) on delete cascade
);

ALTER TABLE aboutPlace
ADD COLUMN updateNum INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE aboutPlace
ADD COLUMN mainMenu varchar(50);

drop table aboutReview;
select * from aboutReview;

create table aboutPlace(
	juso text,
    jibun text,
    category varchar(20),
    title varchar(50),
    status varchar(10),
    foodCategory varchar(20),
    latitude double,
    longitude double,
    updateNum INT AUTO_INCREMENT PRIMARY KEY
);
select count(*) from aboutPlace where category='숙박업' or category='일반야영장업';
select * from aboutPlace limit 3343;
select * from aboutPlace where juso LIKE "%마산합포구 삼호로 35 (산호동)";
select distinct category from aboutPlace;
select distinct foodCategory from aboutPlace;
select * from aboutPlace where category="모범음식점";
select * from aboutPlace where title="수장고";

select count(*) from aboutPlace;
select count(*) from aboutPlace;

update aboutPlace set foodCategory="일반음식점" where foodCategory IN ('일반조리판매','기타 휴게음식점','고속도로','백화점','일식','한식','탕류(보신용)','복어취급','중국식','외국음식전문점(인도,태국등)','기타','식육(숯불구이)','패스트푸드','패밀리레스트랑','경양식','통닭(치킨)','');

select * from aboutPlace where juso="abc";
select count(*) from aboutPlace where CAST(latitude AS CHAR) LIKE '35.1951%' AND CAST(longitude AS CHAR) LIKE '128.1153%';

select count(*) from aboutPlace;
-- drop table aboutPlace;

delete from aboutPlace where jibun='경상남도 창원시 마산회원구 양덕로 160';

SELECT YEAR(STR_TO_DATE(userDate, '%Y/%m/%d')) AS year, MONTH(STR_TO_DATE(userDate, '%Y/%m/%d')) AS month FROM aboutMember;
