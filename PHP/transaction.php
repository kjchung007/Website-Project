<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

session_start();
require_once 'connect.php';

try {
    // Add connection check
    if (!isset($conn)) {
        throw new Exception('Database connection not established');
    }

    if ($conn->connect_error) {
        throw new Exception('Connection failed: ' . $conn->connect_error);
    }

    // Add character set
    $conn->set_charset("utf8mb4");

    // Rest of your code remains the same
    $sql = "SELECT 
                o.order_id as transaction_id,
                o.order_date as date,
                m.name as customer,
                m.email as customer_email,
                GROUP_CONCAT(
                    CONCAT(
                        oi.product_name, 
                        ' (Size: ', oi.size,
                        ', Sugar: ', oi.sugar,
                        ', Ice: ', oi.ice,
                        ', Variant: ', oi.variant,
                        ')'
                    ) SEPARATOR '||'
                ) as items,
                o.total_amount as total,
                o.status,
                CASE 
                    WHEN o.order_id % 2 = 0 THEN 'Credit Card'
                    ELSE 'Online Banking'
                END as payment_method
            FROM orders o
            JOIN members m ON o.member_id = m.id
            JOIN order_items oi ON o.order_id = oi.order_id
            GROUP BY o.order_id
            ORDER BY o.order_date DESC";

    $result = $conn->query($sql);

    if (!$result) {
        throw new Exception('Query failed: ' . $conn->error);
    }

    // Rest of your code remains the same
    $transactions = [];
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $items = array_map(function($item) {
                return [
                    'name' => preg_replace('/\s*\(.*\)$/', '', $item),
                    'customization' => preg_match('/\((.*?)\)/', $item, $matches) ? $matches[1] : ''
                ];
            }, explode('||', $row['items']));

            $transactions[] = [
                'id' => 'TRX' . str_pad($row['transaction_id'], 3, '0', STR_PAD_LEFT),
                'date' => $row['date'],
                'customer' => $row['customer'],
                'customerEmail' => $row['customer_email'],
                'items' => $items,
                'total' => floatval($row['total']),
                'paymentMethod' => $row['payment_method'],
                'status' => $row['status']
            ];
        }
    }

    echo json_encode(['success' => true, 'data' => $transactions]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
} finally {
    if (isset($conn)) {
        $conn->close();
    }
}
?>