<?php
session_start();
require_once 'connect.php';

ini_set('display_errors', 1);
error_reporting(E_ALL);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (!isset($_SESSION['member_id'])) {
        echo "login_required"; 
        exit();
    }

    $member_id = $_SESSION['member_id'];
    
    $required_fields = ['product_id', 'quantity', 'price', 'variant', 'size', 'sugar', 'ice'];
    $missing_fields = [];
    
    foreach ($required_fields as $field) {
        if (!isset($_POST[$field])) {
            $missing_fields[] = $field;
        }
    }
    
    if (!empty($missing_fields)) {
        echo "Missing required fields: " . implode(", ", $missing_fields);
        exit();
    }

    $product_id = intval($_POST['product_id']);
    $quantity = intval($_POST['quantity']);
    $unit_price = floatval($_POST['price']); // This is now the unit price including size adjustment
    $total_price = $unit_price * $quantity;  // Calculate total price
    $variant = trim($_POST['variant']);
    $size = trim($_POST['size']);
    $sugar = trim($_POST['sugar']);
    $ice = trim($_POST['ice']);

    $insert_query = "INSERT INTO cart (member_id, product_id, quantity, price, variant, size, sugar, ice, status) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'pending')";
    
    $stmt = $conn->prepare($insert_query);
    if (!$stmt) {
        echo "Prepare failed: " . $conn->error;
        exit();
    }

    $stmt->bind_param("iiidssss", 
        $member_id, 
        $product_id, 
        $quantity, 
        $total_price,  // Store the total price
        $variant, 
        $size, 
        $sugar, 
        $ice
    );
    
    if ($stmt->execute()) {
        echo "success";
    } else {
        echo "Error: " . $stmt->error;
        error_log("MySQL Error: " . $stmt->error);
    }

    $stmt->close();
    exit();
}

echo "Invalid request";
?>