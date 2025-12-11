<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Articles</title>
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
    <h2 class="text-center mb-4">All Articles</h2>

    <#if articles?? && (articles?size > 0)>
        <#list articles as article>
            <div class="card mb-3 shadow-sm">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="mb-0">${article.title}</h5>
                        <p class="text-muted small mb-0">
                            <#if article.content??>
                                <#if ((article.content?length) > 100)>
                                    ${article.content?substring(0,100)}...
                                <#else>
                                    ${article.content}
                                </#if>
                            <#else>
                                <em>No content</em>
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
        <div class="alert alert-info">No articles exist.</div>
    </#if>

    <a href="/topics" class="btn btn-secondary mt-3 w-100">Back to Topics</a>
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
