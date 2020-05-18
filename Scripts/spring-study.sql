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

-- 댓글 수
alter table tbl_board add column replycnt int default 0;
desc tbl_board;
select * from tbl_board;

update tbl_board set replycnt = (
	select count(rno) from tbl_reply 
	where bno = tbl_board.bno
);


select * from tbl_board order by bno desc limit 0, 10;
		
select count(*) from book_spring.tbl_reply where bno = 4098;
	
-- 파일 테이블
create table tbl_attach(
	fullName varchar(150) not null,
	bno int not null,
	regdate timestamp default now(),
	primary key(fullName)
);

alter table tbl_attach add constraint fk_board_attach
foreign key (bno) references tbl_board(bno);

select * from tbl_attach;

select * from tbl_board order by bno desc;
select * from tbl_reply where bno = 4106;

select * 
	from tbl_board b left join tbl_attach a on b.bno = a.bno 
	where b.bno = 4104;

select * from tbl_attach where bno = 4101 and `fullName` = '/2020/05/04/s_2f279607-0de4-459a-9471-7f5dccf30955_날마다 천체 물리.jpg'
		
delete 
	from tbl_attach 
	where bno = 4101 and `fullName` = '/2020/05/04/s_2f279607-0de4-459a-9471-7f5dccf30955_날마다 천체 물리.jpg';
		
		

