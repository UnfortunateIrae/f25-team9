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

<div class="container">

    <div class="hero">
        <div class="topic-head">
            <h2 class="mb-0">${topic.name}</h2>

            <form action="/articles/create" method="get">
                <input type="hidden" name="topicId" value="${topic.id}">
                <button type="submit" class="btn-cta">Add Article</button>
            </form>
        </div>
        <div class="accent-band"></div>
    </div>

    <#if topic.articles?? && (topic.articles?size > 0)>
        <h4 class="mb-3">Articles (${topic.articles?size})</h4>

        <#list topic.articles as article>
    <#-- safely get article content or empty string -->
    <#assign contentPreview = article.content?default("")>
    
    <div class="card mb-3 shadow-sm article-card">
        <div class="card-body d-flex justify-content-between align-items-center">
            <div>
                <h5 class="mb-0">${article.title?default("Untitled Article")}</h5>
                <p class="muted small mb-0">
                    <#-- truncate to 100 characters or less -->
                    <#if contentPreview?length &gt; 100>
                        ${contentPreview?substring(0,100)}...
                    <#else>
                        ${contentPreview}
                    </#if>
                </p>
            </div>

            <form action="/articles/${article.id}" method="get">
                <button class="btn">View</button>
            </form>
        </div>
    </div>
</#list>


    <#else>
        <div class="panel">No articles found for this topic.</div>
    </#if>

    <a href="/topics" class="btn w-100 mt-3">Back to all topics</a>

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
