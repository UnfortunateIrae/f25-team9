<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Articles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">

    <h2 class="text-center mb-4">Articles</h2>

    <a href="/articles/create" class="btn btn-primary mb-3 w-100">Create Article</a>

    <#if articles?? && (articles?size > 0)>
        <#list articles as article>
            <div class="card mb-3 shadow-sm">
                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">${article.title}</h5>
                    <a href="/articles/${article.id}" class="btn btn-sm btn-outline-secondary">View</a>
                </div>
                <div class="card-body">
                    <p>${article.content?truncate(120)}</p>
                    <p class="small text-muted">
                        Written by ${article.writer.name}
                    </p>
                </div>
                <div class="card-footer bg-white d-flex justify-content-between">
                    <a href="/articles/${article.id}/edit" class="btn btn-outline-warning">Edit</a>
                    <form action="/articles/${article.id}/delete" method="post">
                        <button type="submit" class="btn btn-outline-danger">Delete</button>
                    </form>
                </div>
            </div>
        </#list>
    <#else>
        <div class="alert alert-warning text-center">No articles found.</div>
    </#if>

</div>
</body>
</html>
