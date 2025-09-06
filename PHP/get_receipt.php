<?php
session_start();
require_once 'connect.php';

if (!isset($_GET['order_id']) || !isset($_SESSION['member_id'])) {
    echo json_encode(['error' => 'Invalid request']);
    exit();
}

$query = "SELECT c.*, p.name as product_name, m.name as member_name, m.email 
          FROM cart c 
          JOIN products p ON c.product_id = p.id 
          JOIN members m ON c.member_id = m.id 
          WHERE c.id = ? AND c.member_id = ?";

$stmt = $conn->prepare($query);
$stmt->bind_param("ii", $_GET['order_id'], $_SESSION['member_id']);
$stmt->execute();
$result = $stmt->get_result();
$order = $result->fetch_assoc();

if (!$order) {
    echo json_encode(['error' => 'Order not found']);
    exit();
}

echo json_encode([
    'success' => true,
    'order' => [
        'id' => $order['id'],
        'date' => date('d/m/Y H:i', strtotime($order['created_at'])),
        'customer' => $order['member_name'],
        'email' => $order['email'],
        'product_name' => $order['product_name'],
        'variant' => $order['variant'],
        'size' => $order['size'],
        'sugar' => $order['sugar'],
        'ice' => $order['ice'],
        'quantity' => $order['quantity'],
        'price' => number_format($order['price'], 2)
    ]
]);
?>