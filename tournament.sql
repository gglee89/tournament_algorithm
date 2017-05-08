-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

-- Drop Database
DROP DATABASE IF EXISTS tournament;

CREATE DATABASE tournament;

-- Connect to the new database
\c tournament

-- Drop all tables and views if they exist
DROP TABLE IF EXISTS Players CASCADE;
DROP TABLE IF EXISTS Matches CASCADE;
DROP VIEW IF EXISTS Standings;



-- Create tables and views
CREATE TABLE Players (
	ID SERIAL PRIMARY KEY ,
	NAME VARCHAR(40) NOT NULL
);

CREATE TABLE Matches (
	ID SERIAL PRIMARY KEY,
	WINNER INT4 NOT NULL REFERENCES Players(ID),
	LOSER INT4 NOT NULL REFERENCES Players(ID)
);

CREATE VIEW Standings AS
SELECT p.ID, NAME,
	( SELECT COUNT(*) FROM Matches WHERE p.ID = WINNER ) AS WINS,
	( SELECT COUNT(*) FROM Matches WHERE p.ID in (WINNER, LOSER) ) AS MATCHES
FROM Players p
GROUP BY p.ID
ORDER BY WINS DESC;
