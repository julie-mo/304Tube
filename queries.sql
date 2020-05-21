/* 
These are the SQL for the functionalities mentioned in Milestone 3.
Additional functionalities added to meet query requirements of Milestone 6.
Some functionalities have been ommitted as they do not require SQL or are repetitive. 
Not all of these are queries; some are simple inserts, updates, and deletes.
Note: $(?) are user inputs. 

LIST OF ALL QUERIES AT BOTTOM OF PAGE 
*/

/*****************
	V I E W E R 
 *****************/

-- Search for videos using keyword/name
select *
from videoupload
where videoname like '%$(?)%';

-- View a list of videos in a list
select * 
from listvideo 
where listid = '$(?)';

-- View a list of videos
select *
from videoupload;

-- Sort videos by date added (oldest by default, newest with desc)
-- or length (shortest by default, longest with desc)
select *
from videoupload
order by videolength;

select *
from videoupload
order by videolength desc;

select *
from videoupload 
order by videoid;

select *
from videoupload
order by videoid desc;

-- Report a video
insert into reportcreate (reportdate, reason) values ('$(?)', '$(?)');

-- Create list 
insert into listcreate (userid, listname) values ('$(?)', '$(?)');

-- Add video to list
list = select listid 
from listcreate
where listid = '$(?)';

video = select videoid
from videoupload
where videoname like '%$(?)%';

insert into listvideo (listid, videoid) values (list, video);

-- Remove video from list
delete from listvideo 
where videoid in
	(select videoid 
	from video 
	where videoname = '$(?)');


-- Find viewer who has seen all videos
select viewer.userid
from viewer 
where not exists (
	select * 
	from videoupload 
	where not exists (
		select watch.userid
		from watch 
		where viewer.userid = watch.userid and 
			  videoupload.videoid = watch.videoid));


-- View and edit payment information
select * 
from paymentinformationown
where userid = '$(?)';

update paymentinformationown 
set '$(?)' = '$(?)'
where '$(?)' = '$(?)';

-- Delete account
delete from users 
where userid = '$(?)';



/**********************
	 U P L O A D E R  
 **********************/

-- View a list of all videos previously uploaded
select *
from videos 
where userid like '%$(?)%';

-- Sort the list of uploaded videos by view 
-- (lowest views first by default, highest views with DESC),
-- or oldest / newest(DESC) 
select * 
from videos
where userid like '%$(?)%'
order by videoview;

select * 
from videos
where userid like '%$(?)%'
order by videoview desc;

select * 
from videos
where userid like '%$(?)%'
order by videoid;

select * 
from videos
where userid like '%$(?)%'
order by videoid desc;


-- Get total view counts for an uploader 
select sum(videoview)
from videoupload
where userid = '$(?)';


-- View a list of videos that have above or below the uploader’s 
-- average number of views per video
select * 
from videos 
where videoview > (
	select avg(videoview)
	from videos
	where userid = '$(?)')
order by videoview;

-- Upload a new video, and set its video title, genre
insert into videoupload (userid, videoname, videolength, videogenre) values ('$(?)', 'Honest Trailers', '09:10', 'movies');

-- See total number of videos the uploader has uploaded
select count(videoid)
from videoupload
where userid = '$(?)';

-- See average number of videos uploaded by each uploader
select avg(videocount)
from uploader
group by userid;

-- Delete a video
delete from videoupload 
where userid = '$(?)' and videoname = '$(?)';

-- Edit video (Video name, genre)
update videoupload 
set videoname = '$(?)'
where videoname = '$(?)';

update videoupload 
set videogenre = '$(?)'
where videogenre = '$(?)';


-- Delete account
delete from users
where userid = '$(?)';



/*********************************
	P L A T F O R M   A D M I N 
 *********************************/

-- View reported videos 
select * 
from videoupload
where videoid IN (
	select videoid 
	from reportcreate);

-- Set status of reported videos 
update reportcreate
set status = 'reviewed' and decision = '$(?)' 
where reportid = '$(?)';

-- View a list of reports
select *
from reportcreate;

-- View number of reports that have been reported as "appropriate" or "inappropriate"
select count(reportid)
from reportcreate
group by decision;

-- Search for videos reported by a specific viewer
select *
from videoupload 
where userid = '$(?)';

-- Search for an uploader's information whose video was reported
select u.userid, u.videocount, u.totalview
from uploader u, videoupload v, reportcreate r
where u.userid = v.userid and v.videoid = r.videoid;  


/**********************
	 C O M P A N Y
 **********************/


-- Add an advertisement
insert into advertisementprovide (companyid, adlength) values ('$(?)', '$(?)');
insert into contain values ('$(?)', '$(?)', '$(?)');

-- Delete an advertisement
delete from advertisementprovide 
where adid = '$(?)';

-- See a list of videos with ads of the company
select v.videoid, v.userid, v.videoname, v.videoview, v.videolength, v.videogenre
from videoupload v, contain c, company cp
where v.videoid = c.videoid and c.companyid = cp.companyid;

-- Find videos with ads from all companies
select v.videoid
from videoupload v
where not exists (
	(select c.companyid 
	from company c) except (
		select a.companyid 
		from contain a
		where a.videoid= v.videoid));


/***************************************
	  L I S T   O F   Q U E R I E S 
 ***************************************

-- Selection -- 

	1. Search for videos using keyword/name
	2. Sort videos by date added or length
	3. Add video to list
	4. View payment information
	5. View a list of all videos previously uploaded
	6. Sort the list of uploaded videos by view or date added
	7. View reported videos 
	8. Search for videos reported by a specific viewer
	9. View a list of videos in a list


-- Projection -- 
	
	1. View a list of reports
	2. View a list of videos

-- Join -- 
	
	1. Search for an uploader's information whose video was reported
	2. See a list of videos with ads of the company


-- Aggregation -- 

	1. View a list of videos that have above or below 
	   the uploader’s average number of views per video
	2. Get total view counts for an uploader 
	3. See total number of videos the uploader has uploaded


-- Nested Aggregation with Group By --

	1. View number of reports that have been reported as 
	   "appropriate" or "inappropriate"
	2. See average number of videos uploaded by each uploader

-- Division Query --
	
	1. Find a viewer who has seen all videos
	2. Find videos with ads from all companies 

*/ 