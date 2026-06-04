<?php
$host     = "localhost";
$user     = "root";
$password = "";            // blank by default in XAMPP
$database = "SatelliteIDB";

$conn = new mysqli($host, $user, $password, $database);

if ($conn->connect_error) {
    http_response_code(500);
    die(json_encode(["success" => false, "message" => "DB Connection failed: " . $conn->connect_error]));
}

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
?>