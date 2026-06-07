<?php
require_once 'PHP Connection File.php';

$where = "WHERE 1=1";

if (!empty($_GET['country_id']) && is_numeric($_GET['country_id'])) {
    $cid    = intval($_GET['country_id']);
    $where .= " AND c.Country_ID = $cid";
}

if (!empty($_GET['terrain'])) {
    $terrain = $conn->real_escape_string($_GET['terrain']);
    $where  .= " AND tt.Terrain_Type = '$terrain'";
}

if (!empty($_GET['year']) && is_numeric($_GET['year'])) {
    $year   = intval($_GET['year']);
    $where .= " AND si.Capture_Year = $year";
}

$sql = "SELECT
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
            s.Sat_Name,
            s.Orbit,
            s.Model
        FROM Satellite_Image si
        JOIN Location    l  ON si.Loc_ID        = l.Loc_ID
        JOIN Country     c  ON l.Country_ID     = c.Country_ID
        JOIN TerrainType tt ON l.TerrainType_ID = tt.TerrainType_ID
        JOIN Satellite   s  ON si.Sat_ID        = s.Sat_ID
        $where
        ORDER BY tt.Terrain_Type, si.Capture_Year DESC";

$result = $conn->query($sql);
$data   = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}
echo json_encode($data);
$conn->close();
?>