<?php
session_start();
require_once 'connect.php';

header('Content-Type: application/json');

if (!isset($_SESSION['member_id'])) {
    echo json_encode(['success' => false, 'message' => 'Not logged in']);
    exit;
}

$member_id = $_SESSION['member_id'];
$response = ['success' => false, 'message' => ''];

try {
    $name = $_POST['name'] ?? '';
    $email = $_POST['email'] ?? '';
    $password = $_POST['password'] ?? '';
    
    // Validate required fields
    if (empty($name) || empty($email)) {
        echo json_encode(['success' => false, 'message' => 'Name and email are required']);
        exit;
    }

    // If password is provided, update all fields including password
    if (!empty($password)) {
        $query = "UPDATE members SET name = '$name', email = '$email', password = '$password' 
                 WHERE id = '$member_id'";
    } else {
        // If no password provided, only update name and email
        $query = "UPDATE members SET name = '$name', email = '$email' 
                 WHERE id = '$member_id'";
    }
    
    if (mysqli_query($conn, $query)) {
        // Update session variables
        $_SESSION['member_name'] = $name;
        $_SESSION['member_email'] = $email;
        
        $response['success'] = true;
        $response['message'] = 'Profile updated successfully';
    } else {
        throw new Exception('Failed to update profile');
    }
    
} catch (Exception $e) {
    $response['message'] = $e->getMessage();
}

echo json_encode($response);
mysqli_close($conn);
?>