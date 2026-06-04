<?php
require_once 'db_connect.php';

$input = json_decode(file_get_contents("php://input"), true);

$username = $conn->real_escape_string($input['username']);
$email    = $conn->real_escape_string($input['email']);
$password = password_hash($input['password'], PASSWORD_BCRYPT); // hashed!
$role     = "viewer"; // default role

$sql = "INSERT INTO User (User_Name, Email, Password, Role)
        VALUES ('$username', '$email', '$password', '$role')";

if ($conn->query($sql)) {
    echo json_encode(["success" => true, "message" => "User registered."]);
} else {
    echo json_encode(["success" => false, "message" => $conn->error]);
}
$conn->close();
?>