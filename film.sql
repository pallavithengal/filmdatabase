create database filmdb;
use filmdb;

create table actor(
act_id int,
act_firstname varchar(255),
act_lastname varchar(255),
act_gender varchar(255),
primary key (act_id));
insert into actor values(101,"anushka","sharma","female");
insert into actor values(102,"shahrukh","khan","male");
insert into actor values(103,"aishwarya","roy","female");
insert into actor values(104,"allu","arjun","male");
insert into actor values(105,"priyanka","chopra","female");
insert into actor values(106,"vijay","thalapathy","male");
select * from actor;

create table producer(
prod_id int,
prod_name varchar(255),
producer_phone_no int,
primary key (prod_id));
insert into producer values(201,"s.s.rajamouli",234567);
insert into producer values(202,"atlee kumar",267767);
insert into producer values(203,"sanjay leela bhansali",236577);
insert into producer values(204,"siddharth anand",767675);
insert into producer values(205,"aditya chopra",734355);
insert into producer values(206,"sukumar",2425324);
select * from producer;


create table movies(
movie_id int,
movie_name varchar(255),
movie_year int,
prod_id int,
m_language varchar(255),
primary key (movie_id),
foreign key (prod_id) references producer(prod_id));
insert into movies values(301,"bajirao_mastani",2015,203,"hindi");
insert into movies values(302,"rab_ne_bana_di_jodi",2008,205,"hindi");
insert into movies values(303,"arya",2004,206,"telgu");
insert into movies values(304,"mersal",2017,202,"tamil");
insert into movies values(305,"devdas",2002,203,"hindi");
insert into movies values(306,"pathaan",2023,204,"hindi");
select * from movies;

create table movie_cast(
act_id int,
movie_id int,
role_in_movie varchar(255),
primary key (act_id,movie_id),
foreign key (act_id) references actor(act_id),
foreign key (movie_id) references movies(movie_id));

insert into movie_cast values(101,302,"wife_of_shahrukh_khan");
insert into movie_cast values(102,306,"soilder_of_india");
insert into movie_cast values(103,305,"madly_loving_girl");
insert into movie_cast values(104,303,"caring,funnyboy");
insert into movie_cast values(105,301,"indian_royal_wife");
insert into movie_cast values(106,304,"doctor&social_worker");
select * from movie_cast;


create table rating(
movie_id int,
stars varchar(255),
primary key (movie_id),
foreign key (movie_id) references movies(movie_id));
insert into rating values(301,5);
insert into rating values(302,4);
insert into rating values(303,4);
insert into rating values(304,3);
insert into rating values(305,5);
insert into rating values(306,3);
select * from rating;

--  query 1
select movie_name
from movies
where prod_id in (select prod_id
from producer
where prod_name="sanjay leela bhansali");

-- query 3
select *from movies
where movie_year between 2008 and 2018;

-- query 4
SELECT movie_name, MAX(stars)
FROM movies, rating 
WHERE movies.movie_id=rating.movie_id 
AND rating.stars IS NOT NULL
group by movie_name
ORDER BY movie_name;



-- query 5
update rating 
set stars = 5
where movie_id in (SELECT movie_id FROM movies
where prod_id in (SELECT prod_id
FROM producer
WHERE prod_name = "sanjay leela bhansali"));
select * from rating;

SELECT *
FROM movies
LEFT JOIN movie_cast ON movies.movie_id = movie_cast.movie_id
UNION
SELECT *
FROM movies
RIGHT JOIN movie_cast ON movies.movie_id = movie_cast.movie_id
WHERE movies.movie_id IS NULL;



SELECT movies.movie_name, rating.stars
FROM movies
JOIN rating ON movies.movie_id = rating.movie_id
ORDER BY rating.stars DESC;


