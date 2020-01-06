USE [Seminar7]
GO 

--F5 TO DROP AND RECREATE A TABLE

IF OBJECT_ID('Routes_Stations', 'U') IS NOT NULL
	DROP TABLE Routes_Stations
IF OBJECT_ID('Stations', 'U') IS NOT NULL
	DROP TABLE Stations
IF OBJECT_ID('Routes', 'U') IS NOT NULL
	DROP TABLE Routes
IF OBJECT_ID('Trains', 'U') IS NOT NULL
	DROP TABLE Trains
IF OBJECT_ID('TrainTypes', 'U') IS NOT NULL
	DROP TABLE TrainTypes

GO 

CREATE TABLE TrainTypes(ttid INT PRIMARY KEY IDENTITY(1,1), description VARCHAR(400))

CREATE TABLE Trains(TID INT PRIMARY KEY IDENTITY(1,1), TName varchar(100), TTID INT REFERENCES TrainTypes(TTID))

CREATE TABLE Routes(RID INT  PRIMARY KEY IDENTITY(1,1), RName varchar(100) UNIQUE, TTID INT REFERENCES Trains(TID))

CREATE TABLE Stations(SID INT PRIMARY KEY IDENTITY(1,1), SName varchar(100))

CREATE TABLE RoutesStations(RID  INT REFERENCES Routes(RID),SID  INT REFERENCES Stations(SID),Arrival Time, 
			 Departure Time, PRIMARY KEY (RID, SID)) 

GO 


CREATE OR ALTER PROCEDURE addStationToRoute(@routeName varchar(50), @stationName varchar(50), @arrival Time, @departure Time)
AS
BEGIN
	DECLARE @SID INT  = (SELECT SID FROM Stations WHERE SName = @stationName), 
			@RID INT  = (SELECT RID FROM Routes WHERE RName = @routeName)

	IF @SID IS NULL OR @RID IS NULL
	BEGIN
		RAISERROR('NO SUCH STATION/ROUTE',16,1)
		RETURN -1
	END

	IF EXISTS(SELECT * FROM ROUTESSTATIONS WHERE RID=@RID AND SID=@SID)
		UPDATE RoutesStations
		SET Arrival = @arrival, departure = @departure
		WHERE RID=@RID AND SID=@SID
	ELSE
		INSERT RoutesStations(RID, SID, Arrival, Departure) VALUES (@RID, @SID, @arrival, @departure)
END
GO 

INSERT TrainTypes VALUES ('INTERREGIO'), ('REGIO')
INSERT Trains VALUES ('T1', 1), ('T2', 1), ('T3', 1)
INSERT Routes VALUES ('R1', 1), ('R2', 2), ('T3', 3)
INSERT Stations VALUES ('s1'), ('s2'), ('s3')

SELECT * FROM Trains
SELECT * FROM TrainTypes
SELECT * FROM Routes
SELECT * FROM Stations

EXEC addStationToRoute 'R1', 's1', '6:45', '10:10'
EXEC addStationToRoute 'R1', 's2', '6:10', '9:10' 
EXEC addStationToRoute 'R2', 's1', '6:10', '9:10' 

select * from RoutesStations

--CREATE FUNCTION ListStations(@ R INT)

CREATE OR ALTER FUNCTION filterStations(@R int)
RETURNS TABLE 
RETURN SELECT S.SName
FROM Stations S
WHERE S.SID IN
(
SELECT RS.SID
FROM RoutesStations RS
GROUP BY RS.SID
HAVING COUNT(*) >= @R
)
GO 

SELECT * 
FROM filterStations(2)
	

