-- Create a new file called select_exercises.sql

-- Use the albums_db database
USE albums_db;

-- checking correct db is selected
SELECT DATABASE();

-- Explore the structure of the albums table
DESCRIBE albums;


-- 1a. How many rows are in the albums table? 
SELECT *
FROM albums;
-- returns 31 rows

-- 1b. How many unique artist names are in the albums table? 

SELECT DISTINCT artist
FROM albums;
-- returns 23 rows

-- 1c. What is the primary key for the albums table?
DESCRIBE albums;
-- id is the primary key

-- 1d. What is the oldest release date for any album in the albums table? 
-- 1967
-- What is the most recent release date?
-- 2011
SELECT DISTINCT release_date
FROM albums
ORDER BY release_date; -- to sort in asc order

-- The name of all albums by Pink Floyd 
SELECT NAME
FROM albums
WHERE artist = 'Pink Floyd';
-- returns 2 records
-- album names: The Dark Side of the Moon, The Wall

-- The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT NAME, release_date 
FROM albums
WHERE NAME = 'Sgt. Pepper\'s Lonely Hearts Club Band';
-- year of release = 1967

-- c. The genre for the album Nevermind
SELECT genre
FROM albums
WHERE NAME = 'Nevermind';
-- genre is Grunge, Alternative rock

-- d. Which albums were released in the 1990s 
SELECT NAME, release_date
FROM albums
WHERE release_date BETWEEN 1990 AND 1999;
-- returns 11 albums
-- The Bodyguard, Jagged Little Pill, Come On Over, Falling into You, Let's Talk About Love, Dangerous, The Immaculate Collection, Titanic: Music from the Motion Picture, Metallica,Nevermind,Supernatural

-- e. Which albums had less than 20 million certified sales
SELECT NAME, sales
FROM albums
WHERE sales < 20;
-- 13 albums
-- Grease: The Original Soundtrack from the Motion Picture, Bad, Sgt. Pepper's Lonely Hearts Club Band, Dirty Dancing, Let's Talk About Love, Dangerous, The Immaculate Collection, Abbey Road,Born in the U.S.A., Brothers in Arms, Titanic: Music from the Motion Picture, Nevermind, The Wall

-- f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
SELECT *
FROM albums
WHERE genre = "Rock"; --  returns 5 records
-- only returns rock genre because we are specifying that genre is equal to rock and progressive or pop rock is not an exact match



