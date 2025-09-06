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

function validateAdminLogin(event) {
    event.preventDefault();
    
    const email = document.getElementById('loginEmail').value;
    const password = document.getElementById('loginPassword').value;
    const errorMessage = document.getElementById('error-message');
    
    // Create FormData object
    const formData = new FormData();
    formData.append('email', email);
    formData.append('password', password);

    // Send login request to PHP
    fetch('../PHP/admin_login.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())
    .then(data => {
        if (data === 'success') {
            // Redirect to admin dashboard or home page
            window.location.href = '../html/admindashboard.html';
        } else {
            // Alert if the login is unsuccessful
            alert('Incorrect password or email');
            errorMessage.textContent = data;
        }
    })
    .catch(error => {
        console.error('Error:', error);
        errorMessage.textContent = 'An error occurred during login';
    });

    return false;
}