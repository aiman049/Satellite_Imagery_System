USE SatelliteIDB;
-- ============================================================
-- INDEXES : To make searching Fast.
-- ============================================================
CREATE INDEX IX_Country_ContinentID  ON Country        (Continent_ID);
CREATE INDEX IX_Location_CountryID   ON Location       (Country_ID);
CREATE INDEX IX_Location_TerrainID   ON Location       (TerrainType_ID);
CREATE INDEX IX_SatImage_LocID       ON Satellite_Image(Loc_ID);
CREATE INDEX IX_SatImage_SatID       ON Satellite_Image(Sat_ID);
CREATE INDEX IX_SatImage_Year        ON Satellite_Image(Capture_Year);
GO
 -- INSERT: CONTINENTS
INSERT INTO Continent (Continent_Name) VALUES
    ('Asia'),           -- Continent_ID = 1
    ('North America'),  -- Continent_ID = 2
    ('Europe'),         -- Continent_ID = 3
    ('South America'),  -- Continent_ID = 4
    ('Oceania'),        -- Continent_ID = 5
    ('Africa');         -- Continent_ID = 6
GO
 -- INSERT: COUNTRIES
INSERT INTO Country (Country_Name, Capital, Continent_ID) VALUES
    ('Pakistan',   'Islamabad',    1),  -- Country_ID = 1
    ('China',      'Beijing',      1),  -- Country_ID = 2
    ('USA',        'Washington DC',2),  -- Country_ID = 3
    ('Brazil',     'Brasilia',     4),  -- Country_ID = 4
    ('Australia',  'Canberra',     5),  -- Country_ID = 5
    ('Japan',      'Tokyo',        1),  -- Country_ID = 6
    ('Turkey',     'Ankara',       3);  -- Country_ID = 7
GO
 -- INSERT: TERRAIN TYPES
INSERT INTO TerrainType (Terrain_Type) VALUES
    ('Urban'),         -- TerrainType_ID = 1
    ('Desert'),        -- TerrainType_ID = 2
    ('Forest'),        -- TerrainType_ID = 3
    ('Mountain'),      -- TerrainType_ID = 4
    ('Coastal'),       -- TerrainType_ID = 5
    ('Agricultural'),  -- TerrainType_ID = 6
    ('Wetland');       -- TerrainType_ID = 7
GO
 -- INSERT: SATELLITES
INSERT INTO Satellite (Sat_Name, Launch_Year, Orbit, Model) VALUES
    ('Landsat 8',   2013, 'LEO', 'OLI-TIRS'),      -- Sat_ID = 1
    ('Landsat 9',   2021, 'LEO', 'OLI-2 TIRS-2'),  -- Sat_ID = 2
    ('Sentinel-2A', 2015, 'SSO', 'MSI'),            -- Sat_ID = 3
    ('Sentinel-2B', 2017, 'SSO', 'MSI'),            -- Sat_ID = 4
    ('SPOT-7',      2014, 'SSO', 'Naomi'),          -- Sat_ID = 5
    ('WorldView-3', 2014, 'LEO', 'WV110'),          -- Sat_ID = 6
    ('IKONOS-2',    1999, 'SSO', 'OSA'),            -- Sat_ID = 7
    ('Pleiades-1A', 2011, 'SSO', 'HiRI'),           -- Sat_ID = 8
    ('PAKSAT-MM1',  2011, 'GEO', 'DFH-4'),          -- Sat_ID = 9
    ('Suomi NPP',   2011, 'SSO', 'VIIRS');          -- Sat_ID = 10
GO
 -- INSERT: LOCATIONS 
-- Pakistan (Country_ID=1) → Loc_ID 1-7
INSERT INTO Location (Country_ID, TerrainType_ID, Loc_Name, Latitude, Longitude) VALUES
    (1, 1, 'Karachi Urban Zone',        24.860966,  67.010011),  -- Loc 1
    (1, 4, 'Karakoram Range - K2 Base', 35.881000,  76.513000),  -- Loc 2
    (1, 2, 'Cholistan Desert',          28.399000,  70.924000),  -- Loc 3
    (1, 2, 'Thar Desert',               25.238000,  62.512000),  -- Loc 4
    (1, 3, 'Margalla Hills Forest',     33.730000,  73.040000),  -- Loc 5
    (1, 5, 'Gwadar Port',               25.126400, 62.322800),    -- Lac 6
    (1, 7, 'Indus Delta Wetlands',      24.083000,  67.416000);  -- Loc 7
 
