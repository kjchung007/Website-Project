<?php
session_start();
header('Content-Type: application/json');
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once 'connect.php';

// Check if user is logged in
if (!isset($_SESSION['member_id'])) {
    http_response_code(401);
    echo json_encode(['error' => 'User not logged in']);
    exit();
}

$member_id = $_SESSION['member_id'];

// Handle GET request (fetch cart items)
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    try {
        $query = "SELECT DISTINCT c.*, p.name as product_name, p.image as product_image 
                 FROM cart c 
                 JOIN products p ON c.product_id = p.id 
                 WHERE c.member_id = ? AND c.status = 'pending'
                 ORDER BY c.id ASC";
        
        $stmt = $conn->prepare($query);
        if (!$stmt) {
            throw new Exception("Query preparation failed: " . $conn->error);
        }
        
        $stmt->bind_param("i", $member_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $cartItems = $result->fetch_all(MYSQLI_ASSOC);
        
        $subtotal = 0;
        foreach ($cartItems as &$item) {
            $item['product_image'] = '../Image/' . $item['product_image'];
            $subtotal += floatval($item['price']);
        }
        
        $discount = 0;
        $total = $subtotal;
        
        echo json_encode([
            'items' => $cartItems,
            'subtotal' => $subtotal,
            'discount' => $discount,
            'total' => $total
        ]);
        
    } catch (Exception $e) {
        error_log("Error: " . $e->getMessage());
        http_response_code(500);
        echo json_encode(['error' => 'Failed to load cart items']);
    }
}

// Handle POST request (remove and update items)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    try {
        // Handle remove action
        if ($_POST['action'] === 'remove') {
            if (!isset($_POST['cart_id'])) {
                throw new Exception('Cart ID is required');
            }
            
            $cart_id = intval($_POST['cart_id']);
            
            // Log the removal attempt
            error_log("Attempting to remove cart item: " . $cart_id);
            
            // Verify the cart item belongs to the logged-in user
            $verify_query = "SELECT id FROM cart WHERE id = ? AND member_id = ? AND status = 'pending'";
            $verify_stmt = $conn->prepare($verify_query);
            $verify_stmt->bind_param("ii", $cart_id, $member_id);
            $verify_stmt->execute();
            $verify_result = $verify_stmt->get_result();
            
            if ($verify_result->num_rows === 0) {
                error_log("Cart item not found or unauthorized: " . $cart_id);
                throw new Exception('Cart item not found or unauthorized');
            }
            
            // Delete the cart item
            $delete_query = "DELETE FROM cart WHERE id = ? AND member_id = ?";
            $delete_stmt = $conn->prepare($delete_query);
            $delete_stmt->bind_param("ii", $cart_id, $member_id);
            
            if (!$delete_stmt->execute()) {
                error_log("Failed to delete cart item: " . $delete_stmt->error);
                throw new Exception('Failed to delete cart item');
            }
            
            error_log("Successfully removed cart item: " . $cart_id);
            
            // Get updated cart totals
            $totals_query = "SELECT 
                SUM(quantity * price) as subtotal,
                COUNT(*) as item_count
                FROM cart 
                WHERE member_id = ? AND status = 'pending'";
            $totals_stmt = $conn->prepare($totals_query);
            $totals_stmt->bind_param("i", $member_id);
            $totals_stmt->execute();
            $totals_result = $totals_stmt->get_result()->fetch_assoc();
            
            $subtotal = $totals_result['subtotal'] ?? 0;
            $discount = 0;
            $total = $subtotal - $discount;
            
            echo json_encode([
                'success' => true,
                'message' => 'Item removed successfully',
                'totals' => [
                    'subtotal' => $subtotal,
                    'discount' => $discount,
                    'total' => $total,
                    'item_count' => $totals_result['item_count']
                ]
            ]);
        }

        // Handle update quantity action
        if ($_POST['action'] === 'update') {
            if (!isset($_POST['cart_id']) || !isset($_POST['quantity'])) {
                throw new Exception('Cart ID and quantity are required');
            }
            
            $cart_id = intval($_POST['cart_id']);
            $quantity = intval($_POST['quantity']);
            
            if ($quantity < 1 || $quantity > 10) {
                throw new Exception('Invalid quantity. Must be between 1 and 10.');
            }
            
            // Update the quantity
            $update_query = "UPDATE cart SET quantity = ? 
                           WHERE id = ? AND member_id = ? AND status = 'pending'";
            $update_stmt = $conn->prepare($update_query);
            $update_stmt->bind_param("iii", $quantity, $cart_id, $member_id);
            
            if (!$update_stmt->execute()) {
                throw new Exception('Failed to update quantity');
            }
            
            echo json_encode([
                'success' => true,
                'message' => 'Quantity updated successfully'
            ]);
        }
        
    } catch (Exception $e) {
        error_log("Error in cart operation: " . $e->getMessage());
        http_response_code(500);
        echo json_encode([
            'success' => false,
            'error' => $e->getMessage()
        ]);
    }
}
?>