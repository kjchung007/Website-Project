<?php
require_once 'connect.php';
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    $response = ['success' => false, 'message' => ''];

    switch ($action) {
        case 'create':
            $name = $_POST['name'] ?? '';
            $price = $_POST['price'] ?? '';
            $category = $_POST['category'] ?? '';
            
            // Handle file upload
            if (isset($_FILES['image'])) {
                $targetDir = "../Image/";
                $imageFileType = strtolower(pathinfo($_FILES["image"]["name"], PATHINFO_EXTENSION));
                $fileName = uniqid() . '.' . $imageFileType;
                $targetFile = $targetDir . $fileName;
                
                if (move_uploaded_file($_FILES["image"]["tmp_name"], $targetFile)) {
                    // Get the last product ID
                    $result = $conn->query("SELECT MAX(id) as max_id FROM products");
                    $row = $result->fetch_assoc();
                    $newId = $row['max_id'] + 1;
                    
                    $stmt = $conn->prepare("INSERT INTO products (id, name, price, category, image) VALUES (?, ?, ?, ?, ?)");
                    $stmt->bind_param("isdss", $newId, $name, $price, $category, $fileName);
                    
                    if ($stmt->execute()) {
                        $response['success'] = true;
                        $response['message'] = 'Product added successfully';
                        $response['data'] = [
                            'id' => $newId,
                            'name' => $name,
                            'price' => $price,
                            'category' => $category,
                            'image' => $fileName
                        ];
                    } else {
                        $response['message'] = 'Error adding product';
                    }
                    $stmt->close();
                } else {
                    $response['message'] = 'Error uploading image';
                }
            }
            break;

        // Existing update and delete cases remain the same
        case 'update':
            $name = $_POST['name'] ?? '';
            $price = $_POST['price'] ?? '';
            $originalName = $_POST['originalName'] ?? '';

            if (empty($name) || empty($price)) {
                $response['message'] = 'Name and price are required';
                break;
            }

            $stmt = $conn->prepare("UPDATE products SET name = ?, price = ? WHERE name = ?");
            $stmt->bind_param("sds", $name, $price, $originalName);
            
            if ($stmt->execute()) {
                $response['success'] = true;
                $response['message'] = 'Product updated successfully';
            } else {
                $response['message'] = 'Error updating product';
            }
            $stmt->close();
            break;

        case 'delete':
            $name = $_POST['name'] ?? '';
            
            if (empty($name)) {
                $response['message'] = 'Product name is required';
                break;
            }

            $stmt = $conn->prepare("DELETE FROM products WHERE name = ?");
            $stmt->bind_param("s", $name);
            
            if ($stmt->execute()) {
                $response['success'] = true;
                $response['message'] = 'Product deleted successfully';
            } else {
                $response['message'] = 'Error deleting product';
            }
            $stmt->close();
            break;

        default:
            $response['message'] = 'Invalid action';
    }

    echo json_encode($response);
    $conn->close();
    exit;
}

http_response_code(400);
echo json_encode(['success' => false, 'message' => 'Invalid request method']);
$conn->close();
?>