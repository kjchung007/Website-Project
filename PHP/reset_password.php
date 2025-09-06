<?php
session_start();
require_once 'connect.php';  // Include your database connection file

header('Content-Type: application/json');

// Check if request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the email and new password from the POST data
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $newPassword = mysqli_real_escape_string($conn, $_POST['newPassword']);

    // Check if the email exists in the session (to ensure it's the correct user)
    if ($email !== $_SESSION['reset_email']) {
        echo json_encode([
            'status' => 'error',
            'message' => 'Session expired. Please request a new verification code.'
        ]);
        exit();
    }


    // Prepare the SQL query to update the password in the database
    $query = "UPDATE members SET password = ? WHERE email = ?";
    $stmt = mysqli_prepare($conn, $query);
    mysqli_stmt_bind_param($stmt, "ss", $newPassword, $email);

    if (mysqli_stmt_execute($stmt)) {
        echo json_encode([
            'status' => 'success',
            'message' => 'Your password has been successfully reset.'
        ]);
    } else {
        echo json_encode([
            'status' => 'error',
            'message' => 'Failed to reset password. Please try again.'
        ]);
    }

    // Close database connection
    mysqli_close($conn);
    exit();
}

echo json_encode([
    'status' => 'error',
    'message' => 'Invalid request method.'
]);
exit();
?>
