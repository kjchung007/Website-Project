<?php
session_start();
require_once 'connect.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);

    // Validate inputs
    if (empty($email) || empty($password)) {
        echo "Email and password are required.";
        exit();
    }

    // Query to check admin credentials
    $query = "SELECT * FROM `admin` WHERE email = '$email' AND password = '$password'";
    $result = mysqli_query($conn, $query);
    
    if (!$result) {
        echo "Database error: " . mysqli_error($conn);
        exit();
    }

    if (mysqli_num_rows($result) > 0) {
        $admin = mysqli_fetch_assoc($result);
        
        // Set session variables
        $_SESSION['admin_id'] = $admin['id'];
        $_SESSION['admin_username'] = $admin['username'];
        $_SESSION['admin_email'] = $admin['email'];
        $_SESSION['is_admin'] = true;
        
        echo "success";
        exit();
    } else {
        echo "Invalid email or password";
        exit();
    }
}

echo "Invalid request method";
?>