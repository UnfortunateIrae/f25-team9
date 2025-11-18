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

    <#if topics?? && (topics?size > 0)>
        <#list topics as topic>
            <div class="card mb-3 shadow-sm">
                <div class="card-header bg-white">
                    <h5 class="mb-0">${topic.name?default("Untitled Topic")}</h5>
                    <#if topic.url??>
                        <a href="${topic.url}" target="_blank" class="small text-decoration-none">(View Source)</a>
                    </#if>
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
