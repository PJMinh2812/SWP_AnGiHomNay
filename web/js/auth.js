/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


document.addEventListener('DOMContentLoaded', function() {
    // Get form elements
    const loginForm = document.getElementById('loginForm');
    const togglePassword = document.querySelector('.toggle-password');
    const passwordInput = document.getElementById('password');

    // Toggle password visibility
    if (togglePassword) {
        togglePassword.addEventListener('click', function() {
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            
            // Toggle eye icon
            const eyeIcon = this.querySelector('i');
            eyeIcon.classList.toggle('fa-eye');
            eyeIcon.classList.toggle('fa-eye-slash');
        });
    }

    // Handle form submission
    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            e.preventDefault();

            // Get form data
            const formData = new FormData(this);
            const data = {
                email: formData.get('email'),
                password: formData.get('password'),
                remember: formData.get('remember') === 'on'
            };

            // Validate form data
            if (!validateEmail(data.email)) {
                showError('Vui lòng nhập email hợp lệ');
                return;
            }

            if (data.password.length < 6) {
                showError('Mật khẩu phải có ít nhất 6 ký tự');
                return;
            }

            // Here you would typically send the data to your server
            console.log('Form submitted:', data);
            
            // For demo purposes, simulate a successful login
            simulateLogin(data);
        });
    }

    // Email validation helper
    function validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }

    // Show error message
    function showError(message) {
        // Remove any existing error messages
        const existingError = document.querySelector('.error-message');
        if (existingError) {
            existingError.remove();
        }

        // Create and show new error message
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error-message';
        errorDiv.style.color = 'var(--primary-color)';
        errorDiv.style.marginTop = '1rem';
        errorDiv.style.textAlign = 'center';
        errorDiv.textContent = message;

        loginForm.insertBefore(errorDiv, loginForm.querySelector('button[type="submit"]'));

        // Remove error message after 3 seconds
        setTimeout(() => {
            errorDiv.remove();
        }, 3000);
    }

    // Simulate login (demo purposes)
    function simulateLogin(data) {
        // Show loading state
        const submitButton = loginForm.querySelector('button[type="submit"]');
        const originalText = submitButton.textContent;
        submitButton.disabled = true;
        submitButton.textContent = 'Đang đăng nhập...';

        // Simulate API call
        setTimeout(() => {
            // Reset button state
            submitButton.disabled = false;
            submitButton.textContent = originalText;

            // Redirect to home page
            window.location.href = 'index.html';
        }, 1500);
    }
}); 