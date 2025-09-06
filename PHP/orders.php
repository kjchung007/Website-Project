<?php
session_start();
require_once 'connect.php';

// Check if user is logged in
if (!isset($_SESSION['member_id'])) {
    echo json_encode(['error' => 'login_required']);
    exit();
}

$member_id = $_SESSION['member_id'];

// Fetch completed orders from cart table
$query = "SELECT c.*, p.name as product_name, p.image as product_image 
          FROM cart c 
          JOIN products p ON c.product_id = p.id 
          WHERE c.member_id = ? AND c.status = 'completed' 
          ORDER BY c.created_at DESC";

$stmt = $conn->prepare($query);
if (!$stmt) {
    echo json_encode(['error' => 'Database error: ' . $conn->error]);
    exit();
}

$stmt->bind_param("i", $member_id);
$stmt->execute();
$result = $stmt->get_result();

$orders = [];
while ($row = $result->fetch_assoc()) {
    $orders[] = [
        'id' => $row['id'],
        'product_name' => $row['product_name'],
        'product_image' => $row['product_image'],
        'price' => $row['price'],
        'quantity' => $row['quantity'],
        'variant' => $row['variant'],
        'size' => $row['size'],
        'sugar' => $row['sugar'],
        'ice' => $row['ice'],
        'created_at' => $row['created_at'],
        'product_id' => $row['product_id']
    ];
}

echo json_encode(['success' => true, 'orders' => $orders]);
$stmt->close();
?>