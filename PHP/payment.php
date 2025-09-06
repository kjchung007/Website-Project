<?php
session_start();
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once 'connect.php';

function handleError($message, $code = 400) {
    http_response_code($code);
    echo json_encode(['error' => $message]);
    exit();
}

if (!isset($_SESSION['member_id'])) {
    handleError('User not logged in', 401);
}

$member_id = $_SESSION['member_id'];

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'payment') {
    try {
        // Start transaction
        $conn->begin_transaction();

        // Fetch cart items with precise calculations
        $cart_query = "SELECT c.*, p.price as unit_price, p.name as product_name, 
                      (c.quantity * p.price) as line_total
                      FROM cart c 
                      JOIN products p ON c.product_id = p.id 
                      WHERE c.member_id = ? AND c.status = 'pending'";
        
        $stmt = $conn->prepare($cart_query);
        $stmt->bind_param("i", $member_id);
        $stmt->execute();
        $cart_items = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

        if (empty($cart_items)) {
            $conn->rollback();
            handleError('No items in the cart');
        }

        // Calculate total with precise decimal handling
        $total_amount = 0;
        foreach ($cart_items as $item) {
            $total_amount += floatval($item['line_total']);
        }
        $total_amount = round($total_amount, 2);

        // Log transaction details
        $log_data = [
            'member_id' => $member_id,
            'cart_items' => $cart_items,
            'total_amount' => $total_amount,
            'timestamp' => date('Y-m-d H:i:s')
        ];
        error_log("Payment Processing: " . print_r($log_data, true));

    // Create order
    $insert_order = "INSERT INTO orders (member_id, total_amount) VALUES (?, ?)";
    $stmt = $conn->prepare($insert_order);
    $stmt->bind_param("id", $member_id, $total_amount);
    
    if (!$stmt->execute()) {
        throw new Exception('Failed to create order');
    }
    $order_id = $conn->insert_id;

    // Insert order items
    $insert_items = "INSERT INTO order_items (order_id, product_id, product_name, 
                    quantity, unit_price, item_total, variant, size, sugar, ice) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($insert_items);

    foreach ($cart_items as $item) {
        $stmt->bind_param("iisiddssss", 
            $order_id,
            $item['product_id'],
            $item['product_name'],
            $item['quantity'],
            $item['unit_price'],
            $item['line_total'],
            $item['variant'],
            $item['size'],
            $item['sugar'],
            $item['ice']
        );
        if (!$stmt->execute()) {
            throw new Exception('Failed to add order item');
        }
    }

    // Update cart status
    $update_cart = "UPDATE cart SET status = 'completed' 
                   WHERE member_id = ? AND status = 'pending'";
    $stmt = $conn->prepare($update_cart);
    $stmt->bind_param("i", $member_id);
    
    if (!$stmt->execute()) {
        throw new Exception('Failed to update cart status');
    }

    $conn->commit();
    echo json_encode(['success' => true]);

} catch (Exception $e) {
    $conn->rollback();
    handleError($e->getMessage());
}
} else {
    // Handle GET request for cart data
    try {
        // Get user details
        $user_query = "SELECT name, email FROM members WHERE id = ?";
        $stmt = $conn->prepare($user_query);
        $stmt->bind_param("i", $member_id);
        $stmt->execute();
        $user_result = $stmt->get_result()->fetch_assoc();

        // Get cart items with precise calculations
        $cart_query = "SELECT c.*, p.name as product_name, p.image as product_image, 
                      p.price as unit_price, (c.quantity * p.price) as line_total
                      FROM cart c 
                      JOIN products p ON c.product_id = p.id 
                      WHERE c.member_id = ? AND c.status = 'pending'";
        
        $stmt = $conn->prepare($cart_query);
        $stmt->bind_param("i", $member_id);
        $stmt->execute();
        $cart_items = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

        // Calculate totals with precise decimal handling
        $subtotal = 0;
        foreach ($cart_items as $item) {
            $subtotal += floatval($item['line_total']);
        }
        $subtotal = round($subtotal, 2);

        $data = [
            'user' => $user_result,
            'cart_items' => $cart_items,
            'totals' => [
                'subtotal' => $subtotal,
                'discount' => 0,
                'total' => $subtotal
            ]
        ];

        echo json_encode($data);
        
    } catch (Exception $e) {
        error_log("Cart Data Error: " . $e->getMessage());
        handleError('Failed to fetch cart data: ' . $e->getMessage());
    }
}
?>