-- China (Country_ID=2) → Loc_ID 8-14
INSERT INTO Location (Country_ID, TerrainType_ID, Loc_Name, Latitude, Longitude) VALUES
    (2, 1, 'Shanghai Metropolitan Area',    31.230000, 121.473000),  -- Loc 8
    (2, 2, 'Gobi Desert - Inner Mongolia',  42.500000, 102.000000),  -- Loc 9
    (2, 4, 'Tibetan Plateau Highlands',     31.000000,  89.000000),  -- Loc 10
    (2, 3, 'Yunnan Rainforest',             22.000000, 101.000000),  -- Loc 11
    (2, 5, 'Pearl River Delta Coastline',   22.270000, 114.165000),  -- Loc 12
    (2, 6, 'Yangtze River Plains',          30.600000, 114.300000),  -- Loc 13
    (2, 7, 'Poyang Lake Wetlands',          29.100000, 116.200000);  -- Loc 14
 
-- USA (Country_ID=3) → Loc_ID 15-21
INSERT INTO Location (Country_ID, TerrainType_ID, Loc_Name, Latitude, Longitude) VALUES
    (3, 1, 'New York City - Manhattan',   40.712776,  -74.005974),  -- Loc 15
    (3, 2, 'Mojave Desert',              35.000000, -116.000000),  -- Loc 16
    (3, 4, 'Rocky Mountains - Colorado', 39.550000, -105.783000),  -- Loc 17
    (3, 3, 'Pacific Northwest Forest',   47.500000, -122.000000),  -- Loc 18
    (3, 5, 'Florida Coastline',          25.760000,  -80.190000),  -- Loc 19
    (3, 6, 'Iowa Corn Belt',             42.000000,  -93.600000),  -- Loc 20
    (3, 7, 'Mississippi River Delta',    29.150000,  -89.250000);  -- Loc 21
 
-- Brazil (Country_ID=4) → Loc_ID 22-27
INSERT INTO Location (Country_ID, TerrainType_ID, Loc_Name, Latitude, Longitude) VALUES
    (4, 1, 'Guanabara Bay',    -23.550000, -46.633000),  -- Loc 22
    (4, 3, 'Amazon Rainforest Core',     -3.100000, -60.020000),  -- Loc 23
    (4, 5, 'Rio de Janeiro Coastline',  -22.908000, -43.171000),  -- Loc 24
    (4, 4, 'Serra do Mar Mountains',    -23.500000, -46.000000),  -- Loc 25
    (4, 6, 'Cerrado Agricultural Zone', -16.000000, -49.000000),  -- Loc 26
    (4, 7, 'Pantanal Wetlands',         -17.000000, -57.000000);  -- Loc 27
 
-- Australia (Country_ID=5) → Loc_ID 28-33
INSERT INTO Location (Country_ID, TerrainType_ID, Loc_Name, Latitude, Longitude) VALUES
    (5, 1, 'Sydney Metropolitan Area',  -33.868820, 151.209290),  -- Loc 28
    (5, 2, 'Simpson Desert',            -25.000000, 137.000000),  -- Loc 29
    (5, 3, 'Daintree Rainforest',       -16.170000, 145.420000),  -- Loc 30
    (5, 5, 'Great Barrier Reef Coast',  -18.286000, 147.700000),  -- Loc 31
    (5, 4, 'Australian Alps',           -36.450000, 148.263000),  -- Loc 32
    (5, 6, 'Murray-Darling Farmland',   -35.100000, 143.500000);  -- Loc 33
 
-- Japan (Country_ID=6) → Loc_ID 34-39
INSERT INTO Location (Country_ID, TerrainType_ID, Loc_Name, Latitude, Longitude) VALUES
    (6, 1, 'Tokyo Urban Sprawl',            35.689487, 139.691711),  -- Loc 34
    (6, 4, 'Mount Fuji Region',             35.362222, 138.730000),  -- Loc 35
    (6, 3, 'Aokigahara Forest',             35.452000, 138.623000),  -- Loc 36
    (6, 5, 'Osaka Bay Coastline',           34.680000, 135.522000),  -- Loc 37
    (6, 6, 'Hokkaido Agricultural Plains',  43.000000, 143.000000),  -- Loc 38
    (6, 7, 'Kushiro Wetlands',              43.050000, 144.400000);  -- Loc 39
 
