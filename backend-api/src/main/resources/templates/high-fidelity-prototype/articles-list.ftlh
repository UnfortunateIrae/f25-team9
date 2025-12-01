<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Articles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container py-4">
    <h2 class="text-center mb-4">All Articles</h2>

    <#if articles?? && (articles?size > 0)>
        <#list articles as article>
            <div class="card mb-3 shadow-sm">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="mb-0">${article.title}</h5>
                        <p class="text-muted small mb-0">
                            ${article.content?substring(0, article.content?length > 100 ? 100 : article.content?length)}...
                        </p>
                    </div>
                    <form action="/articles/${article.id}" method="get">
                        <button class="btn btn-sm btn-primary">View</button>
                    </form>
                </div>
            </div>
        </#list>
    <#else>
        <div class="alert alert-info">No articles exist.</div>
    </#if>

    <a href="/topics" class="btn btn-secondary mt-3 w-100">Back to Topics</a>
</div>

</body>
</html>
