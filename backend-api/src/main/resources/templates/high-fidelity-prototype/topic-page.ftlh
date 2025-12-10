<!DOCTYPE html> 
<html lang="en"> 
<head> 
    <meta charset="UTF-8">
    <title>${topic.name}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/CSS/topic.css">
</head>

<body class="topic-page">

<nav class="nav">
    <div class="links">
        <a href="/" style="font-weight:800;font-size:1.2rem;">Newsletter</a>
        <a href="/">Home</a>
        <a href="/topics">Topics</a>
        <a href="/articles">Articles</a>
        <a href="/writers">Writers</a>
        <a href="/profiles">Profiles</a>
        <a href="/login">Login</a>
    </div>
</nav>

    <!-- Topic Title -->
    <h2 class="text-center mb-4">${topic.name!''}</h2>

    <!-- Rating display -->
    <#assign displayRating = 0>
    <#if topic.rating?? && topic.rating?is_number>
        <#assign displayRating = topic.rating>
    </#if>

    <div class="rating">
        <#list 1..5 as i>
            <#if i <= displayRating>
                <span class="star filled">&#9733;</span>
            <#else>
                <span class="star">&#9734;</span>
            </#if>
        </#list>
    </div>

    <p>
        Rating: <#if topic.rating?? && topic.rating?is_number>${topic.rating}<#else>N/A</#if>
    </p>

    <!-- Reviews count -->
    <#assign reviewCount = 0>
    <#if topic.reviews??>
        <#assign reviewCount = topic.reviews?size>
    </#if>
    <p>${reviewCount} review<#if reviewCount != 1>s</#if></p>

    <!-- Articles -->
    <form action="/articles/create" method="get">
        <input type="hidden" name="topicId" value="${topic.id}">
        <button type="submit" class="btn btn-outline-primary w-100 mb-3">Add Article</button>
    </form>

    <#if (topic.articles??) && (topic.articles?size > 0)>
    <h4 class="mb-3">Articles (${topic.articles?size})</h4>

    <#list topic.articles as article>
        <#assign contentPreview = (article.content!'')?string>

        <div class="card mb-3 shadow-sm">
            <div class="card-body d-flex justify-content-between align-items-center">
                <div>
                    <h5 class="mb-0">${article.title!''}</h5>

                    <p class="text-muted small mb-0">
                        <#if ((contentPreview?length) > 100)>
                            ${contentPreview?substring(0,100)}...
                        <#else>
                            ${contentPreview}
                        </#if>
                    </p>
                </div>

                <form action="/articles/${article.id}" method="get">
                    <button class="btn btn-sm btn-primary">View</button>
                </form>
            </div>
        </div>
    </#list>

<#else>
    <div class="panel">No articles found for this topic.</div>
</#if>


    <a href="/topics" class="btn w-100 mt-3">Back to all topics</a>
    <!-- Assigned Writers -->
    <div class="mt-4">
        <h4 class="mb-3">Assigned Writers</h4>
        <#if (topic.writers??) && (topic.writers?size > 0)>
            <div class="d-flex flex-wrap gap-2">
                <#list topic.writers as writer>
                    <a href="/writers/${writer.id}" class="badge bg-primary text-decoration-none">
                        ${writer.name}
                    </a>
                </#list>
            </div>
        <#else>
            <p class="text-muted">No writers assigned to this topic.</p>
        </#if>
    </div>

<!-- Add Review Form -->
<form action="/reviews/create" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="hidden" name="topicId" value="${topic.id}">
    
    <div class="mb-3">
        <label for="rating" class="form-label">Rating</label>
        <select name="rating" id="rating" class="form-select" required>
            <option value="1">1 &#9733;</option>
            <option value="2">2 &#9733;</option>
            <option value="3">3 &#9733;</option>
            <option value="4">4 &#9733;</option>
            <option value="5">5 &#9733;</option>
        </select>

    </div>
    <div class="mb-3">
        <label for="comment" class="form-label">Review</label>
        <textarea name="comment" id="comment" class="form-control" rows="3" required></textarea>
    </div>
    <button type="submit" class="btn btn-success w-100">Submit Review</button>
</form>



    <div class="mt-4">
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

                        <p>${review.rating} stars</p>
                        <p>${review.comment!''}</p>
                    </div>
                    <div class="d-flex gap-1">
                        <form action="/reviews/${review.id}/edit" method="get">
                            <button class="btn btn-sm btn-warning">Edit</button>
                        </form>
                        <form action="/reviews/${review.id}/delete" method="post">
                            <button class="btn btn-sm btn-danger">Delete</button>
                        </form>
                    </div>
                </div>
            </div>
        </#list>
    <#else>
        <p class="text-muted">No reviews yet.</p>
    </#if>
</div>
    <a href="/topics" class="btn btn-secondary mt-3 w-100">Back to all topics</a>
</div>

<script>
    (function(){
        const links = document.querySelectorAll('.nav .links a');
        function setActiveForPath(path){
            links.forEach(a=>{
                try{ a.classList.remove('active') }catch(e){}
                if(path === '/' && a.getAttribute('href') === '/') a.classList.add('active');
                else if(a.getAttribute('href') !== '/' && path.startsWith(a.getAttribute('href'))) a.classList.add('active');
            })
        }
        setActiveForPath(window.location.pathname || '/');
        links.forEach(a=>a.addEventListener('click',e=>{
            links.forEach(l=>l.classList.remove('active'));
            e.currentTarget.classList.add('active');
        }));
    })();
</script>

</body>
</html>