-- Turkey (Country_ID=7) → Loc_ID 40-46
INSERT INTO Location (Country_ID, TerrainType_ID, Loc_Name, Latitude, Longitude) VALUES
    (7, 1, 'Istanbul Metropolitan Area', 41.015137,  28.979530),  -- Loc 40
    (7, 4, 'Mount Ararat Region',        39.701889,  44.298056),  -- Loc 41
    (7, 2, 'Central Anatolia Steppe',    38.700000,  33.000000),  -- Loc 42
    (7, 5, 'Aegean Coastline - Izmir',   38.423100,  27.142800),  -- Loc 43
    (7, 3, 'Kure Mountains Forest',      41.800000,  33.600000),  -- Loc 44
    (7, 6, 'Konya Plain Agricultural',   37.874000,  32.493000),  -- Loc 45
    (7, 7, 'Lake Van Wetlands',          38.620000,  43.020000);  -- Loc 46
GO
 
-- ============================================================
-- INSERT: SATELLITE IMAGES
-- ============================================================
 
-- PAKISTAN 
INSERT INTO Satellite_Image (Loc_ID, Sat_ID, Capture_Year, Image_Path, Description) VALUES
(1, 1, 2019, 'Images\Pakistan\Urban\Karachi.png',
 'Karachi metropolitan area - Landsat 8 false-colour composite showing urban expansion along Arabian Sea coast.'),
(2, 2, 2022, 'Images\Pakistan\Mountain\K2.png',
 'K2 and Baltoro Glacier - Landsat 9 winter capture showing glacial retreat indicators.'),
(2, 3, 2021, 'Images\Pakistan\Mountain\Karakoram.png',
 'Karakoram Range snowpack - Sentinel-2A SWIR band composite for snow-ice discrimination.'),
(3, 1, 2018, 'Images\Pakistan\Desert\Cholistan.png',
 'Cholistan Desert sand dunes and Fort Derawar - Landsat 8 NDVI analysis capture.'),
(4, 4, 2023, 'Images\Pakistan\Desert\Thar.png',
 'Thar Desert - Sentinel-2B showing Thar Desert boundaries.'),
(6, 1, 2020, 'Images\Pakistan\Coastal\Gawadar_port.png',
 'Gwadar Port and Makran Coastline - Landsat 8 showing CPEC development footprint.'),
(5, 3, 2022, 'Images\Pakistan\Forest\Margala_Hills.png',
 'Margalla Hills National Park - Sentinel-2A NDVI for forest health assessment.'),
(7, 1, 2019, 'Images\Pakistan\Wetland\indus_river.png',
 'Indus River Delta mangrove cover - Landsat 8 showing mangrove loss 2000-2019.');
 
-- CHINA 
INSERT INTO Satellite_Image (Loc_ID, Sat_ID, Capture_Year, Image_Path, Description) VALUES
(8,  1, 2020, 'Images\China\Urban\shanghai cbd and pudong.jfif',
 'Shanghai CBD and Pudong - Landsat 8 urban heat island composite.'),
(8,  6, 2022, 'Images\China\Urban\Shanghai_port2.jpg',
 'Shanghai port expansion - WorldView-3 high-res harbour monitoring.'),
(9,  1, 2021, 'Images\China\Desert\gobi desert solar farm clusters.png',
 'Gobi Desert solar farm clusters - Landsat 8 shortwave infrared.'),
(10, 2, 2022, 'Images\China\Mountains\tibetan plateau.webp',
 'Tibetan Plateau permafrost - Landsat 9 thermal band ground temperature analysis.'),
(10, 3, 2021, 'Images\China\Mountains\Satellite-image-of-Qinghai-Lake.webp',
 'Qinghai Lake basin - Sentinel-2A seasonal lake level monitoring.'),
(11, 3, 2022, 'Images\China\Forest\Yunnan.png',
 'Yunnan tropical forest - Sentinel-2A chlorophyll fluorescence composite.'),
