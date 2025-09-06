<?php
session_start();
header('Content-Type: application/json');
require_once 'connect.php';

// Function to generate random birthdate between 1970 and 2000
function generateRandomBirthday() {
    $start = strtotime('1970-01-01');
    $end = strtotime('2000-12-31');
    $randomTimestamp = mt_rand($start, $end);
    return date('Y-m-d', $randomTimestamp);
}

// Check if it's a GET (fetch) or POST (update) request
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Fetch members data
    $sql = "SELECT id, name, email, password, created_at, updated_at FROM members";
    $result = $conn->query($sql);

    $members = array();

    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            // Add randomized birthday and phone number
            $row['birthday'] = generateRandomBirthday();  // randomized birthday
            $row['phone'] = "+60 12-345 " . rand(1000, 9999);  // random phone
            $row['status'] = "Active";  // default status
            $members[] = $row;
        }
    }

    echo json_encode($members);
} 
else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        // Get POST data
        $data = json_decode(file_get_contents('php://input'), true);
        
        // Validate required fields
        if (!isset($data['id']) || empty($data['id'])) {
            throw new Exception('Member ID is required');
        }
        
        $sql = "UPDATE members SET ";
        $updateValues = [];
        $params = [];
        
        // Update password if provided (without hashing)
        if (!empty($data['password'])) {
            $updateValues[] = "password = ?";
            $params[] = $data['password'];
        }
        
        // Add updated_at timestamp
        $updateValues[] = "updated_at = NOW()";
        
        // Complete the SQL query
        $sql .= implode(", ", $updateValues);
        $sql .= " WHERE id = ?";
        $params[] = $data['id'];
        
        // Prepare and execute the statement
        $stmt = $conn->prepare($sql);
        if ($stmt) {
            if (!empty($params)) {
                $stmt->bind_param(str_repeat('s', count($params)), ...$params);
            }
            $result = $stmt->execute();
            
            if ($result) {
                echo json_encode([
                    'success' => true,
                    'message' => 'Member updated successfully'
                ]);
            } else {
                throw new Exception('Failed to update member');
            }
        } else {
            throw new Exception('Failed to prepare statement');
        }
    } catch(Exception $e) {
        echo json_encode([
            'success' => false,
            'message' => $e->getMessage()
        ]);
    }
}

$conn->close();
?>