<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Topic</title>
</head>
<body>
<h1>Create New Topic</h1>

<form action="/topics" method="post">
    <label>Name:</label>
    <input type="text" name="name" required />

    <button type="submit">Save</button>
</form>

<a href="/topics">Back</a>
</body>
</html>
