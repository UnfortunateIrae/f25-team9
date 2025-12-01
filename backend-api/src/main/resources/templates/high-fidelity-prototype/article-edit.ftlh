<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Article</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container py-4" style="max-width: 700px;">
    <h2 class="mb-4 text-center">Edit Article</h2>

    <form action="/articles/edit/${article.id}" method="post">

        <div class="mb-3">
            <label class="form-label">Title</label>
            <input name="title" type="text" class="form-control" value="${article.title}" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Content</label>
            <textarea name="content" rows="8" class="form-control" required>${article.content}</textarea>
        </div>

        <button type="submit" class="btn btn-success w-100 mb-2">Update</button>
        <a href="/articles/${article.id}" class="btn btn-secondary w-100">Cancel</a>
    </form>
</div>

</body>
</html>
