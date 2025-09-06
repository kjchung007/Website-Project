<?php
// resend_code.php
session_start();
require_once 'connect.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_SESSION['reset_email'] ?? null;
    
    if (!$email) {
        echo json_encode([
            'status' => 'error',
            'message' => 'Email not found in session. Please start over.'
        ]);
        exit();
    }

    // Generate new code
    $verification_code = sprintf("%04d", rand(0, 9999));
    $_SESSION['verification_code'] = $verification_code;
    $_SESSION['code_timestamp'] = time();

    // Send new email
    $to = $email;
    $subject = "Password Reset Verification Code";
    $message = "Your new verification code is: " . $verification_code;
    $headers = "From: noreply@kopipapa.com";

    if(mail($to, $subject, $message, $headers)) {
        echo json_encode([
            'status' => 'success',
            'message' => 'New verification code sent to your email.'
        ]);
    } else {
        echo json_encode([
            'status' => 'error',
            'message' => 'Failed to send new verification code.'
        ]);
    }
}
?>