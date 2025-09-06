<?php
session_start();
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the posted data from FormData
    $email = $_POST['email'];
    $enteredPin = $_POST['pin'];

    // Debug logging
    error_log("Email from request: " . $email);
    error_log("Session email: " . ($_SESSION['reset_email'] ?? 'not set'));
    error_log("Entered PIN: " . $enteredPin);
    error_log("Session PIN: " . ($_SESSION['verification_code'] ?? 'not set'));

    // Validate session variables
    if (!isset($_SESSION['reset_email'], $_SESSION['verification_code'], $_SESSION['code_timestamp'])) {
        echo json_encode([
            'status' => 'error',
            'message' => 'Session expired. Please request a new verification code.'
        ]);
        exit();
    }

    // Check if the entered email matches the session email
    if ($email !== $_SESSION['reset_email']) {
        echo json_encode([
            'status' => 'error',
            'message' => 'Email mismatch. Please start over.'
        ]);
        exit();
    }

    // Check if the PIN matches
    if ($enteredPin !== $_SESSION['verification_code']) {
        echo json_encode([
            'status' => 'error',
            'message' => 'Incorrect verification code.'
        ]);
        exit();
    }

    // Check if the code has expired (10 minutes)
    if (time() - $_SESSION['code_timestamp'] > 600) {
        echo json_encode([
            'status' => 'error',
            'message' => 'Verification code has expired. Please request a new one.'
        ]);
        exit();
    }

    // If everything is valid
    echo json_encode([
        'status' => 'success',
        'message' => 'Verification successful!'
    ]);
    exit();
}

echo json_encode([
    'status' => 'error',
    'message' => 'Invalid request method.'
]);
exit();
?>