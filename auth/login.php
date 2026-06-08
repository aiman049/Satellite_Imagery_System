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
$password = trim($input['password'] ?? $_POST['password'] ?? '');

if (!$username || !$password) {
    echo json_encode(['success' => false, 'error' => 'Username and password required']);
    exit;
}

// DB stores SHA-256 in UPPERCASE hex
$hashed = strtoupper(hash('sha256', $password));

$db   = getDB();
$stmt = $db->prepare("SELECT User_ID, User_Name, Email, Role FROM User WHERE User_Name = ? AND Password = ?");
$stmt->bind_param('ss', $username, $hashed);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 1) {
    $user = $result->fetch_assoc();
    $_SESSION['user_id']   = $user['User_ID'];
    $_SESSION['user_name'] = $user['User_Name'];
    $_SESSION['role']      = $user['Role'];
    $_SESSION['email']     = $user['Email'];

    echo json_encode([
        'success'  => true,
        'user_id'  => $user['User_ID'],
        'username' => $user['User_Name'],
        'role'     => $user['Role'],
        'email'    => $user['Email']
    ]);
} else {
    http_response_code(401);
    echo json_encode(['success' => false, 'error' => 'Invalid username or password']);
}

$stmt->close();
$db->close();
?>
