<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="/CSS/login.css">
</head>
<body>
<div id="start">
    <div id="login" class="box">
        <h1>Login</h1>
        <form action="/login" method="post">
            <input type="text" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            
            <!-- CSRF token -->
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            
            <input type="submit" value="Login">
        </form>

        <!-- Display login error safely -->
        <#if param?? && param.error?has_content>
            <p style="color:red;">Invalid email or password.</p>
        </#if>

        <!-- Display logout message safely -->
        <#if param?? && param.logout?has_content>
            <p style="color:green;">You have been logged out.</p>
        </#if>
    </div>

    <div id="signup" class="box">
        <h1>Sign Up</h1>
        <form action="/register" method="post">
            <input type="text" name="name" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Sign Up">
        </form>
    </div>
</div>

<div>
    <h3 class="end">
        Thank you for getting your news from Customizable Newsletter! Click here to learn more about us!
    </h3>
</div>
</body>
</html>
