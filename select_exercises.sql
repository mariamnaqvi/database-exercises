-- Create a new file called select_exercises.sql

-- Use the albums_db database
use albums_db;

-- checking correct db is selected
select database();

-- Explore the structure of the albums table
describe albums;


-- a. How many rows are in the albums table?
-- 31 rows

-- b. How many unique artist names are in the albums table?
-- 23 rows
select distinct artist
from albums;

-- c. What is the primary key for the albums table?
-- id

-- d. What is the oldest release date for any album in the albums table? What is the most recent release date?
select release_date
from albums
order by release_date; -- to sort in asc order
-- oldest release date is 1967
-- most recent release date is 2011

-- The name of all albums by Pink Floyd
select name
from albums
where artist = 'Pink Floyd';
-- album names: The Dark Side of the Moon, The Wall

-- The year Sgt. Pepper's Lonely Hearts Club Band was released
select * from albums; 

select release_date 
from albums
where name = "Sgt. Pepper's Lonely Hearts Club Band";
-- year of release = 1967

-- c. The genre for the album Nevermind
select genre
from albums
where name = "Nevermind";
-- genre is Grunge, Alternative rock

-- d. Which albums were released in the 1990s
select name 
from albums
where release_date between 1990 and 1999;
-- 11 albums
-- The Bodyguard, Jagged Little Pill, Come On Over, Falling into You, Let's Talk About Love, Dangerous, The Immaculate Collection, Titanic: Music from the Motion Picture, Metallica,Nevermind,Supernatural

-- e. Which albums had less than 20 million certified sales
select * from albums; 
select name
from albums
where sales < 20;
-- 13 albums
-- Grease: The Original Soundtrack from the Motion Picture, Bad, Sgt. Pepper's Lonely Hearts Club Band, Dirty Dancing, Let's Talk About Love, Dangerous, The Immaculate Collection, Abbey Road,Born in the U.S.A., Brothers in Arms, Titanic: Music from the Motion Picture, Nevermind, The Wall

-- f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
select name 
from albums
where genre = "Rock";
-- only returns rock genre because we are specifying that genre is equal to rock

