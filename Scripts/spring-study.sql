select user(), database();

create database book_spring;
use book_spring;

create table tbl_member(
	userid varchar(50) not null,
	userpw varchar(50) not null,
	username varchar(50) not null,
	email varchar(100),
	regdate timestamp default now(),
	updatedate timestamp default now(),
	primary key(userid)
);

desc tbl_member;
select * from tbl_member;

update tbl_member set userpw = '123123', username = '유', email = 'yoo@test.com' where userid = 'yoogj0513';
delete from tbl_member where userid = 'yoogj0513';

-- 
use book_spring;
select user(), database();

create table tbl_board(
	bno int not null auto_increment,
	title varchar(200) not null,
	content text null,
	writer varchar(50) not null,
	regdate timestamp not null default now(),
	viewcnt int default 0,
	primary key(bno)
);

desc tbl_board;
select * from tbl_board order by bno desc;

update tbl_board
			set viewcnt = 0
			where bno = 6;
			
		
-- 댓글 db
select user(), database();
use book_spring;

create table tbl_reply(
	rno int not null auto_increment,
	bno int not null default 0,
	replytext varchar(1000) not null,
	replyer varchar(50) not null,
	regdate timestamp not null default now(),
	updatedate timestamp not null default now(),
	primary key (rno)
);

alter table tbl_reply add constraint fk_board
foreign key(bno) references tbl_board(bno);

desc tbl_reply;
select * from tbl_reply;
		
select count(rno) from tbl_reply where bno = 4098;