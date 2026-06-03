<?php
require_once 'db_connect.php';

$input    = json_decode(file_get_contents("php://input"), true);
$email    = $conn->real_escape_string($input['email']);
$password = $input['password'];

$sql    = "SELECT * FROM User WHERE Email = '$email' LIMIT 1";
$result = $conn->query($sql);

if ($result->num_rows === 1) {
    $user = $result->fetch_assoc();
    if (password_verify($password, $user['Password'])) {
        unset($user['Password']); // never send password back!
        echo json_encode(["success" => true, "user" => $user]);
    } else {
        echo json_encode(["success" => false, "message" => "Wrong password."]);
    }
} else {
    echo json_encode(["success" => false, "message" => "User not found."]);
}
$conn->close();
?>