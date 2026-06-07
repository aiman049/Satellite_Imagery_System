<?php
require_once 'PHP Connection File.php';

$sql = "SELECT c.Country_ID, c.Country_Name, c.Capital, co.Continent_Name
        FROM Country c
        JOIN Continent co ON c.Continent_ID = co.Continent_ID
        ORDER BY c.Country_Name";

$result = $conn->query($sql);
$data   = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}
echo json_encode($data);
$conn->close();
?>