<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${topic.name}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/CSS/topic.css">
</head>

<body class="topic-page">

<#include "_nav.ftlh">

<div class="container">
    <div class="hero">
        <div class="topic-head">
            <h2 class="mb-0">${topic.name!''}</h2>
            
            <#-- Hide "Add Article" button for non-admins/writers -->
            <#if customer?? && accountType == "WRITER">
                <form action="/articles/create" method="get">
                    <input type="hidden" name="topicId" value="${topic.id}">
                    <button type="submit" class="btn-cta">Add Article</button>
                </form>
            </#if>
        </div>

        <#assign displayRating = 0>
        <#if topic.rating?? && topic.rating?is_number>
            <#assign displayRating = topic.rating>
        </#if>

        <div class="rating" style="margin:12px 0 6px;">
            <#list 1..5 as i>
                <#if i <= displayRating>
                    <span class="star filled">&#9733;</span>
                <#else>
                    <span class="star">&#9734;</span>
                </#if>
            </#list>
        </div>
        <div class="muted" style="display:flex;gap:14px;align-items:center;flex-wrap:wrap;">
            <span>Rating: <#if topic.rating?? && topic.rating?is_number>${topic.rating}<#else>N/A</#if></span>
            <#assign reviewCount = (topic.reviews??)?then(topic.reviews?size,0)>
            <span>${reviewCount} review<#if reviewCount != 1>s</#if></span>
        </div>
        <div class="accent-band"></div>
    </div>

    <div class="grid" style="margin-bottom:18px;">
        <div class="article-card">
            <h4 class="mb-2">Assigned Writers</h4>
            <#if (topic.writers??) && (topic.writers?size > 0)>
                <div class="d-flex flex-wrap gap-2">
                    <#list topic.writers as writer>
                        <a href="/writers/${writer.id}" class="badge bg-primary text-decoration-none">
                            ${writer.name}
                        </a>
                    </#list>
                </div>
            <#else>
                <p class="muted mb-0">No writers assigned to this topic.</p>
            </#if>
        </div>

        <div class="article-card">
            <h4 class="mb-2">Create a Review</h4>
            <form action="/reviews/create" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="topicId" value="${topic.id}">
                <div class="mb-2">
                    <label for="rating" class="form-label">Rating</label>
                    <select name="rating" id="rating" class="form-select" required>
                        <option value="1">1 &#9733;</option>
                        <option value="2">2 &#9733;</option>
                        <option value="3">3 &#9733;</option>
                        <option value="4">4 &#9733;</option>
                        <option value="5">5 &#9733;</option>
                    </select>
                </div>
                <div class="mb-2">
                    <label for="comment" class="form-label">Review</label>
                    <textarea name="comment" id="comment" class="form-control" rows="3" required></textarea>
                </div>
                <button type="submit" class="btn btn-success w-100">Submit Review</button>
            </form>
        </div>
    </div>

    <div style="margin-bottom:24px;">
        <h4 class="section-title">Articles (${(topic.articles??)?then(topic.articles?size,0)})</h4>
        <#if (topic.articles??) && (topic.articles?size > 0)>
            <div class="grid">
                <#list topic.articles as article>
                    <#assign contentPreview = (article.content!'')?string>
                    <div class="article-card">
                        <h5 class="mb-2">${article.title!''}</h5>
                        <p class="muted" style="margin:0 0 12px;">
                            <#if ((contentPreview?length) > 120)>
                                ${contentPreview?substring(0,120)}...
                            <#else>
                                ${contentPreview}
                            </#if>
                        </p>
                        <form action="/articles/${article.id}" method="get">
                            <button class="btn btn-cta" type="submit">View</button>
                        </form>

                        <#-- Hide Edit/Delete buttons for articles -->
                        <#if customer?? && accountType == "WRITER">
                            <div class="d-flex gap-2 mt-2">
                                <form action="/articles/edit/${article.id}" method="get">
                                    <button class="btn btn-primary w-100">Edit</button>
                                </form>

                                <form action="/articles/${article.id}/delete" method="post">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button class="btn btn-danger w-100"
                                            onclick="return confirm('Are you sure you want to delete this article?')">
                                        Delete
                                    </button>
                                </form>
                            </div>
                        </#if>
                    </div>
                </#list>
            </div>
        <#else>
            <div class="panel">No articles found for this topic.</div>
        </#if>
    </div>

    <div class="article-card" style="margin-bottom:16px;">
        <h4 class="mb-3">Reviews</h4>
        <#if topic.reviews?? && topic.reviews?size gt 0>
            <#list topic.reviews as review>
                <div class="card mb-2">
                    <div class="card-body d-flex justify-content-between align-items-start">
                        <div>
                            <strong>
                                <#if review.customer??>
                                    ${review.customer.name!''}
                                <#else>
                                    Anonymous
                                </#if>
                            </strong>

                            <p style="color: black">${review.rating} stars</p>
                            <p style="color: black">${review.comment!''}</p>
                        </div>
                        <div class="d-flex gap-1">
                        <#if customer?? && accountType == "WRITER">
                            <form action="/reviews/${review.id}/edit" method="get">
                                <button class="btn btn-sm btn-warning">Edit</button>
                            </form>
                        </#if>
                        <#if customer?? && accountType == "WRITER">
                            <form action="/reviews/${review.id}/delete" method="post">
                                <button class="btn btn-sm btn-danger">Delete</button>
                            </form>
                        </#if>
                        </div>
                    </div>
                </div>
            </#list>
        <#else>
            <p class="text-muted">No reviews yet.</p>
        </#if>
    </div>

    <a href="/topics" class="btn w-100 mt-3">Back to all topics</a>
</div>

</body>
</html>
