 
-- ============================================================
-- SAMPLE QUERIES
-- ============================================================
 SELECT * FROM vw_ImageDetail WHERE Country_Name = 'Pakistan';
SELECT * FROM vw_ImageDetail WHERE Country_Name = 'Turkey';
SELECT * FROM vw_CountryImageCount ORDER BY Total_Images DESC;
SELECT Terrain_Type, COUNT(*) AS Cnt FROM vw_ImageDetail GROUP BY Terrain_Type ORDER BY Cnt DESC;
SELECT * FROM vw_ImageDetail WHERE Sat_Name = 'Sentinel-2A';
SELECT Country_Name, Loc_Name, Image_Path, Capture_Year FROM vw_ImageDetail WHERE Terrain_Type = 'Mountain';
 
PRINT '============================================================';
PRINT ' SatelliteDB v3.0 FINAL created successfully!';
PRINT ' Countries  : 7  (Pakistan, China, USA, Brazil,';
PRINT '                   Australia, Japan, Turkey)';
PRINT ' Locations  : 46  (7 per country)';
PRINT ' Satellites : 10';
PRINT ' Images     : 67';
PRINT ' Users      : 5';
PRINT '============================================================';
GO
 
USE master;
GO
