<?php
header('Content-Type: application/json');

require_once 'PHP Connection File.php';

$country_id = isset($_GET['country_id'])
    ? intval($_GET['country_id'])
    : 0;

$terrain = isset($_GET['terrain'])
    ? trim($_GET['terrain'])
    : '';

$sql = "
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

    s.Sat_Name,
    s.Orbit,
    s.Model

FROM Satellite_Image si

INNER JOIN Location l
    ON si.Loc_ID = l.Loc_ID

INNER JOIN Country c
    ON l.Country_ID = c.Country_ID

INNER JOIN TerrainType tt
    ON l.TerrainType_ID = tt.TerrainType_ID

INNER JOIN Satellite s
    ON si.Sat_ID = s.Sat_ID

WHERE c.Country_ID = ?
";

if($terrain !== ''){
    $sql .= " AND tt.Terrain_Type = ?";
}

$stmt = $conn->prepare($sql);

if($terrain !== ''){
    $stmt->bind_param("is", $country_id, $terrain);
}
else{
    $stmt->bind_param("i", $country_id);
}

$stmt->execute();

$result = $stmt->get_result();

$data = [];

while($row = $result->fetch_assoc()){
    $data[] = $row;
}

echo json_encode($data);

$stmt->close();
$conn->close();
?>