<?php
header('Content-Type: application/json');
require_once 'connect.php';

function getProducts($category) {
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM products WHERE category = ?");
    $stmt->bind_param("s", $category);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_all(MYSQLI_ASSOC);
}

if (isset($_GET['category'])) {
    $category = $_GET['category'];
    $products = getProducts($category);
    echo json_encode($products);
} else {
    echo json_encode(['error' => 'Category not specified']);
}

$conn->close();
?>