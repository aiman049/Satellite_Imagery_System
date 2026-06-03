<?php
require_once 'db_connect.php';

// Optional filter: ?country_id=3
$where = "";
if (isset($_GET['country_id']) && is_numeric($_GET['country_id'])) {
    $cid = intval($_GET['country_id']);
    $where = "WHERE co.Country_ID = $cid";
}

$sql = "SELECT si.Image_ID, si.Image_Path, si.Description, si.Capture_Year,
               l.Loc_Name, l.Latitude, l.Longitude,
               co.Country_Name, s.Sat_Name, s.Orbit, t.Terrain_Type
        FROM Satellite_Image si
        JOIN Location l        ON si.Loc_ID  = l.Loc_ID
        JOIN Country co        ON l.Country_ID = co.Country_ID
        JOIN Satellite s       ON si.Sat_ID  = s.Sat_ID
        JOIN TerrainType t     ON l.TerrainType_ID = t.TerrainType_ID
        $where";

$result = $conn->query($sql);
$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}
echo json_encode($data);
$conn->close();
?>