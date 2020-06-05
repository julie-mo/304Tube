/************************************************** 
		C R E A T E   T A B L E 
 **************************************************/

-- User
create table users (
userid serial primary key,
username varchar(20) unique not null,
password varchar(20) not null,
phonenumber char(12),
emailaddress varchar(50) unique
);

-- Payment Information
create table paymentinformationown (
userid integer not null,
creditcardnumber char(16) primary key,
billingaddress varchar(50),
expirydate char(4),
cvcode char(3),
foreign key(userid) references users (userid)
on delete cascade
on update cascade
); 


-- Video Upload
create table videoupload (
videoid serial primary key,
userid integer,
videoname varchar(80),
videolength time,
videogenre varchar(15),
foreign key(userid) references users (userid)
on delete set null
on update cascade
);

-- Current Session
create table currentsession (
sessionid char(10) primary key,
userid integer not null,
videoid integer not null,
timestampid time not null,
foreign key (userid) references users (userid)
on delete cascade
on update cascade,
foreign key(videoid) references videoupload(videoid)
on delete cascade
on update cascade
);

-- List Create
create table listcreate (
listid integer primary key,
userid integer not null,
listname varchar(20),
foreign key (userid) references users (userid)
on delete cascade
on update cascade
);

-- Report Create
create table reportcreate (
reportid serial primary key,
userid integer not null,
status varchar(8) not null default 'pending',
decision varchar(20),
reportdate date not null,
reason varchar(200),
foreign key (userid) references users (userid)
on delete cascade
on update cascade
);

-- Platform Admin
create table platformadmin (
adminid serial primary key,
reportcount integer,
name varchar(40)
);

-- Company
create table company (
companyid serial primary key,
companyname varchar(50)
);

-- Report Review
create table reportreview (
reportid integer not null unique,
adminid integer,
primary key(reportid, adminid),
foreign key(adminid) references platformadmin (adminid),
foreign key(reportid) references reportcreate(reportid)
);


-- Watch
create table watch (
userid integer,
videoid integer,
sessionid char(10),
primary key(userid, videoid, sessionid),
foreign key(userid) references users(userid)
on delete cascade
on update cascade,
foreign key(videoid) references videoupload(videoid)
on delete cascade
on update cascade,
foreign key(sessionid) references currentsession(sessionid)
on delete cascade
on update cascade
);

-- ListVideo
create table listvideo (
listid integer,
videoid integer,
primary key (listid, videoid),
foreign key (listid) references listcreate(listid)
on delete cascade
on update cascade,
foreign key (videoid) references videoupload(videoid)
on delete cascade
on update cascade
);


-- Advertisementprovide
create table advertisementprovide (
adid integer unique,
companyid integer,
adlength time,
primary key(adid, companyid),
foreign key(companyid) references company(companyid)
on delete cascade
on update cascade
);

-- Contain
create table contain (
videoid integer,
adid integer unique,
companyid integer,
primary key(videoid, adid),
foreign key(videoid) references videoupload(videoid)
on delete cascade
on update cascade,
foreign key(adid, companyid) references advertisementprovide(adid, companyid)
on delete cascade
on update cascade
);

/************************************************** 
	     P O P U L A T E   T A B L E 
 **************************************************/

-- Users
insert into users (username, password, phonenumber, emailaddress) values ('billiesjack', 'tsug2k6n', '6043948203', 'billies25@gmail.com');
insert into users (username, password, phonenumber, emailaddress) values ('milk_horizon', 'asdgaeth', '6139902918', 'horizon_king@gmail.com');
insert into users (username, password, phonenumber, emailaddress) values ('chief4932', '56jiaet5', '6048293110', 'iamchief@gmail.com');
insert into users (username, password, phonenumber, emailaddress) values ('sandwich_ball29', '13893766', '8553019388', 'pineapplepizza@gmail.com');
insert into users (username, password, phonenumber, emailaddress) values ('applelego103', 'wrtjw67iw', '9058987578', 'hate_samsung@gmail.com');
insert into users (username, password, phonenumber, emailaddress) values ('jerry_pro12', '45jkewseath', '6049382049', 'rigeverything@gmail.com');
insert into users (username, password, phonenumber, emailaddress) values ('happytuna', '8j4tj5j', '5140392032', 'sushilove142@gmail.com');
insert into users (username, password, phonenumber, emailaddress) values ('sushi_master', '35ju4e6ja', '8557711561', 'salmonbaby@gmail.com');
insert into users (username, password, phonenumber, emailaddress) values ('anna_bell2k19', '5hjtaet', '8882830184', 'luis.handley98@gmail.com');
insert into users (username, password, phonenumber, emailaddress) values ('mukbang_vids', '87i4ejsyr', '6134888910', 'trisha_avocado@gmail.com');


