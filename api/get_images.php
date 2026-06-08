<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
require_once '../config/db.php';

$db = getDB();

$country_id   = isset($_GET['country_id'])   ? (int)$_GET['country_id']        : null;
$terrain_type = isset($_GET['terrain_type'])  ? trim($_GET['terrain_type'])      : null;
$year         = isset($_GET['year'])          ? (int)$_GET['year']               : null;
$sat_id       = isset($_GET['satellite_id'])  ? (int)$_GET['satellite_id']       : null;
$search       = isset($_GET['search'])        ? trim($_GET['search'])             : null;

$sql    = "SELECT Image_ID, Image_Path, Capture_Year, Description,
                  Loc_Name, Latitude, Longitude, Terrain_Type,
                  Country_Name, Continent_Name, Sat_Name, Sat_LaunchYear, Orbit, Sat_Model
           FROM vw_ImageDetail WHERE 1=1";
$params = [];
$types  = '';

if ($country_id) {
    $sql .= " AND Country_Name = (SELECT Country_Name FROM Country WHERE Country_ID = ?)";
    $params[] = $country_id; $types .= 'i';
}
if ($terrain_type) {
    $sql .= " AND Terrain_Type = ?";
    $params[] = $terrain_type; $types .= 's';
}
if ($year) {
    $sql .= " AND Capture_Year = ?";
    $params[] = $year; $types .= 'i';
}
if ($sat_id) {
    $sql .= " AND Sat_Name = (SELECT Sat_Name FROM Satellite WHERE Sat_ID = ?)";
    $params[] = $sat_id; $types .= 'i';
}
if ($search) {
    $like = "%$search%";
    $sql .= " AND (Loc_Name LIKE ? OR Description LIKE ? OR Country_Name LIKE ?)";
    $params[] = $like; $params[] = $like; $params[] = $like;
    $types .= 'sss';
}

$sql .= " ORDER BY Country_Name, Terrain_Type, Capture_Year DESC";

$stmt = $db->prepare($sql);
if ($params) $stmt->bind_param($types, ...$params);
$stmt->execute();
$result = $stmt->get_result();

$images = [];
while ($row = $result->fetch_assoc()) $images[] = $row;

echo json_encode(['success' => true, 'count' => count($images), 'data' => $images]);
$stmt->close();
$db->close();
?>
