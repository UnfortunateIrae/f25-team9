<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Writers, Topics & Articles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">
<div class="container mt-5">
    <h1 class="mb-4 text-center">Writers, Topics & Articles</h1>

    <#if writers?has_content>
        <#list writers as writer>
            <div class="accordion mb-3" id="accordionWriter${writer.id}">
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingWriter${writer.id}">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseWriter${writer.id}" aria-expanded="false"
                                aria-controls="collapseWriter${writer.id}">
                            ${writer.name}
                        </button>
                    </h2>
                    <div id="collapseWriter${writer.id}" class="accordion-collapse collapse"
                         aria-labelledby="headingWriter${writer.id}" data-bs-parent="#accordionWriter${writer.id}">
                        <div class="accordion-body">
                            <p class="text-muted mb-2">
                                Email: ${writer.email!""},
                                Phone: ${writer.phoneNumber!""},
                                Source: ${writer.sourceName}
                            </p>

                            <#if writer.topics?has_content>
                                <div class="accordion" id="accordionTopics${writer.id}">
                                    <#list writer.topics as topic>
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="headingTopic${topic.id}">
                                                <button class="accordion-button collapsed" type="button"
                                                        data-bs-toggle="collapse"
                                                        data-bs-target="#collapseTopic${topic.id}" aria-expanded="false"
                                                        aria-controls="collapseTopic${topic.id}">
                                                    ${topic.name}
                                                </button>
                                            </h2>
                                            <div id="collapseTopic${topic.id}" class="accordion-collapse collapse"
                                                 aria-labelledby="headingTopic${topic.id}"
                                                 data-bs-parent="#accordionTopics${writer.id}">
                                                <div class="accordion-body">
                                                    <#if topic.articles?has_content>
                                                        <ul class="list-group">
                                                            <#list topic.articles as article>
                                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                                    ${article.title}
                                                                    <span>
                                                                        <a href="/articles/view/${article.id}" class="btn btn-sm btn-info">View</a>
                                                                        <a href="/articles/edit/${article.id}" class="btn btn-sm btn-primary">Edit</a>
                                                                        <a href="/articles/delete/${article.id}" class="btn btn-sm btn-danger"
                                                                           onclick="return confirm('Are you sure you want to delete this article?');">
                                                                            Delete
                                                                        </a>
                                                                    </span>
                                                                </li>
                                                            </#list>
                                                        </ul>
                                                    <#else>
                                                        <p class="text-muted fst-italic">No articles for this topic.</p>
                                                    </#if>
                                                </div>
                                            </div>
                                        </div>
                                    </#list>
                                </div>
                            <#else>
                                <p class="text-muted fst-italic">No topics for this writer.</p>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
        </#list>
    <#else>
        <div class="alert alert-warning text-center">
            No writers found.
        </div>
    </#if>
</div>
</body>
</html>
