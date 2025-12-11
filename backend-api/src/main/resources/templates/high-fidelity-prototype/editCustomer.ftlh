<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Customer</title>
</head>
<body>
    <h1>Edit Your Profile</h1>

    <#-- Display success or error messages -->
    <#if success??>
        <p style="color:green;">Profile updated successfully!</p>
    </#if>
    <#if error??>
        <p style="color:red;">${error}</p>
    </#if>

    <form action="/customer/update/${customer.id}" method="post">
        <!-- CSRF token -->
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

        <label for="name">Full Name:</label>
        <input type="text" id="name" name="name" value="${customer.name!}" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="${customer.email!}" required>

        <label for="phone">Phone Number:</label>
        <input type="text" id="phone" name="phoneNumber" value="${customer.phoneNumber!}" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" placeholder="Leave blank to keep current password">

        <input type="submit" value="Update Profile">
    </form>

    <a href="/">Back to Home</a>
</body>
</html>