(12, 1, 2020, 'Images\China\Coastal\pearl river.jpg',
 'Pearl River Delta reclaimed land - Landsat 8 20-year coastal change study.'),
(13, 3, 2023, 'Images\China\Agriculture\hubei rice.jfif',
 'Hubei rice paddy calendar - Sentinel-2B 10m resolution multi-temporal.'),
(14, 1, 2021, 'Images\China\Wetland\poyang lake.png',
 'Poyang Lake water-level recession - Landsat 8 seasonal wetland monitoring.');
-- Image_ID 12-21 used
 
-- USA (Loc 15-21) → Image_ID 24-36
INSERT INTO Satellite_Image (Loc_ID, Sat_ID, Capture_Year, Image_Path, Description) VALUES
(15, 1, 2020, 'Images\USA\Urban\New_York.jpeg',
 'New York City - Landsat 8 true-colour composite showing urban heat signature.'),
(15, 6, 2022, 'Images\USA\Urban\Mahantan.png',
 'Manhattan island - WorldView-3 sub-meter building footprint extraction.'),
(16, 1, 2021, 'Images\USA\Desert\Mojave.jpeg',
 'Mojave National Preserve - Landsat 8 geomorphological mapping.'),
(16, 3, 2022, 'Images\USA\Desert\Solar_Farm.png',
 'Solar farms in Mojave - Sentinel-2A albedo change study.'),
(17, 2, 2022, 'Images\USA\Mountain\Colorado_Rockies_snowpack.png',
 'Colorado Rockies snowpack - Landsat 9 February snow-water equivalent proxy.'),
(17, 3, 2021, 'Images\USA\Mountain\Rocky.jpeg',
 'Rocky Mountain National Park - Sentinel-2A forest fire scar mapping.'),
(18, 3, 2022, 'Images\USA\Forest\Olympic_peninsula.png',
 'Olympic Peninsula old-growth - Sentinel-2A forest carbon stock estimation.'),
(18, 1, 2019, 'Images\USA\Forest\Pacific.png',
 'Pacific Northwest logging activity - Landsat 8 deforestation tracking 2019.'),
(19, 1, 2021, 'Images\USA\Coastal\Florida.png',
 'Florida Keys reef system - Landsat 8 coral bleaching event 2021.'),
(19, 3, 2023, 'Images\USA\Coastal\Miami.jpeg',
 'Miami Beach shoreline erosion - Sentinel-2A NDWI coastal change detection.'),
(20, 3, 2022, 'Images\USA\Agriculture\Iowa.png',
 'Iowa cornfields - Sentinel-2A EVI time series for yield prediction.'),
(21, 1, 2021, 'Images\USA\Wetland\Ricer_Delta.png',
 'Mississippi River Delta - Landsat 8 sediment plume and wetland loss analysis.'),
(21, 3, 2022, 'Images\USA\Wetland\Atchafalaya.png',
 'Atchafalaya Basin - Sentinel-2A seasonal inundation mapping.');
-- Image_ID 22-34 used
 
-- BRAZIL (Loc 22-27) 
INSERT INTO Satellite_Image (Loc_ID, Sat_ID, Capture_Year, Image_Path, Description) VALUES
(23, 1, 2020, 'Images\Brazil\Forest\Amazon_RainForest.png',
 'Amazon - Landsat 8 2020 fire scar mapping (record burn year).'),
(24, 3, 2022, 'Images\Brazil\Coastal\Rio_de_Janeiro.png',
 'Rio de Janeiro coastline - Sentinel-2A coastal urban expansion monitoring.'),
(26, 4, 2023, 'Images\Brazil\Agriculture\Cerrado.png',
 'Cerrado Agricultural Zone - Sentinel-2B crop monitoring and land-use classification.'),
(22, 1, 2022, 'Images\Brazil\Coastal\Guanabara_Bay.png',
 'Guanabara Bay - Landsat 8 water quality index for Rio 2022.'),
(25, 3, 2021, 'Images\Brazil\Mountain\Serra_Do_Mar.png',
 'Serra do Mar escarpment - Sentinel-2A landslide risk zonation.'),
(27, 1, 2020, 'Images\Brazil\Wetland\Pantanal.png',
 'Pantanal fire 2020 - Landsat 8 largest wetland fire on record.');
 
