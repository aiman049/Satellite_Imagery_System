Use SatelliteIDB;
-- TABLE 1: CONTINENT
CREATE TABLE Continent (
    Continent_ID   INT           IDENTITY(1,1) PRIMARY KEY,
    Continent_Name NVARCHAR(100) NOT NULL UNIQUE
);
-- TABLE 2: COUNTRY  (M:1 -> Continent)
CREATE TABLE Country (
    Country_ID   INT          IDENTITY(1,1) PRIMARY KEY,
    Country_Name VARCHAR(100) NOT NULL UNIQUE,
    Capital      VARCHAR(100) NOT NULL,
    Continent_ID INT          NOT NULL,
 
    CONSTRAINT FK_Country_Continent
        FOREIGN KEY (Continent_ID) REFERENCES Continent(Continent_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
-- TABLE 3: TERRAIN TYPE
CREATE TABLE TerrainType (
    TerrainType_ID INT IDENTITY(1,1) PRIMARY KEY,
    Terrain_Type   VARCHAR(100) NOT NULL UNIQUE
);
 -- TABLE 4: LOCATION  (M:1 -> Country, M:1 -> TerrainType)
CREATE TABLE Location (
    Loc_ID         INT          IDENTITY(1,1) PRIMARY KEY,
    Country_ID     INT          NOT NULL,
    TerrainType_ID INT          NOT NULL,
    Loc_Name       VARCHAR(200) NOT NULL,
    Latitude       DECIMAL(9,6) NOT NULL,
    Longitude      DECIMAL(9,6) NOT NULL,
 
    CONSTRAINT FK_Location_Country
        FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
 
    CONSTRAINT FK_Location_TerrainType
        FOREIGN KEY (TerrainType_ID) REFERENCES TerrainType(TerrainType_ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
-- TABLE 5: SATELLITE
CREATE TABLE Satellite (
    Sat_ID      INT           IDENTITY(1,1) PRIMARY KEY,
    Sat_Name    NVARCHAR(100) NOT NULL UNIQUE,
    Launch_Year INT           NOT NULL CHECK (Launch_Year BETWEEN 1950 AND 2100),
    Orbit       NVARCHAR(50)  NOT NULL,
    Model       NVARCHAR(100) NOT NULL
);
-- TABLE 6: SATELLITE IMAGE  (M:1 -> Location, M:1 -> Satellite)
CREATE TABLE Satellite_Image (
    Image_ID     INT            IDENTITY(1,1) PRIMARY KEY,
    Loc_ID       INT            NOT NULL,
    Sat_ID       INT            NOT NULL,
    Capture_Year INT            NOT NULL CHECK (Capture_Year BETWEEN 1950 AND 2100),
    Image_Path   NVARCHAR(500)  NOT NULL,
    Description  NVARCHAR(1000) NULL,
 
    CONSTRAINT FK_SatImage_Location
        FOREIGN KEY (Loc_ID) REFERENCES Location(Loc_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
 
    CONSTRAINT FK_SatImage_Satellite
        FOREIGN KEY (Sat_ID) REFERENCES Satellite(Sat_ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
-- TABLE 7: USER
CREATE TABLE [User] (
    User_ID   INT           IDENTITY(1,1) PRIMARY KEY,
    User_Name NVARCHAR(100) NOT NULL UNIQUE,
    Email     NVARCHAR(255) NOT NULL UNIQUE,
    Password  NVARCHAR(256) NOT NULL,
    Role      NVARCHAR(50)  NOT NULL DEFAULT 'viewer'
    CHECK (Role IN ('admin','analyst','viewer'))
);
-- COMPLETE USER TABLE FOR SATELLITE IMAGERY SYSTEM

CREATE TABLE [User_Profile] (
    User_ID          INT PRIMARY KEY IDENTITY(1,1),
    User_Name        VARCHAR(50)  NOT NULL UNIQUE,
    Email            VARCHAR(100) NOT NULL UNIQUE,
    Password         VARCHAR(255) NOT NULL,
    First_Name       VARCHAR(50)  NOT NULL,
    Last_Name        VARCHAR(50)  NOT NULL,
    Father_Name      VARCHAR(100) NOT NULL,
    Date_Of_Birth    DATE         NOT NULL,
    Gender           CHAR(1)      ,
    CNIC             VARCHAR(15)  UNIQUE,  -- 12345-1234567-1
    Phone_No         VARCHAR(15)  NOT NULL UNIQUE,
    Country          VARCHAR(100) NOT NULL,
    Full_Address     VARCHAR(255)   
);