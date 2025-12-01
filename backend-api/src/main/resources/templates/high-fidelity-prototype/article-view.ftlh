<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${article.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container py-4" style="max-width: 800px;">
    <h2>${article.title}</h2>
    <p class="text-muted">Author: ${article.writer.name?default("Unknown")}</p>

    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <p class="mb-0" style="white-space: pre-wrap;">${article.content}</p>
        </div>
    </div>

    <div class="d-flex gap-2">
        <form action="/articles/edit/${article.id}" method="get">
            <button class="btn btn-primary w-100">Edit</button>
        </form>

        <form action="/articles/delete/${article.id}" method="post">
            <button class="btn btn-danger w-100"
                    onclick="return confirm('Are you sure you want to delete this article?')">
                Delete
            </button>
        </form>
    </div>

    <a href="/topics/${article.writer.topic.id}" class="btn btn-secondary w-100 mt-3">Back to Topic</a>
</div>

</body>
</html>
