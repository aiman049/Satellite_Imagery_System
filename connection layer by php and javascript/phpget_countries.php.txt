<?php
require_once 'db_connect.php';

$sql = "SELECT c.Country_ID, c.Country_Name, c.Capital, cn.Continent_Name
        FROM Country c
        JOIN Continent cn ON c.Continent_ID = cn.Continent_ID";

$result = $conn->query($sql);
$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}
echo json_encode($data);
$conn->close();
?>