
USE SatelliteIDB;
GO
-- SECTION 1: CREATE SQL SERVER LOGINS
CREATE LOGIN admin_login
WITH PASSWORD = 'Admin@123';

CREATE LOGIN analyst_login
WITH PASSWORD = 'Analyst@123';

CREATE LOGIN viewer_login
WITH PASSWORD = 'Viewer@123';
GO
-- SECTION 2: CREATE DATABASE USERS
CREATE USER admin_user
FOR LOGIN admin_login;

CREATE USER analyst_user
FOR LOGIN analyst_login;

CREATE USER viewer_user
FOR LOGIN viewer_login;
GO
-- SECTION 3: CREATE ROLES
CREATE ROLE SatAdmin;
CREATE ROLE SatAnalyst;
CREATE ROLE SatViewer;
GO
-- SECTION 4: GRANT PERMISSIONS TO ROLES
-- SatAdmin → Full Access
GRANT SELECT, INSERT, UPDATE, DELETE
ON Continent
TO SatAdmin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON Country
TO SatAdmin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON TerrainType
TO SatAdmin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON Location
TO SatAdmin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON Satellite
TO SatAdmin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON Satellite_Image
TO SatAdmin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON [User]
TO SatAdmin;
-- SatAnalyst → Read + Manage Satellite Images
GRANT SELECT
ON Continent
TO SatAnalyst;

GRANT SELECT
ON Country
TO SatAnalyst;

GRANT SELECT
ON TerrainType
TO SatAnalyst;

GRANT SELECT
ON Location
TO SatAnalyst;

GRANT SELECT
ON Satellite
TO SatAnalyst;

GRANT SELECT, INSERT, UPDATE
ON Satellite_Image
TO SatAnalyst;
-- SatViewer → Read Only Access
GRANT SELECT
ON Continent
TO SatViewer;

GRANT SELECT
ON Country
TO SatViewer;

GRANT SELECT
ON TerrainType
TO SatViewer;

GRANT SELECT
ON Location
TO SatViewer;

GRANT SELECT
ON Satellite
TO SatViewer;

GRANT SELECT
ON Satellite_Image
TO SatViewer;

-- SECTION 5: ASSIGN USERS TO ROLES
ALTER ROLE SatAdmin
ADD MEMBER admin_user;

ALTER ROLE SatAnalyst
ADD MEMBER analyst_user;

ALTER ROLE SatViewer
ADD MEMBER viewer_user;
GO
