select * from netflix_raw 
where show_id='s5023';

-- check duplicates 
select show_id
from netflix_raw 
group by show_id
having count(show_id) >1
 
select show_id,COUNT(*) 
from netflix_raw
group by show_id 
having COUNT(*)>1

--remove duplicates 

WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY UPPER(title), type ORDER BY show_id) AS rn
    FROM netflix_raw
)

--handling foreign characters
--data type conversions for date added
SELECT 
    show_id,
    CAST(title AS NVARCHAR(255)) AS title,
    CAST(type AS NVARCHAR(50)) AS type,
    CAST(director AS NVARCHAR(500)) AS director,
    CAST(cast AS NVARCHAR(1000)) AS cast,
    CAST(country AS NVARCHAR(255)) AS country,
    CAST(listed_in AS NVARCHAR(255)) AS listed_in,
    TRY_CAST(date_added AS DATE) AS date_added,
    release_year,
    rating,
    duration,
    description
INTO netflix
FROM cte
WHERE rn = 1;

--populate missing values in country,duration columns 
UPDATE n1
SET country = n2.country
FROM netflix n1
JOIN netflix n2
ON n1.show_id = n2.show_id
WHERE n1.country IS NULL
AND n2.country IS NOT NULL;

UPDATE netflix
SET duration = rating
WHERE duration IS NULL;

--populate rest of the nulls as not_available
UPDATE netflix
SET 
    country = ISNULL(country, 'Not Available'),
    director = ISNULL(director, 'Not Available'),
    cast = ISNULL(cast, 'Not Available'),
    listed_in = ISNULL(listed_in, 'Not Available');

--new table for listed_in,director, country

SELECT 
    show_id,
    TRIM(value) AS genre
INTO netflix_genre
FROM netflix
CROSS APPLY STRING_SPLIT(listed_in, ',');

SELECT 
    show_id,
    TRIM(value) AS actor
INTO netflix_cast
FROM netflix
CROSS APPLY STRING_SPLIT(cast, ',');

SELECT 
    show_id,
    TRIM(value) AS country
INTO netflix_country
FROM netflix
CROSS APPLY STRING_SPLIT(country, ',');

SELECT 
    show_id,
    TRIM(value) AS director
INTO netflix_director
FROM netflix
CROSS APPLY STRING_SPLIT(director, ',');

select * from netflix_director

--drop columns director , listed_in,country,cast
ALTER TABLE netflix
DROP COLUMN director, listed_in, country, cast;


--netflix data analysis

/*1  for each director count the no of movies and tv shows created by them in separate columns 
for directors who have created tv shows and movies both */

select nd.director,
        COUNT(case when n.type = 'Movie' then 1 end ) as movies_count,
        COUNT(case when n.type = 'TV Show' then 1 end ) as tv_show_count
from netflix_director nd
left join netflix n
on nd.show_id = n.show_id
group by nd.director
having COUNT(distinct n.type)>1

select * from netflix_genre
select * from netflix_country




--2 which country has highest number of comedy movies 
select top(1) nc.country,
        COUNT(distinct nc.show_id) as no_of_comedy_movie
from netflix_genre ng
inner join netflix_country nc on ng.show_id = nc.show_id 
inner join netflix n on ng.show_id=nc.show_id
where ng.genre='Comedies' and n.type='Movie'
group by nc.country
order by no_of_comedy_movie desc

--3 for each year (as per date added to netflix), which director has maximum number of movies released
--order by date_year, no_of_movies desc


with cte as (
select nd.director,YEAR(date_added) as date_year,count(n.show_id) as no_of_movies
from netflix n
inner join netflix_director nd on n.show_id=nd.show_id
where type='Movie'
group by nd.director,YEAR(date_added)
)

select director,date_year,no_of_movies
from (
select *
, ROW_NUMBER() over(partition by date_year order by no_of_movies desc, director) as rn
from cte)n 
where rn=1
order by date_year desc ,
          no_of_movies desc

--4 what is average duration of movies in each genre

select ng.genre,
        AVG(cast(REPLACE(duration,' min','') AS int)) as avg_duration
from netflix n 
inner join netflix_genre ng
on n.show_id = ng.show_id
where type = 'Movie'
group by genre
order by avg_duration

--5  find the list of directors who have created horror and comedy movies both.
-- display director names along with number of comedy and horror movies directed by them    
select nd.director,
       count(distinct case when ng.genre = 'Comedies' then n.show_id end) as no_of_comedy_movie,
       count(distinct case when ng.genre = 'Horror Movies' then n.show_id end) as no_of_horror_movie 
from netflix n
inner join netflix_genre ng on n.show_id = ng.show_id
inner join netflix_director nd on n.show_id = nd.show_id
where n.type = 'Movie' 
and ng.genre in ('Comedies','Horror Movies')
group by nd.director
having COUNT(distinct ng.genre)=2;

--Show the Top 10 Content Producing Countries
SELECT top 10 TRIM(value) AS country,
       COUNT(*) AS cnt
FROM netflix_raw
CROSS APPLY STRING_SPLIT(country, ',')
GROUP BY TRIM(value)
ORDER BY cnt DESC;




create TABLE [dbo].[netflix_raw](
	[show_id] [varchar](10) primary key,
	[type] [varchar](10) NULL,
	[title] [nvarchar](200) NULL,
	[director] [varchar](250) NULL,
	[cast] [varchar](1000) NULL,
	[country] [varchar](150) NULL,
	[date_added] [varchar](20) NULL,
	[release_year] [int] NULL,
	[rating] [varchar](10) NULL,
	[duration] [varchar](10) NULL,
	[listed_in] [varchar](100) NULL,
	[description] [varchar](500) NULL
) 

