
--INSERT DATA INTO TABLES
insert into Musicians(Musician_ID,FirstName,LastName,BirthPlace) values (13,'Ozzy','Osbourne','England')
insert into Musicians values (14,'Dave','Murray','England')
insert into Musicians values (15,'Freddy','Mercury','England')
--insert into Artists values (7,'Scorpions')
insert into Artists values (6,'Dream Theather')
insert into Artists values (7,'Socrpions')
insert into Album values (4,'Queen',1973,6,1)
insert into Album values (5,'Queen II',1974,6,1)
insert into Album values (6,'JAZZ',1978,6,1)

--UPDATE DATA 

select * from Album
update Album
set Label_ID = 1 
where Year between 1970 and 1975

update Album
set Label_ID = 2 
where Year in(1976,1977)

update Album
set Label_ID = 5 
where Title like 'Q__%'  and year >= 1980

update Album
set Label_ID = 4
where Title is not null and year = 1990

select * from Tracks

 update Tracks
 set Genre_ID = 1
 where Length <=3

 --DELETE DATA

 delete from Album_Reviews
 where Ranking = 3

 --3 Queries with UNION,INTERSECT,EXCEPT
 select * 
 from Album
 where Title like 'Q_%'
 union 
 select *
 from Album
 where Year <= 1975

 select a1.Title
 from Album a1
 where Title like 'B_%'
 intersect
 select a2.Title
 from Album a2
 where Year <= 1980
 order by a1.Title

 select a1.Title
 from Album a1
 where Title like 'Q_%'
 except
 select a2.Title
 from Album a2
 where year < 1972
 order by a1.Title

 --b

 select *
 from Album a  inner join Tracks t on 
 a.Album_ID = t.Album_ID

 select *
 from Album a  left join Tracks t on 
 a.Album_ID = t.Album_ID

 select *
 from Album a  right join Tracks t on 
 a.Album_ID = t.Album_ID

 select *
 from Album a  full outer join Tracks t on 
 a.Album_ID = t.Album_ID

 --c.
select a.Album_ID
from Album a
where Year <= 1978 and a.Album_ID in (select t.Album_ID from Tracks t)

select a.Album_ID
from Album a
where Year <= 1978 and exists (select * from Tracks t where t.Album_ID = a.Album_ID)

--d.

 select a.Album_ID,a.Artist_ID
 from Album a  inner join Tracks t on 
 a.Album_ID = t.Album_ID
 group by a.Album_ID,a.Artist_ID

  select a.Title,a.Year,a.Album_ID
 from Album a  inner join Tracks t on 
 a.Album_ID = t.Album_ID
 group by a.Title,a.Year, a.Album_ID
 having (a.Year) <= 1974

  select a.Title,a.Label_ID,a.Album_ID
 from Album a  inner join Tracks t on 
 a.Album_ID = t.Album_ID
 group by a.Title,a.Album_ID,a.Label_ID
 having AVG(a.Year) > 1980

 ---------
 select distinct a.Year
 from Album a

 select Title,Year
 from Album
 order by Year

select Title,Year,Label_ID
 from Album
 order by Title desc

 select top 2 Title
 from Album