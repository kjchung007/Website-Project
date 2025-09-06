function togglePassword(inputId) {
    const passwordInput = document.getElementById(inputId);
    const icon = passwordInput.nextElementSibling;
    
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    } else {
        passwordInput.type = 'password';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    }
}

function validateSignup(event) {
    event.preventDefault();
    
    // Get all form values
    const fullname = document.getElementById('fullname').value;
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    
    // Password validation regex
    const passwordRegex = /^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[A-Za-z0-9!@#$%^&*]{6,12}$/;

    
    // Validate password format
    if (!passwordRegex.test(password)) {
        alert('Password must be 6-12 characters and contain at least one uppercase letter, one number, and one special character');
        return false;
    }
    
    // Validate password match
    if (password !== confirmPassword) {
        alert('Passwords do not match');
        return false;
    }

    // Create FormData object for sending to PHP
    const formData = new FormData();
    formData.append('name', fullname);
    formData.append('email', email);
    formData.append('password', password);

    // Send data to PHP script
    fetch('../PHP/signup.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())
    .then(data => {
        if (data === 'success') {
            alert('Registration successful!');
            window.location.href = '../html/registerS.html';
        } else {
            alert(data); // Show error message from PHP
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred during registration');
    });

    return false;
}


function validateLogin(event) {
    event.preventDefault();
    
    const email = document.getElementById('loginEmail').value;
    const password = document.getElementById('loginPassword').value;

    // Create FormData object for sending to PHP
    const formData = new FormData();
    formData.append('email', email);
    formData.append('password', password);

    // Send data to login PHP script
    fetch('../PHP/login.php', {  // Adjust this path according to your folder structure
        method: 'POST',
        body: formData
    })
    .then(response => response.text())
    .then(data => {
        if (data === 'success') {
            window.location.href = '../html/loginS.html';
        } else {
            alert(data); // Show error message from PHP
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred during login');
    });
    
    return false;
}

function validateForgotPassword(event) {
    event.preventDefault(); // Prevent the form from submitting normally

    const email = document.getElementById('resetEmail').value;
    
    // Simple email validation using regex
    const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    if (!emailPattern.test(email)) {
        alert('Please enter a valid email address.');
        return false;
    }

    // Store email in sessionStorage
    sessionStorage.setItem('userEmail', email);

    // Create FormData object to send the email to the server
    const formData = new FormData();
    formData.append('email', email);

    // Send request to PHP script using Fetch API (AJAX)
    fetch('../PHP/checkemail.php', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        if (data.status === 'success') {
            // Email is already stored in sessionStorage above
            alert(data.message);
            // Redirect to the verification code page
            window.location.href = '../html/forgotpassword2.html';
        } else {
            // If there's an error, remove the email from sessionStorage
            sessionStorage.removeItem('userEmail');
            alert(data.message);
        }
    })
    .catch(error => {
        // If there's an error, remove the email from sessionStorage
        sessionStorage.removeItem('userEmail');
        console.error('Error:', error);
        alert('An error occurred. Please try again.');
    });

    return false;
}


document.addEventListener('DOMContentLoaded', function() {
    // Handle code input fields
    const codeInputs = document.querySelectorAll('.code-input');
    
    codeInputs.forEach((input, index) => {
        input.addEventListener('input', function(e) {
            if (this.value.length === 1) {
                if (index < codeInputs.length - 1) {
                    codeInputs[index + 1].focus();
                }
            }
        });

        input.addEventListener('keydown', function(e) {
            if (e.key === 'Backspace' && !this.value) {
                if (index > 0) {
                    codeInputs[index - 1].focus();
                }
            }
        });
    });
});

function validateVerificationCode(event) {
    event.preventDefault();
    
    const codeInputs = document.querySelectorAll('.code-input');
    const code = Array.from(codeInputs).map(input => input.value).join('');
    
    const formData = new FormData();
    formData.append('verification_code', code);

    fetch('../PHP/verify_code.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            window.location.href = 'reset_password.html';
        } else {
            alert(data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred. Please try again.');
    });

    return false;
}

function resendCode() {
    fetch('../PHP/resend_code.php', {
        method: 'POST'
    })
    .then(response => response.json())
    .then(data => {
        alert(data.message);
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while resending the code.');
    });
}

// Function to validate password reset
function validatePasswordReset(event) {
    event.preventDefault();

    // Get password values
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;

    // Password regex for validation (at least one uppercase, one number, one special character, 6-12 chars)
    const passwordRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{6,12}$/;

    // Validate password format
    if (!passwordRegex.test(newPassword)) {
        alert('Password must be 6-12 characters and contain at least one uppercase letter, one number, and one special character');
        return false;
    }

    // Check if passwords match
    if (newPassword !== confirmPassword) {
        alert('Passwords do not match!');
        return false;
    }

    // Create FormData object
    const formData = new FormData();
    formData.append('newPassword', newPassword);

    // Send request to PHP script using Fetch API
    fetch('../PHP/reset_password.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            alert('Password reset successful!');
            window.location.href = 'forgotpassword4.html';
        } else {
            alert(data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred. Please try again.');
    });

    return false;
}

// Toggle password visibility function (keep your existing function)
function togglePassword(passwordFieldId) {
    const passwordField = document.getElementById(passwordFieldId);
    const passwordIcon = passwordField.nextElementSibling;

    if (passwordField.type === "password") {
        passwordField.type = "text";
        passwordIcon.classList.remove("fa-eye-slash");
        passwordIcon.classList.add("fa-eye");
    } else {
        passwordField.type = "password";
        passwordIcon.classList.remove("fa-eye");
        passwordIcon.classList.add("fa-eye-slash");
    }
}