-- PaymentInfoOwn
insert into paymentinformationown values ('2', '5215440572935946', '2003  Robson St', '0222', '246');
insert into paymentinformationown values ('3', '5524993742345244', '716  Brook St', '1023', '622');
insert into paymentinformationown values ('6', '5175305778838897', '4282  Rose Street', '0719', '999');
insert into paymentinformationown values ('9', '5587847357636285', '2908  Lynden Road', '0521', '549');
insert into paymentinformationown values ('5', '5441315587984103', '3264  Eagle Rd', '0422', '712');


-- Video Upload
insert into videoupload (userid, videoname, videolength, videogenre) values ('1', 'Teen Killers', '01:03:49', 'documentary');
insert into videoupload (userid, videoname, videolength, videogenre) values ('5', 'Ricky Gervais Stand Up ', '12:42', 'comedy');
insert into videoupload (userid, videoname, videolength, videogenre) values ('7', 'Theresa May"s political career in three minutes', '03:15', 'political');
insert into videoupload (userid, videoname, videolength, videogenre) values ('3', 'Cover: Bohemian Rhapsody', '05:53', 'music');
insert into videoupload (userid, videoname, videolength, videogenre) values ('6', 'Highlights: Milwaukee Bucks vs Toronto Raptors', '13:16', 'sports');


-- Current Session
insert into currentsession values ('9B48E742JG', '1', '1', '00:46:20');
insert into currentsession values ('8WG3OU4ITG', '5', '2', '06:13');
insert into currentsession values ('0QPWK120AH', '7', '3', '00:47');
insert into currentsession values ('LCMA93VV02', '3', '4', '03:28');
insert into currentsession values ('A9G2KN4LTA', '6', '5', '08:26');


-- ListCreate
insert into listcreate values ('0289235', '1', 'Favourites');
insert into listcreate values ('23467276', '2', 'To-Watch');
insert into listcreate values ('87634572', '2', 'Recents');
insert into listcreate values ('45272454', '4', 'Favourites');
insert into listcreate values ('23458282', '8', 'Raptors Highlights');
insert into listcreate values ('87635724', '4', 'Jams');
insert into listcreate values ('346124', '6', 'Study Music');
insert into listcreate values ('367134', '9', 'Liked Videos');
insert into listcreate values ('8864572', '5', 'Jazz Mix');
insert into listcreate values ('892562', '8', 'Streams');
insert into listcreate values ('36835692', '3', 'Recents');


-- ReportCreate
insert into reportcreate (userid, status, decision, reportdate, reason) values ('2', 'pending', '', '2017-03-19', 'inappropriate language');
insert into reportcreate (userid, status, decision, reportdate, reason) values ('5', 'reviewed', 'inappropriate', '2015-11-04', 'nudity');
insert into reportcreate (userid, status, decision, reportdate, reason) values ('8', 'pending', '', '2019-05-02', 'inappropriate language');
insert into reportcreate (userid, status, decision, reportdate, reason) values ('6', 'reviewed', 'appropriate', '2016-12-02', '');
insert into reportcreate (userid, status, decision, reportdate, reason) values ('7', 'pending', '', '2017-06-13', 'violence');


-- Platform Admin
insert into platformadmin (reportcount, name) values ('137', 'Bruce Banner');
insert into platformadmin (reportcount, name) values ('174', 'Tony Stark');
insert into platformadmin (reportcount, name) values ('82', 'Natasha Romanoff');
insert into platformadmin (reportcount, name) values ('3', 'Steve Rogers');
insert into platformadmin (reportcount, name) values ('517', 'Thor');


-- Company
insert into company (companyname) values ('Bank United');
insert into company (companyname) values ('Air Canada');
insert into company (companyname) values ('Whole Foods Market');
insert into company (companyname) values ('SAP');
insert into company (companyname) values ('Oak + Fort');


-- Report Review
insert into reportreview values ('1', '4');
insert into reportreview values ('2', '2');
insert into reportreview values ('3', '1');
insert into reportreview values ('4', '3');
insert into reportreview values ('5', '5');


-- Watch
insert into watch values ('1', '1', '9B48E742JG');
insert into watch values ('5', '2', '8WG3OU4ITG');
insert into watch values ('7', '3', '0QPWK120AH');
insert into watch values ('3', '4', 'LCMA93VV02');
insert into watch values ('6', '5', 'A9G2KN4LTA');


-- ListVideo
insert into listvideo values ('87634572', '1');
insert into listvideo values ('0289235', '2');
insert into listvideo values ('36835692', '3');
insert into listvideo values ('87635724', '4');
insert into listvideo values ('23458282', '5');


-- Advertisementprovide
insert into advertisementprovide values ('175928', '1', '00:05');
insert into advertisementprovide values ('2457621', '2', '00:30');
insert into advertisementprovide values ('992453', '3', '01:25');
insert into advertisementprovide values ('17134713', '4', '00:20');
insert into advertisementprovide values ('13434', '5', '05:00');


-- Contain
insert into contain values ('2', '175928', '1');
insert into contain values ('4', '2457621', '2');
insert into contain values ('1', '992453', '3');
insert into contain values ('3', '17134713', '4');
insert into contain values ('5', '13434', '5');


