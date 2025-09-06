<?php
session_start();
require_once 'connect.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Simple validation
    if (empty($email) || empty($password)) {
        echo "Email and password are required.";
        exit();
    }

    // Query to check email and password
    $query = "SELECT * FROM members WHERE email = '$email' AND password = '$password'";
    $result = mysqli_query($conn, $query);
    
    if (mysqli_num_rows($result) > 0) {
        $member = mysqli_fetch_assoc($result);
        // Set session variables
        $_SESSION['member_id'] = $member['id'];
        $_SESSION['member_name'] = $member['name'];
        $_SESSION['member_email'] = $member['email'];
        $_SESSION['logged_in'] = true;
        echo "success";
        exit();
    }
    
    echo "Invalid email or password";
    exit();
}

echo "Invalid request";
?>