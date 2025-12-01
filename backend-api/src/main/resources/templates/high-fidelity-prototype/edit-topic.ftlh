<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Topic</title>
</head>
<body>
<h1>Edit Topic</h1>

<form action="/topics/${topic.id}/update" method="post">
    <label>Name:</label>
    <input type="text" name="name" value="${topic.name}" required />

    <label>URL:</label>
    <input type="text" name="url" value="${topic.url!}" />

    <button type="submit">Update</button>
</form>

<form action="/topics/${topic.id}/delete" method="post">
    <button type="submit">Delete Topic</button>
</form>

<a href="/topics">Back</a>
</body>
</html>
