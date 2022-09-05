CREATE DATABASE shooter;

-- create relational DB of your choice with minimum 5 tables

-- set Primary and Foreign Key constraints to create relations between the tables

/* create table for player login info */
CREATE TABLE PlayerLogin (
	PlayerID	INT				NOT NULL	AUTO_INCREMENT,
    Username	VARCHAR(64) 	NOT NULL,
    Password	VARCHAR(64) 	NOT NULL,
    Email 		VARCHAR(128) 	NOT NULL,
	
    CONSTRAINT PKPlayerID -- assign name to primary key
    PRIMARY KEY (PlayerID) -- identify column to apply primary key
);

/* create table for player personal info */
CREATE TABLE PlayerDetails (
	PlayerID	INT 			NOT NULL,
    Age			INT 			NOT NULL,
    Gender		VARCHAR(64)		NOT NULL,
    Country		VARCHAR(64)		NOT NULL,

    FOREIGN KEY (PlayerID) -- identify column to apply foreign key
    REFERENCES
	PlayerLogin -- name of table being referenced for foreign key
    (PlayerID) -- name of column being referenced for foreign key
);

/* create table for metric version of in-game rank system */
CREATE TABLE RankSystem (
	RankID		INT				NOT NULL	AUTO_INCREMENT,
    RankName 	VARCHAR(128),

    PRIMARY KEY (RankID)
);

/* create table for player performance statistics */
CREATE TABLE PlayerPerformance (
	PlayerID		INT			NOT NULL,
    RankID			INT,
    MatchesPlayed	INT,
    KDRatio			DEC(10,2), -- kill death ratio
    Accuracy		DEC(5,2), -- % of accuracy across all shots fired
    Winrate			DEC(5,2), -- % of wins across all matches played

    FOREIGN KEY	(PlayerID)	REFERENCES	PlayerLogin(PlayerID),
    FOREIGN KEY (RankID)	REFERENCES	RankSystem(RankID)
);

/* create table with categories for each report reasons */
CREATE TABLE ReportSystem (
	ReportCategoryID	INT				NOT NULL,
    ReportCategory		VARCHAR(240)	NOT NULL,
    
    PRIMARY KEY (ReportCategoryID)
);

/* create table for every report made in the game towards another player */
CREATE TABLE Reports (
	ReportID			INT				NOT NULL	AUTO_INCREMENT,
    ReportTimeStamp		TIMESTAMP	 	NOT NULL,
    PlayerReportedID	INT				NOT NULL,
    PlayerReportingID	INT 			NOT NULL,
    ReportCategoryID	INT 			NOT NULL,
    ReportDetails		VARCHAR(240),
    
    PRIMARY KEY (ReportID),
    FOREIGN KEY (PlayerReportedID) REFERENCES PlayerLogin(PlayerID),
    FOREIGN KEY (PlayerReportingID) REFERENCES PlayerLogin(PlayerID),
    FOREIGN KEY (ReportCategoryID) REFERENCES ReportSystem(ReportCategoryID)
);

/* create table for every player banned in the game */
CREATE TABLE Bans (
	BanID				INT				NOT NULL	AUTO_INCREMENT,
    BanTimeStamp		TIMESTAMP		NOT NULL,
	PlayerBannedID		INT 			NOT NULL,
    ReportCategoryID	INT 			NOT NULL,
    BanDetails			VARCHAR(240),
    
    PRIMARY KEY (BanID),
    FOREIGN KEY (PlayerBannedID) REFERENCES PlayerLogin(PlayerID),
    FOREIGN KEY (ReportCategoryID) REFERENCES ReportSystem(ReportCategoryID)
);

-- insert data into tables

INSERT INTO PlayerLogin 
	(username, password, email)
VALUES 
	('tarik', 'nF454$kM', 'tarik@loaded.gg'), 
    ('shiro', 'mA390^', 'shirorzbusiness@gmail.com'), 
    ('s1mple', '71Ru5*', 's1mplekostyliev@gmail.com'),
    ('prod', '#48eL8', 'prodvalorantb@gmail.com'),
    ('cory', '*I44y4', 	'CoryxKenshinYT@hotmail.com');

INSERT INTO PlayerLogin 
	(username, password, email)
VALUES 
	('w1ldc4t', '329Cn#', 'business@iamwildcat.net'), 
    ('avila', 'ZvJ5s_8R', 'julianavila@gmail.com'), 
    ('kento', 'Bxh%h:+9', '	kentobento@gmail.com'),
    ('m0nesy', 'HK8F]m*~', 'm0nesy@loaded.gg'),
    ('skyer', 'nCC4+.UL', 	'dearskyer@gmail.com');

