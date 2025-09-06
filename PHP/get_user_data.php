<?php
session_start();
require_once 'connect.php';

header('Content-Type: application/json');

if (!isset($_SESSION['member_id'])) {
    echo json_encode(['success' => false, 'message' => 'Not logged in']);
    exit;
}

$member_id = $_SESSION['member_id'];
$response = ['success' => false, 'data' => null];

try {
    // Added password to the query
    $query = "SELECT id, name, email, password FROM members WHERE id = '$member_id'";
    $result = mysqli_query($conn, $query);
    
    if ($row = mysqli_fetch_assoc($result)) {
        $response['success'] = true;
        $response['data'] = $row;
    } else {
        $response['message'] = 'User not found';
    }
    
} catch (Exception $e) {
    $response['message'] = $e->getMessage();
}

echo json_encode($response);
mysqli_close($conn);
?>