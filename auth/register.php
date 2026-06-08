<?php
session_start();
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(200); exit; }

require_once '../config/db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'error' => 'POST only']);
    exit;
}

$input    = json_decode(file_get_contents('php://input'), true) ?? [];
$username = trim($input['username'] ?? $_POST['username'] ?? '');
$email    = trim($input['email']    ?? $_POST['email']    ?? '');
$password = trim($input['password'] ?? $_POST['password'] ?? '');
$role     = trim($input['role']     ?? $_POST['role']     ?? 'viewer');

if (!$username || !$email || !$password) {
    echo json_encode(['success' => false, 'error' => 'All fields are required']);
    exit;
}
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo json_encode(['success' => false, 'error' => 'Invalid email format']);
    exit;
}
if (strlen($password) < 4) {
    echo json_encode(['success' => false, 'error' => 'Password must be at least 4 characters']);
    exit;
}
if (!in_array($role, ['admin', 'analyst', 'viewer'])) {
    $role = 'viewer';
}

$hashed = strtoupper(hash('sha256', $password));
$db     = getDB();

$check = $db->prepare("SELECT User_ID FROM User WHERE User_Name = ? OR Email = ?");
$check->bind_param('ss', $username, $email);
$check->execute();
$check->store_result();
if ($check->num_rows > 0) {
    echo json_encode(['success' => false, 'error' => 'Username or email already exists']);
    $check->close(); $db->close(); exit;
}
$check->close();

$stmt = $db->prepare("INSERT INTO User (User_Name, Email, Password, Role) VALUES (?, ?, ?, ?)");
$stmt->bind_param('ssss', $username, $email, $hashed, $role);

if ($stmt->execute()) {
    echo json_encode([
        'success' => true,
        'message' => 'Account created successfully',
        'user_id' => $stmt->insert_id,
        'role'    => $role
    ]);
} else {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => 'Registration failed: ' . $db->error]);
}

$stmt->close();
$db->close();
?>
