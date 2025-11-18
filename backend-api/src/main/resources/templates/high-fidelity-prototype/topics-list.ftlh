<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Topics & Writers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-4">
    <h2 class="text-center mb-4">Topics & Writers</h2>

    <form action="/topics/create" method="get">
        <button type="submit" class="btn btn-outline-primary w-100 mb-3">
            Create Topic
        </button>
    </form>

    <#if topics?? && (topics?size > 0)>
        <#list topics as topic>
            <div class="card mb-3 shadow-sm">
                <div class="card-header bg-white d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="mb-0">${topic.name?default("Untitled Topic")}</h5>
                        <#if topic.url??>
                            <a href="${topic.url}" target="_blank" class="small text-decoration-none">
                                (Visit Topic Page)
                            </a>
                        </#if>
                    </div>

                    <div class="d-flex gap-2">
                        <form action="/topics/${topic.id}/edit" method="get">
                            <button class="btn btn-sm btn-warning">Edit</button>
                        </form>

                        <form action="/topics/${topic.id}/delete" method="post"
                              onsubmit="return confirm('Delete topic?');">
                            <button class="btn btn-sm btn-danger">Delete</button>
                        </form>
                    </div>
                </div>

                <div class="card-body">
                    <#if topic.writers?? && (topic.writers?size > 0)>
                        <p class="mb-2">Writers:</p>
                        <div>
                            <#list topic.writers as writer>
                                <span class="badge bg-primary me-1 mb-1">${writer.name?default("Unnamed Writer")}</span>
                            </#list>
                        </div>
                    <#else>
                        <p class="text-muted mb-0">No writers assigned.</p>
                    </#if>
                </div>
            </div>
        </#list>
    <#else>
        <div class="alert alert-warning text-center">No topics found.</div>
    </#if>
</div>

</body>
</html>
