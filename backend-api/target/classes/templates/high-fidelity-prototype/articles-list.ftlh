<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Articles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/CSS/topic.css">
</head>

<body class="topic-page">

<#include "_nav.ftlh">

<div class="container">
    <h2 class="text-center mb-4">All Articles</h2>

    <#if articles??>
        <p class="muted" style="text-align:center;margin-top:-8px;">${articles?size} article<#if articles?size != 1>s</#if> available</p>
    </#if>

    <#if articles?? && (articles?size > 0)>
        <#list articles as article>
            <#assign titleText = article.title?default("Untitled Article")>
            <#assign contentPreview = (article.content!"")?string>
            <#assign contentLength = contentPreview?length>
            <div class="article-card bright mb-3">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="mb-1">${titleText}</h5>
                        <p class="text-muted small mb-0">
                            <#if contentLength gt 120>
                                ${contentPreview?substring(0,120)}...
                            <#elseif contentLength gt 0>
                                ${contentPreview}
                            <#else>
                                <em>No content</em>
                            </#if>
                        </p>
                        <p class="text-muted small mb-0" style="margin-top:6px;">
                            <#if article.topic??>Topic: ${article.topic.name!""}<#else>Topic: N/A</#if>
                            &nbsp;|&nbsp;
                            <#if article.writer??>Writer: ${article.writer.name!""}<#else>Writer: N/A</#if>
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
