<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Database connection
require_once 'connect.php';
/*
if ($conn->ping()) {
    echo "Database connection is working";
} else {
    echo "Database connection failed";
}*/

// Query to get orders with their items and customer details
$query = "
    SELECT 
        o.order_id,
        o.order_date,
        m.name AS customer_name,
        oi.product_name,
        oi.quantity,
        oi.unit_price,
        oi.item_total,
        o.total_amount AS order_total
    FROM orders o
    JOIN members m ON o.member_id = m.id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    ORDER BY o.order_date DESC, o.order_id DESC
";

$result = $conn->query($query);

if ($result) {
    $row_count = $result->num_rows;
    error_log("Query returned $row_count rows");
} else {
    error_log("Query failed: " . $conn->error);
    // Set header for error response
    header('HTTP/1.1 500 Internal Server Error');
    echo json_encode(['error' => 'Database query failed']);
    exit;
}

// Group orders by order_id
$orders = [];
while ($row = $result->fetch_assoc()) {
    $orderId = $row['order_id'];
    if (!isset($orders[$orderId])) {
        $orders[$orderId] = [
            'order_id' => $orderId,
            'order_date' => $row['order_date'],
            'customer_name' => $row['customer_name'],
            'order_total' => $row['order_total'],
            'items' => []
        ];
    }
    $orders[$orderId]['items'][] = [
        'product_name' => $row['product_name'],
        'quantity' => $row['quantity'],
        'unit_price' => $row['unit_price'],
        'item_total' => $row['item_total']
    ];
}

// Set header to return JSON
header('Content-Type: application/json');

// Return the orders array as JSON
echo json_encode(array_values($orders));

$conn->close();
?>