--  exercises from https://sqlzoo.net/wiki/The_JOIN_operation

-- 1. Modify the code to show the matchid and player name for all goals scored by Germany.
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER';

--  2. Show id, stadium, team1, team2 for just game 1012
SELECT distinct id,stadium,team1,team2
  FROM game gm
inner join goal g on g.matchid = gm.id
where id = '1012'

-- 3. 