INSERT INTO RankSystem
	(rankID, RankName)
VALUES
	(1, 'iron'),
    (2, 'bronze'),
    (3, 'silver'),
    (4, 'gold'),
    (5, 'platinum'),
    (6, 'diamond');

INSERT INTO RankSystem
	(rankID, RankName)
VALUES
	(7, 'ascendant'),
    (8, 'immortal'),
    (9, 'radiant');

SELECT * FROM PlayerLogin;

INSERT INTO PlayerPerformance
	(PlayerID, RankID)
VALUES
	(1,9),
    (2,6),
    (3,8),
    (4,2),
    (5,3),
    (6,7),
    (7,1),
    (8,4),
    (9,9),
    (10,5);

SELECT * FROM playerperformance;

INSERT INTO ReportSystem
	(ReportCategoryID, ReportCategory)
VALUES
	(1, 'verbal abuse'),
    (2, 'cheating'),
    (3, 'sabotaging the team'),
    (4, 'inappropriate name'),
    (5, 'disrespectful behaviour'),
    (6, 'threats');

SELECT * FROM PlayerLogin;
SELECT * FROM REPORTSYSTEM;

INSERT INTO bans
	(BanTimeStamp, PlayerBannedID, ReportCategoryID)
VALUES
	(TIMESTAMP(NOW()), 4, 5),
    (TIMESTAMP(NOW()), 6, 2),
    (TIMESTAMP(NOW()), 7, 2),
    (TIMESTAMP(NOW()), 8, 3),
    (TIMESTAMP(NOW()), 10, 1);

-- using any type of the joins create a view that combines multiple tables in a logical way

/* create view of all player names banned for cheating including the ID and rank names
of the banned players to see if there are trends in certain ranks getting banned more */

CREATE VIEW viewbanranks AS
	SELECT
		Bans.PlayerBannedID AS PlayerID,
		PlayerLogin.username AS Username,
		RankSystem.RankName AS RankName
	FROM Bans
	INNER JOIN PlayerPerformance
	INNER JOIN RankSystem
	INNER JOIN PlayerLogin
	ON 
		Bans.PlayerBannedID = PlayerPerformance.playerID AND
		PlayerPerformance.playerID = PlayerLogin.PlayerID AND
		PlayerPerformance.RankID = RankSystem.RankID
	WHERE
		Bans.ReportCategoryID IN (
		SELECT ReportSystem.ReportCategoryID 
		FROM ReportSystem
		WHERE ReportSystem.ReportCategory = 'cheating'
		);

USE SHOOTER;

SELECT * FROM viewbanranks;

-- in your database, create a stored function that can be applied to a query in your DB

/* create a stored function to detect possible cheaters by checking if KD ratio and 
winrate is unusually high, if so, the player is flagged as suspicious */
DROP FUNCTION IsCheating;

DELIMITER //
CREATE FUNCTION
	IsCheating (MatchesPlayed INT, KDRatio DEC(5,2), Winrate DEC(10,2)) -- function name and required input(s)
RETURNS
	VARCHAR(64) -- data type of function output
DETERMINISTIC
BEGIN
	DECLARE PlayerStatus VARCHAR(64); -- variable name for function output
		IF (MatchesPlayed >= 10 AND KDRatio >= 3.0 AND Winrate >= 70)
			THEN SET PlayerStatus = 'highly likely';
		ELSEIF (MatchesPlayed >= 10 AND KDRatio >= 3.0 AND (Winrate >=60 AND WINRATE < 70))
			 THEN SET PlayerStatus = 'likely';
		ELSEIF (MatchesPlayed >= 10 AND KDRatio >= 3.0 AND (Winrate >= 50 AND WINRATE < 60))
			 THEN SET PlayerStatus = 'unlikely';
		ELSEIF (MatchesPlayed >= 10 AND KDRatio >= 3.0 AND Winrate < 50)
			 THEN SET PlayerStatus = 'unlikely';
		 ELSEIF (MatchesPlayed >= 10 AND KDRatio <= 3.0 AND Winrate > 50)
			THEN SET PlayerStatus = 'highly unlikely';
		ELSEIF (MatchesPlayed >= 10 AND KDRatio <= 3.0)
			 THEN SET PlayerStatus = 'highly unlikely';
		ELSE
			SET PlayerStatus = 'n/a';
		END IF;
	RETURN PlayerStatus;
