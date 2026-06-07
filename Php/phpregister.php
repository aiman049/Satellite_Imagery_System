<?php
require_once 'PHP Connection File.php';

$input = json_decode(file_get_contents("php://input"), true);

if (!$input || empty($input['username']) || empty($input['email']) || empty($input['password'])) {
    echo json_encode(["success" => false, "message" => "All fields are required."]);
    exit;
}

$username = $conn->real_escape_string(trim($input['username']));
$email    = $conn->real_escape_string(trim($input['email']));
$password = strtoupper(hash('sha256', $input['password']));
$role     = "viewer";

// Check if email already exists
$check = $conn->query("SELECT User_ID FROM User WHERE Email = '$email' LIMIT 1");
if ($check->num_rows > 0) {
    echo json_encode(["success" => false, "message" => "Email already registered."]);
    $conn->close();
    exit;
}

// Check if username already exists
$check2 = $conn->query("SELECT User_ID FROM User WHERE User_Name = '$username' LIMIT 1");
if ($check2->num_rows > 0) {
    echo json_encode(["success" => false, "message" => "Username already taken."]);
    $conn->close();
    exit;
}

$sql = "INSERT INTO User (User_Name, Email, Password, Role)
        VALUES ('$username', '$email', '$password', '$role')";

if ($conn->query($sql)) {
    echo json_encode(["success" => true, "message" => "Registration successful. You can now log in."]);
} else {
    echo json_encode(["success" => false, "message" => "Registration failed: " . $conn->error]);
}

$conn->close();
?>