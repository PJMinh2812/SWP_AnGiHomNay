# AnGiHomNay - Authentication System

## Overview
This is a Java web application with a complete authentication system including Sign In, Sign Out, Registration, and Password Recovery functionality.

## Features

### 1. Sign In (Đăng nhập)
- **Controller**: `LoginController.java`
- **URL**: `/login`
- **Features**:
  - Email and password validation
  - Remember me functionality with cookies
  - Session management
  - Error handling for invalid credentials
  - Redirect to home page after successful login

### 2. Sign Out (Đăng xuất)
- **Controller**: `LogoutController.java`
- **URL**: `/logout`
- **Features**:
  - Session invalidation
  - Cookie cleanup (remember me)
  - Redirect to login page

### 3. Registration (Đăng ký)
- **Controller**: `RegisterController.java`
- **URL**: `/register`
- **Features**:
  - Comprehensive input validation
  - Email format validation
  - Vietnamese phone number validation
  - Password strength requirements (minimum 6 characters)
  - Password confirmation matching
  - Duplicate email checking
  - Success/error message handling

### 4. Password Recovery (Quên mật khẩu)
- **Controller**: `ForgotPasswordController.java`
- **URL**: `/forgot-password`
- **Features**:
  - Email validation
  - Temporary password generation
  - Database password update
  - Success message with temporary password display

## Database Schema

### Users Table
```sql
CREATE TABLE Users (
    ID INT PRIMARY KEY IDENTITY(1,1),
    UserName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(15),
    Status NVARCHAR(20) DEFAULT 'active',
    CreatedAt TIMESTAMP DEFAULT GETDATE()
);
```

## File Structure

```
src/java/
├── controller/
│   ├── LoginController.java
│   ├── LogoutController.java
│   ├── RegisterController.java
│   └── ForgotPasswordController.java
├── service/
│   └── UserService.java
├── DAO/
│   ├── UserDAO.java
│   └── DBconnection.java
├── model/
│   └── User.java
└── filter/
    └── AuthenticationFilter.java

web/
├── view/authen/
│   ├── login.jsp
│   ├── register.jsp
│   └── forgot.jsp
├── js/
│   └── auth.js
└── WEB-INF/
    └── web.xml
```

## Usage

### 1. Login
1. Navigate to `/view/authen/login.jsp`
2. Enter email and password
3. Optionally check "Remember me"
4. Click "Đăng nhập"

### 2. Register
1. Navigate to `/view/authen/register.jsp`
2. Fill in all required fields:
   - Name (2-50 characters)
   - Email (valid format)
   - Phone number (Vietnamese format)
   - Password (minimum 6 characters)
   - Confirm password
3. Click "Đăng ký"

### 3. Forgot Password
1. Navigate to `/view/authen/forgot.jsp`
2. Enter your email address
3. Click "Gửi yêu cầu"
4. Use the temporary password to login
5. Change password after login

### 4. Logout
1. Click logout link in header or navigate to `/logout`
2. Session and cookies will be cleared
3. Redirected to login page

## Security Features

- Input validation and sanitization
- Session management
- Cookie-based remember me functionality
- Password confirmation validation
- Email format validation
- Phone number format validation
- Duplicate email prevention

## Technical Details

- **Framework**: Jakarta EE (Tomcat 11)
- **Database**: Microsoft SQL Server
- **Frontend**: JSP, CSS, JavaScript
- **Authentication**: Session-based with cookie support
- **Password Storage**: Plain text (should be hashed in production)

## Notes for Production

1. **Password Hashing**: Implement proper password hashing (BCrypt, PBKDF2)
2. **Email Service**: Integrate real email service for password recovery
3. **HTTPS**: Use HTTPS for all authentication pages
4. **Rate Limiting**: Implement rate limiting for login attempts
5. **Logging**: Add proper logging for security events
6. **Input Sanitization**: Enhance input sanitization
7. **CSRF Protection**: Add CSRF tokens to forms

## Error Handling

The system provides user-friendly error messages in Vietnamese:
- Invalid email/password
- Email already exists
- Password confirmation mismatch
- Invalid phone number format
- Email not found (for password recovery)

## Success Messages

- Registration successful
- Password recovery email sent
- Login successful 