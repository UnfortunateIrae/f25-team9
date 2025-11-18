<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${article.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">

    <h2 class="mb-3">${article.title}</h2>

    <p>${article.content}</p>

    <p class="text-muted">Writer: ${article.writer.name}</p>

    <a href="/articles" class="btn btn-outline-secondary mt-3">Back</a>
    <a href="/articles/${article.id}/edit" class="btn btn-primary mt-3">Edit</a>

</div>
</body>
</html>
