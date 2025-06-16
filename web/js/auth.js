document.addEventListener('DOMContentLoaded', function () {
    const registerForm = document.getElementById('registerForm');
    const passwordInput = document.getElementById('password');
    const confirmPasswordInput = document.getElementById('confirmPassword');
    const togglePasswordButtons = document.querySelectorAll('.toggle-password');

    // Toggle password visibility
    togglePasswordButtons.forEach(button => {
        button.addEventListener('click', function () {
            const input = this.previousElementSibling; // Targeting the input before the button
            const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
            input.setAttribute('type', type);

            // Toggle eye icon
            const eyeIcon = this.querySelector('i');
            eyeIcon.classList.toggle('fa-eye');
            eyeIcon.classList.toggle('fa-eye-slash');
        });
    });

    // Form submission handling
    if (registerForm) {
        registerForm.addEventListener('submit', function (e) {
//            e.preventDefault();

            const formData = new FormData(this);
            const name = formData.get('name');
            const email = formData.get('email');
            const password = formData.get('password');
            const confirmPassword = formData.get('confirmPassword');

            // Validation
            const errorMessage = validateForm(name, email, password, confirmPassword);
            if (errorMessage) {
                showError(errorMessage);
                return;
            }

            // Simulated registration
            console.log('Form submitted successfully:', { name, email, password });

        });
    }



    // Email validation helper
    function validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }

    // Show error message
    function showError(message) {
        const errorContainer = document.querySelector('.error-message');
        if (errorContainer) {
            errorContainer.textContent = message;
        } else {
            const newErrorContainer = document.createElement('div');
            newErrorContainer.className = 'error-message';
            newErrorContainer.style.color = 'var(--primary-color)';
            newErrorContainer.style.marginTop = '1rem';
            newErrorContainer.style.textAlign = 'center';
            newErrorContainer.textContent = message;
            registerForm.insertBefore(newErrorContainer, registerForm.querySelector('button[type="submit"]'));
        }

        // Automatically remove error after 3 seconds
        setTimeout(() => {
            const errorContainer = document.querySelector('.error-message');
            if (errorContainer) errorContainer.remove();
        }, 3000);
    }

    // Simulate registration
    function simulateRegistration() {
        const submitButton = registerForm.querySelector('button[type="submit"]');
        const originalText = submitButton.textContent;

        submitButton.disabled = true;
        submitButton.textContent = 'Đang đăng ký...';

        setTimeout(() => {
            submitButton.disabled = false;
            submitButton.textContent = originalText;
            window.location.href = 'login.jsp';
        }, 1500);
    }
});