END //

DELIMITER ;

USE shooter;

/* update rows in KDRatio AND winrate for usernames avila and w1ldc4t to test new function made */
UPDATE PlayerPerformance p
SET 
	p.KDRatio = 14.9, p.MatchesPlayed = 25, p.Winrate = 89
WHERE
	p.PlayerID = 7;

UPDATE PlayerPerformance p
SET 
	p.KDRatio = 11.1, p.MatchesPlayed = 15, p.Winrate = 64
WHERE
	p.PlayerID = 6;

/* test IsCheating function on players */
SELECT
	PlayerID,
	IsCheating(MatchesPlayed, KDRatio, Winrate) AS IsCheating
FROM
	PlayerPerformance
WHERE PlayerID = 7;

SELECT
	PlayerID,
	IsCheating(MatchesPlayed, KDRatio, Winrate) AS IsCheating
FROM
	PlayerPerformance
WHERE PlayerID = 10;

SELECT DISTINCT
	PlayerID,
	IsCheating(MatchesPlayed, KDRatio, Winrate) AS IsCheating
FROM
	PlayerPerformance
WHERE PlayerID = 20;

Select DISTINCT * from playerperformance;

-- prepare an example query with a subquery to demonstrate how to extract data from your DB for analysis

/* the newly released anticheat system released went awry and there were many players falsely banned for cheating 
shortly after it was released - it is now fixed but we need to find out the IDs of these players banned during this 
time so they can be unbanned in-game */

SELECT * FROM Bans;

SELECT DISTINCT
	PlayerBannedID
FROM 
	Bans
WHERE
	(BanTimeStamp BETWEEN 
		SUBDATE(TIMESTAMP(NOW()), INTERVAL 2 DAY) AND TIMESTAMP(NOW())
    AND
    ReportCategoryID IN (
		SELECT ReportCategoryID
        FROM ReportSystem
        WHERE ReportCategory = 'cheating'));

-- in your database, create a stored procedure and demonstrate how it runs

/* creating a procedure to shortcut adding player to ban list */
DELIMITER //
CREATE PROCEDURE InstaBan (
	IN PlayerID INT,
    IN ReportCategoryID INT
)
BEGIN
	INSERT INTO Bans(BanTimeStamp, PlayerBannedID, ReportCategoryID, BanDetails)
	VALUES (TIMESTAMP( NOW() ), PlayerID, ReportCategoryID, 'InstaBan');
END //
DELIMITER ;

CALL InstaBan(10, 1);

SELECT * FROM bans;

SELECT * FROM PlayerLogin;

INSERT INTO PlayerDetails
	(PlayerID, Age, Gender, Country)
VALUES
	(1, 26, 'Male', 'Turkey'),
    (2, 21, 'Male', 'USA'),
    (3, 24, 'Male', 'Ukraine'),
    (4, 21, 'Male', 'USA'),
    (5, 23, 'Male', 'Russia'),
    (6, 27, 'Male', 'UK'),
    (7, 14, 'Male', 'Spain'),
    (8, 17, 'Male', 'Japan'),
    (9, 16, 'Male', 'Russia'),
    (10, 21, 'Female', 'UK');

-- Prepare an example query with group by and having to demonstrate how to extract data from your DB for analysis

/* we are interested in seeing in which country the game is the most 
popular in we can do this by looking at where player base is from */

CREATE OR REPLACE VIEW ViewPlayersRegion AS 
	SELECT COUNT(*) AS PlayerCount, pd.Country
	FROM PlayerDetails pd
	GROUP BY COUNTRY
	ORDER BY COUNT(*) DESC;

SELECT * FROM ViewPlayersRegion;

/* we are are also interested in seeing which countries has the 
best players i.e. the country with the most high ranked players */

CREATE OR REPLACE VIEW ViewHighRankRegion AS
	SELECT
		COUNT(*) AS PlayerCount,
		Country
	FROM PlayerDetails pd
	WHERE PlayerID IN (
		SELECT pp.PlayerID
		FROM PlayerPerformance pp
		WHERE pp.RankID > 6
		)
	GROUP BY Country
	ORDER BY COUNT(*) DESC;

SELECT * FROM ViewHighRankRegion;
SELECT * FROM RankSystem;

USE SHOOTER;
SELECT * FROM ranksystem;
SELECT * FROM playerperformance;

/* we can see the rank distribution of players using group by also */
SELECT 
	COUNT(*) AS PlayerCount,
    RankSystem.RankName
