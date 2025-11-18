<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${topic.name}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-4">
    <h2 class="text-center mb-4">${topic.name}</h2>

    <form action="/articles/create" method="get">
        <input type="hidden" name="topicId" value="${topic.id}">
        <button type="submit" class="btn btn-outline-primary w-100 mb-3">
            Add Article
        </button>
    </form>

    <#if topic.articles?? && (topic.articles?size > 0)>
        <h4 class="mb-3">Articles (${topic.articles?size})</h4>

        <#list topic.articles as article>
            <div class="card mb-3 shadow-sm">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="mb-0">${article.title?default("Untitled Article")}</h5>
                        <p class="text-muted small mb-0">
                            ${article.description?default("")}
                        </p>
                    </div>
                    <div class="d-flex gap-2">
                        <form action="/articles/${article.id}" method="get">
                            <button class="btn btn-sm btn-primary">View</button>
                        </form>
                    </div>
                </div>
            </div>
        </#list>
    <#else>
        <div class="alert alert-info">No articles found for this topic.</div>
    </#if>

    <a href="/topics" class="btn btn-secondary mt-3 w-100">Back to all topics</a>
</div>

</body>
</html>
