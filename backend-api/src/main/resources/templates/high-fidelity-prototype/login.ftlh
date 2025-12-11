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
            <h2>Customer Login</h2>
            <p class="auth-description">Access your personalized news feed and manage subscriptions</p>
            <form action="/login" method="post">
                <div class="form-group">
                    <input type="text" name="email" placeholder="Email" required>
                </div>
                <div class="form-group">
                    <input type="password" name="password" placeholder="Password" required>
                </div>
                
                <!-- CSRF token -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                
                <button type="submit" class="btn-submit">Login as Customer</button>
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
            <h2>Writer Login</h2>
            <p class="auth-description">Manage your articles and contribute content</p>
            <form action="/login" method="post">
                <div class="form-group">
                    <input type="text" name="email" placeholder="Email" required>
                </div>
                <div class="form-group">
                    <input type="password" name="password" placeholder="Password" required>
                </div>
                
                <!-- CSRF token -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                
                <button type="submit" class="btn-submit btn-writer">Login as Writer</button>
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
    </div>

    <div class="signup-section">
        <div class="auth-box signup-box">
            <h2>New Customer? Sign Up</h2>
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