FROM PlayerPerformance
INNER JOIN RankSystem
	ON RankSystem.RankID = PlayerPerformance.RankID
GROUP BY PlayerPerformance.RankID;

INSERT INTO PlayerLogin
	(username, password, email)
VALUES
	('grim', '3EuKiJgu', 'grim@afkcreators.com'),
    ('shroud', 'nTe11UfC', 'shroud@loaded.gg'),
    ('ploo', 'egofnz72', 'ploo@nani.gg'),
    ('t1na', 'Tc81Vm12', 'wenisprinklesbusiness@gmail.com'),
    ('florescent', 'n4AodgLi', 'florescent@loaded.gg'),
    ('mimi', '1nQmtfx5', 'mimi@levelupagency.eu'),
    ('jazzyk1ns', 'hUs7ru6C', 'jazzyk1ns@seg.gg'),
    ('MeL', 'QfY9L0YF', 'meL@seg.gg'),
    ('f0rsakeN', 'iExoNs69', 'forsaken@pprx.team'),
    ('stewie', '72NvzwWF', 'teamstewie2k@unitedtalent.com');

SELECT * FROM PlayerLogin;

SELECT * FROM PlayerDetails;

INSERT INTO playerdetails
	(PlayerID, Age, Gender, Country)
VALUES
	(11, 19, 'Male', 'USA'),
    (12, 27, 'Male', 'USA'),
    (13, 23, 'Female', 'Canada'),
    (14, 26, 'Female', 'USA'),
    (15, 14, 'Female', 'Canada'),
    (16, 16, 'Female', 'Brazil'),
    (17, 18, 'Female', 'Mexico'),
    (18, 21, 'Female', 'UK'),
    (19, 17, 'Male', 'Indonesia'),
    (20, 27, 'Male', 'Japan');

SELECT * FROM ranksystem;

SELECT * FROM playerPerformance;

INSERT INTO PlayerPerformance
	(PlayerID, RankID, MatchesPlayed, KDRatio, Accuracy, Winrate)
VALUES
	(1, 9, 390, 1.24, 66.0, 57.7),
	(2, 6, 428, 0.96, 69.4, 53.0),
    (3, 8, 79, 1.34, 60.0, 60.0),
    (4, 2, 307, 1.02, 45.0, 52.4),
    (5, 3, 34, 1.10, 39.2, 48.7),
    (6, 7, 15, 11.10, 68.9, 64.0),
    (7, 1, 25, 14.90, 78.3, 89.0),
    (8, 4, 7, 1.9, 57.7, 75.0),
    (9, 9, 21, 2.3, 61.6, 70.0);

SELECT * FROM playerlogin;

INSERT INTO PlayerPerformance
	(PlayerID, RankID, MatchesPlayed, KDRatio, Accuracy, Winrate)
VALUES
	(10, 5, 9, 1.74, 76.0, 44.4);

SELECT * FROM reportSystem;

INSERT Reports
	(ReportTimeStamp, PlayerReportedID, PlayerReportingID, ReportCategoryID, ReportDetails)
VALUES
	(TIMESTAMP(NOW()), 4, 13, 1, 'toxic'),
    (SUBDATE(TIMESTAMP(NOW()), INTERVAL 1 DAY), 9, 14, 2, '100% esp'),
    (SUBDATE(NOW(), INTERVAL 2 DAY), 19, 8, 2, ' '),
    (SUBDATE(NOW(), INTERVAL 10 HOUR), 20, 5, 6, ' '),
    (SUBDATE(NOW(), INTERVAL 1 WEEK), 14, 4, 3, 'afk at spawn'),
    (SUBDATE(NOW(), INTERVAL 2 WEEK), 16, 3, 3, 'afk at spawn'),
    (SUBDATE(NOW(), INTERVAL 3 DAY), 6, 2, 2, 'aimbot'),
    (SUBDATE(NOW(), INTERVAL 4 DAY), 7, 2, 2, ' '),
    (SUBDATE(NOW(), INTERVAL 1 DAY), 9, 4, 4, 'calling me names'),
	(SUBDATE(NOW(), INTERVAL 7 DAY), 7, 4, '5', 'ruining team morale');

USE shooter;

SELECT * FROM Bans;
SELECT * FROM PlayerDetails;
SELECT * FROM PlayerLogin;
SELECT * FROM PlayerPerformance;
SELECT * FROM rankSystem;
SELECT * FROM reports;
SELECT * FROM reportSystem;
SELECT * FROM viewbanranks;