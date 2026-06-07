<?php
require_once 'PHP Connection File.php';

$input = json_decode(file_get_contents("php://input"), true);

if (!$input || empty($input['email']) || empty($input['password'])) {
    echo json_encode(["success" => false, "message" => "Email and password are required."]);
    exit;
}

$email    = $conn->real_escape_string($input['email']);
$password = strtoupper(hash('sha256', $input['password']));

$sql    = "SELECT User_ID, User_Name, Email, Role
           FROM User
           WHERE Email = '$email' AND Password = '$password'
           LIMIT 1";
$result = $conn->query($sql);

if ($result->num_rows === 1) {
    $user = $result->fetch_assoc();
    echo json_encode(["success" => true, "user" => $user]);
} else {
    echo json_encode(["success" => false, "message" => "Invalid email or password."]);
}

$conn->close();
?>