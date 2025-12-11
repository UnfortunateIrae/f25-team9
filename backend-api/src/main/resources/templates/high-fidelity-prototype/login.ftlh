<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Newsletter</title>
    <link rel="stylesheet" href="/CSS/login.css">
</head>
<body>
<div class="container">
    <div class="brand-header">
        <h1>Newsletter</h1>
        <p>Your customizable news source</p>
    </div>

    <div class="auth-container">
        <div class="auth-box">
            <h2>Login</h2>
            <p class="auth-description">Sign in to access your account</p>
            <form action="/login" method="post">
                <div class="form-group">
                    <input type="text" name="email" placeholder="Email" required>
                </div>
                <div class="form-group">
                    <input type="password" name="password" placeholder="Password" required>
                </div>
                
                <!-- CSRF token -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                
                <button type="submit" class="btn-submit">Login</button>
            </form>

            <!-- Display login error safely -->
            <#if param?? && param.error?has_content>
                <p class="error-msg">Invalid email or password.</p>
            </#if>

            <!-- Display logout message safely -->
            <#if param?? && param.logout?has_content>
                <p class="success-msg">You have been logged out.</p>
            </#if>
        </div>

        <div class="auth-box">
            <h2>Sign Up</h2>
            <p class="auth-description">Create a new customer account</p>
            <form action="/register" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="form-group">
                    <input type="text" name="name" placeholder="Full Name" required>
                </div>
                <div class="form-group">
                    <input type="email" name="email" placeholder="Email" required>
                </div>
                <div class="form-group">
                    <input type="password" name="password" placeholder="Password" required>
                </div>
                <button type="submit" class="btn-submit">Sign Up</button>
            </form>
        </div>
    </div>

    <footer>
        <p>Thank you for getting your news from Customizable Newsletter!</p>
    </footer>
</div>
</body>
</html>
