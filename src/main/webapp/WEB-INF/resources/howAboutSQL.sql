create database howAbout;
use howAbout;

create table aboutMember(
	userName varchar(10) ,
    userId varchar(20) primary key,
    userPw varchar(20),
    userTel char(12),
    userAddr varchar(100),
    userDate char(10),
    userEamil varchar(100) unique,
    enabled boolean
);

alter table aboutMember change userEamil userEmail varchar(100) unique;

CREATE TABLE email_tokens (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NOT NULL
);

drop table aboutMember;
drop table aboutReview;
select * from aboutMember;
delete from aboutMember;

update aboutMember set enabled=true where userId="admin";

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

create table Place(
	addressName text,
    roadAddress text,
    placeName text,
    category text,
    categoryAll text,
    phone text,
    placeUrl text,
    placeID varchar(30) primary key,
    longitude text,
    latitude text
);

create table PlaceTime(
	placeID varchar(30),
    num int auto_increment primary key,
    worktime text,
    foreign key (placeID) references Place(placeID)
);

create table PlaceMenu(
	placeID varchar(30),
    num int auto_increment primary key,
    menuName text,
    menuPrice text,
    foreign key (placeID) references Place(placeID)
);

select * from place limit 20000;
select * from placetime;
select * from placemenu;
drop table place;
drop table placetime;
drop table placemenu;


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
select * from aboutPlace where updateNum='2';

select count(*) from aboutPlace;
select * from aboutPlace;

select * from aboutPlace where updateNum=4;

update aboutPlace set foodCategory="일반음식점" where foodCategory IN ('일반조리판매','기타 휴게음식점','고속도로','백화점','일식','한식','탕류(보신용)','복어취급','중국식','외국음식전문점(인도,태국등)','기타','식육(숯불구이)','패스트푸드','패밀리레스트랑','경양식','통닭(치킨)','');

select * from aboutPlace where juso="abc";
select count(*) from aboutPlace where CAST(latitude AS CHAR) LIKE '35.2193%' AND CAST(longitude AS CHAR) LIKE '128.6752%';

select count(*) from aboutPlace;
-- drop table aboutPlace;

delete from aboutPlace where jibun='경상남도 창원시 마산회원구 양덕로 160';

SELECT YEAR(STR_TO_DATE(userDate, '%Y/%m/%d')) AS year, MONTH(STR_TO_DATE(userDate, '%Y/%m/%d')) AS month FROM aboutMember;
