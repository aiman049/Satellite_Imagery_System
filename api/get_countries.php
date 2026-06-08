<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
require_once '../config/db.php';

$db     = getDB();
$result = $db->query("
    SELECT c.Country_ID, c.Country_Name, c.Capital, co.Continent_Name
    FROM Country c
    JOIN Continent co ON c.Continent_ID = co.Continent_ID
    ORDER BY co.Continent_Name, c.Country_Name
");

$countries = [];
while ($row = $result->fetch_assoc()) $countries[] = $row;

echo json_encode(['success' => true, 'data' => $countries]);
$db->close();
?>
