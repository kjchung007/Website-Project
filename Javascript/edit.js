document.addEventListener('DOMContentLoaded', function() {
    const profileForm = document.getElementById('profileForm');

    // Fetch and display current user data
    fetch('../PHP/get_user_data.php')
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // Fill in the form fields with current data
                document.getElementById('name').value = data.data.name;
                document.getElementById('email').value = data.data.email;
                document.getElementById('password').value = data.data.password;
            } else {
                alert('Failed to load user data. Please try again.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Failed to load user data. Please try again.');
        });

    // Form validation and submission
    profileForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        if (validateForm()) {
            const formData = new FormData(profileForm);
            
            // Show loading state
            const saveButton = document.querySelector('.save-profile-btn');
            const originalText = saveButton.textContent;
            saveButton.textContent = 'Saving...';
            saveButton.disabled = true;

            fetch('../PHP/update_profile.php', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Profile updated successfully!');
                    window.location.href = "../PHP/profile.php";
                } else {
                    alert(data.message || 'An error occurred. Please try again.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred. Please try again.');
            })
            .finally(() => {
                saveButton.textContent = originalText;
                saveButton.disabled = false;
            });
        }
    });

    // Form validation function
    function validateForm() {
        let isValid = true;
        const requiredFields = ['name', 'email', 'password'];
        
        // Password validation regex
        const passwordRegex = /^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[A-Za-z0-9!@#$%^&*]{6,12}$/;
        
        requiredFields.forEach(field => {
            const input = document.getElementById(field);
            const errorSpan = input.nextElementSibling;
            
            if (errorSpan && errorSpan.classList.contains('password-toggle')) {
                return; // Skip password toggle button
            }
            
            if (errorSpan) {
                errorSpan.textContent = '';
            }
            input.classList.remove('error');
            
            if (!input.value.trim()) {
                if (field !== 'password') {
                    showFieldError(input, 'This field is required');
                }
                alert(`${field.charAt(0).toUpperCase() + field.slice(1)} is required!`);
                isValid = false;
                return;
            }

            if (field === 'email') {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(input.value)) {
                    showFieldError(input, 'Please enter a valid email address');
                    alert('Please enter a valid email address!');
                    isValid = false;
                }
            }

            if (field === 'password') {
                const password = input.value;
                let errorMessage = '';

                // Check each requirement separately
                if (password.length < 6 || password.length > 12) {
                    errorMessage += '- Password must be between 6-12 characters\n';
                }
                if (!/(?=.*[A-Z])/.test(password)) {
                    errorMessage += '- Must contain at least one uppercase letter\n';
                }
                if (!/(?=.*[0-9])/.test(password)) {
                    errorMessage += '- Must contain at least one number\n';
                }
                if (!/(?=.*[!@#$%^&*])/.test(password)) {
                    errorMessage += '- Must contain at least one special character (!@#$%^&*)\n';
                }

                if (errorMessage) {
                    // Only show the alert, not the field error
                    alert('Password Requirements:\n' + errorMessage);
                    isValid = false;
                }
            }
        });

        return isValid;
    }

    function showFieldError(input, message) {
        const errorSpan = input.nextElementSibling;
        if (errorSpan && !errorSpan.classList.contains('password-toggle')) {
            errorSpan.textContent = message;
            input.classList.add('error');
        }
    }
});

// Password toggle function
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