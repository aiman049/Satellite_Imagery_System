<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
require_once '../config/db.php';

$image_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if (!$image_id) {
    echo json_encode(['success' => false, 'error' => 'Image ID required']);
    exit;
}

$db   = getDB();
$stmt = $db->prepare("SELECT * FROM vw_ImageDetail WHERE Image_ID = ?");
$stmt->bind_param('i', $image_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    echo json_encode(['success' => false, 'error' => 'Image not found']);
} else {
    echo json_encode(['success' => true, 'data' => $result->fetch_assoc()]);
}
$stmt->close();
$db->close();
?>