-- AUSTRALIA (Loc 28-33) 
INSERT INTO Satellite_Image (Loc_ID, Sat_ID, Capture_Year, Image_Path, Description) VALUES
(28, 3, 2022, 'Images\Australia\Urban\Greater_Sydney.jpeg',
 'Greater Sydney - Sentinel-2A impervious surface expansion 2000-2022.'),
(29, 1, 2021, 'Images\Australia\Desert\Simpson.png',
 'Simpson Desert longitudinal dunes - Landsat 8 dune mobility study.'),
(30, 3, 2022, 'Images\Australia\Forest\Daintree.png',
 'Daintree Rainforest canopy - Sentinel-2A habitat connectivity analysis.'),
(31, 4, 2022, 'Images\Australia\Coastal\Greater_Barrier_Reef.jpeg',
 'Great Barrier Reef 2022 bleaching event - Sentinel-2B coral health index.'),
(32, 2, 2022, 'Images\Australia\Mountain\Snowy.png',
 'Snowy Mountains ski region - Landsat 9 snow season duration change.'),
(33, 1, 2022, 'Images\Australia\Agriculture\irrigation.png',
 'Murray-Darling irrigation - Landsat 8 water allocation vs crop stress.');
-- Image_ID 47-53 used
 
-- JAPAN (Loc 34-39) 
INSERT INTO Satellite_Image (Loc_ID, Sat_ID, Capture_Year, Image_Path, Description) VALUES
(34, 3, 2022, 'Images\Japan\Urban\Tokyo.png',
 'Tokyo Greater Metropolitan - Sentinel-2A urban heat island and green space.'),
(35, 2, 2022, 'Images\Japan\Mountain\Mount_Fuji.png',
 'Mount Fuji snowcap - Landsat 9 annual snowmelt timing analysis.'),
(35, 3, 2021, 'Images\Japan\Mountain\Fuji_Five_Lakes.png',
 'Fuji Five Lakes - Sentinel-2A volcanic geology mapping.'),
(36, 3, 2022, 'Images\Japan\Forest\Aokighara.png',
 'Aokigahara (Sea of Trees) - Sentinel-2A forest biomass estimation on lava field.'),
(37, 3, 2023, 'Images\Japan\Coastal\Osaka_bay.png',
 'Osaka Bay - Sentinel-2B coastal sedimentation and port extension monitoring.'),
(38, 3, 2022, 'Images\Japan\Agriculture\Hokkaido.png',
 'Hokkaido potato and wheat fields - Sentinel-2A crop classification map.'),
(39, 3, 2022, 'Images\Japan\Wetland\Kushiro_Marsh_Ramsar_Site.png',
 'Kushiro Marsh Ramsar Site - Sentinel-2A Japanese crane habitat monitoring.');
 
-- TURKEY (Loc 40-46) 
INSERT INTO Satellite_Image (Loc_ID, Sat_ID, Capture_Year, Image_Path, Description) VALUES
(40, 1, 2020, 'Images\Turkey\Urban\istanbol metropolitan.webp',
 'Istanbul metropolitan area spanning two continents - Landsat 8 urban land-use classification 2020.'),
(40, 3, 2023, 'Images\Turkey\Urban\Istanbul bosphoras.webp',
 'Istanbul Bosphorus corridor - Sentinel-2A high-res true colour for bridge and canal infrastructure monitoring.'),
(41, 2, 2022, 'Images\Turkey\Mountain\mount ararat.jpg',
 'Mount Ararat (5137 m) volcanic cone - Landsat 9 glacial cap extent measurement, summer 2022.'),
(41, 3, 2021, 'Images\Turkey\Mountain\taurus mountains.jpg',
 'Eastern Taurus Mountains snowpack - Sentinel-2A SWIR composite for snow water equivalent proxy.'),
(42, 1, 2021, 'Images\Turkey\Desert\karapinar.png',
 'Karapinar semi-arid steppe - Landsat 8 dust storm tracking and desertification front mapping.'),
(42, 4, 2023, 'Images\Turkey\Desert\salt lake.jpg',
 'Salt Lake (Tuz Golu) basin - Sentinel-2B evaporite mineral mapping using SWIR bands.'),
