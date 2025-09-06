<?php
session_start();
require_once 'connect.php';
require 'PHPMailer/src/Exception.php';
require 'PHPMailer/src/PHPMailer.php';
require 'PHPMailer/src/SMTP.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get email from POST data (FormData)
    $email = mysqli_real_escape_string($conn, $_POST['email']);

    // Check if email exists in the database
    $query = "SELECT * FROM members WHERE email = ?";
    $stmt = mysqli_prepare($conn, $query);
    mysqli_stmt_bind_param($stmt, "s", $email);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    if (mysqli_num_rows($result) > 0) {
        // Generate random 4-digit code
        $verification_code = sprintf("%04d", rand(0, 9999));
        
        // Store in session
        $_SESSION['reset_email'] = $email;
        $_SESSION['verification_code'] = $verification_code;
        $_SESSION['code_timestamp'] = time();

        // Create a new PHPMailer instance
        $mail = new PHPMailer(true);

        try {
            // Server settings
            $mail->isSMTP();
            $mail->Host = 'smtp.gmail.com';
            $mail->SMTPAuth = true;
            $mail->Username = 'kopipapaweb@gmail.com';
            $mail->Password = 'djoe uhdz omqk ries';
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
            $mail->Port = 587;

            // Recipients
            $mail->setFrom('kopipapaweb@gmail.com', 'Kopi Papa');
            $mail->addAddress($email);

            // Content
            $mail->isHTML(true);
            $mail->Subject = 'Password Reset Verification Code';
            $mail->Body = "Your verification code is: <b>$verification_code</b>";
            $mail->AltBody = "Your verification code is: $verification_code";

            $mail->send();
            
            // Debug logging
            error_log("Email sent to: " . $email);
            error_log("Verification code: " . $verification_code);
            
            echo json_encode([
                'status' => 'success', 
                'message' => 'Verification code sent to your email.'
            ]);
        } catch (Exception $e) {
            error_log("Message could not be sent. Mailer Error: {$mail->ErrorInfo}");
            echo json_encode([
                'status' => 'error', 
                'message' => 'Failed to send verification code.'
            ]);
        }
    } else {
        echo json_encode([
            'status' => 'error', 
            'message' => 'No account found with that email address.'
        ]);
    }

    mysqli_close($conn);
    exit();
}
?>