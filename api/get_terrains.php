<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
require_once '../config/db.php';

$db     = getDB();
$result = $db->query("SELECT TerrainType_ID, Terrain_Type FROM TerrainType ORDER BY Terrain_Type");

$terrains = [];
while ($row = $result->fetch_assoc()) $terrains[] = $row;

echo json_encode(['success' => true, 'data' => $terrains]);
$db->close();
?>