(43, 3, 2022, 'Images\Turkey\Coastal\izmir bay.png',
 'Izmir Bay and Cesme Peninsula - Sentinel-2A coastal water turbidity and tourist development analysis.'),
(43, 1, 2020, 'Images\Turkey\Coastal\aegean coastline.jpg',
 'Aegean coastline marine protected area - Landsat 8 seagrass bed health assessment 2020.'),
(44, 3, 2022, 'Images\Turkey\Forest\kure mountains.jpg',
 'Kure Mountains National Park old-growth - Sentinel-2A forest canopy density and biodiversity proxy.'),
(44, 1, 2019, 'Images\Turkey\Forest\anatolia.webp',
 'Northern Anatolia Black Sea forests - Landsat 8 wildfire scar mapping post-2019 season.'),
(45, 3, 2022, 'Images\Turkey\Agriculture\konya fields.jfif',
 'Konya Plain grain fields - Sentinel-2A multi-temporal NDVI for wheat and sugar beet crop calendar.'),
(45, 1, 2021, 'Images\Turkey\Agriculture\konya irrigation scheme.webp',
 'Konya irrigation scheme - Landsat 8 water stress index mapping during drought year 2021.'),
(46, 1, 2021, 'Images\Turkey\Wetland\lakeVan.jpg',
 'Lake Van saline lake and shoreline wetlands - Landsat 8 alkaline water quality and flamingo habitat mapping.'),
(46, 3, 2023, 'Images\Turkey\Wetland\shoreline wetlands.jpg',
 'Lake Van water level change 2021-2023 - Sentinel-2A NDWI lake surface area comparison showing 2m rise.');

GO 
-- ============================================================
-- INSERT: USERS
-- ============================================================
INSERT INTO [User] (User_Name, Email, Password, Role) VALUES
    ('admin_aiman',   'aiman.atif@university.edu.pk',
     '8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918', 'admin'),
    ('analyst_sara',  'sara.khan@university.edu.pk',
     '9F86D081884C7D659A2FEAA0C55AD015A3BF4F1B2B0B822CD15D6C15B0F00A08', 'analyst'),
    ('analyst_usman', 'usman.malik@university.edu.pk',
     '03AC674216F3E15C761EE1A5E255F067953623C8B388B4459E13F978D7C846F4', 'analyst'),
    ('viewer_ali',    'ali.raza@student.edu.pk',
     '9F86D081884C7D659A2FEAA0C55AD015A3BF4F1B2B0B822CD15D6C15B0F00A08', 'viewer'),
    ('viewer_fatima', 'fatima.noor@student.edu.pk',
     '03AC674216F3E15C761EE1A5E255F067953623C8B388B4459E13F978D7C846F4', 'viewer');
GO
 
-- ============================================================
-- VIEWS
-- ============================================================
CREATE OR ALTER VIEW vw_ImageDetail AS
SELECT
    si.Image_ID,
    si.Image_Path,
    si.Capture_Year,
    si.Description,
    l.Loc_Name,
    l.Latitude,
    l.Longitude,
    tt.Terrain_Type,
    c.Country_Name,
    c.Capital,
    co.Continent_Name,
    s.Sat_Name,
    s.Launch_Year AS Sat_LaunchYear,
    s.Orbit,
    s.Model       AS Sat_Model
FROM Satellite_Image si
JOIN Location        l  ON si.Loc_ID        = l.Loc_ID
JOIN Country         c  ON l.Country_ID     = c.Country_ID
JOIN Continent       co ON c.Continent_ID   = co.Continent_ID
JOIN TerrainType     tt ON l.TerrainType_ID = tt.TerrainType_ID
JOIN Satellite       s  ON si.Sat_ID        = s.Sat_ID;
GO
 
CREATE OR ALTER VIEW vw_CountryImageCount AS
SELECT
    c.Country_Name,
    co.Continent_Name,
    COUNT(si.Image_ID) AS Total_Images
FROM Country          c
JOIN Continent        co ON c.Continent_ID = co.Continent_ID
LEFT JOIN Location    l  ON l.Country_ID   = c.Country_ID
LEFT JOIN Satellite_Image si ON si.Loc_ID  = l.Loc_ID
GROUP BY c.Country_Name, co.Continent_Name;
GO
 