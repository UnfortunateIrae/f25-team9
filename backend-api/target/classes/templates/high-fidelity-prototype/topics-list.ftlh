<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Topics & Writers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/CSS/topic.css">
</head>
<body class="topic-page">

<#include "_nav.ftlh">
<div class="container">
    <div class="hero">
        <h2 class="mb-0 text-center">Topics & Writers</h2>
    </div>

    <#-- Hide Create Topic button for writers -->
    <#if (customer??) && (accountType == "WRITER")>
        <form action="/topics/create" method="get">
            <button type="submit" class="btn btn-outline-primary w-100 mb-3">
                Create Topic
            </button>
        </form>
    </#if>

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

                    <#-- Hide Edit/Delete buttons for non-admins/writers -->
                    <#if customer?? && accountType == "WRITER">
                        <div class="d-flex gap-2">
                            <form action="/topics/edit/${topic.id}" method="get">
                                <button class="btn btn-sm btn-warning">Edit</button>
                            </form>

                            <form action="/topics/${topic.id}/delete" method="post"
                                  onsubmit="return confirm('Delete topic?');">
                                <button class="btn btn-sm btn-danger">Delete</button>
                            </form>
                        </div>
                    </#if>
                </div>

                <div class="card-body">
                    <#if topic.writers?? && (topic.writers?size > 0)>
                        <p class="mb-2" style="color:rgba(255,255,255,0.9);">Writers:</p>
                        <div>
                            <#list topic.writers as writer>
                                <span class="badge bg-primary me-1 mb-1">${writer.name?default("Unnamed Writer")}</span>
                            </#list>
                        </div>
                    <#else>
                        <p class="mb-0" style="color:rgba(255,255,255,0.75) !important;">No writers assigned.</p>
                    </#if>
                </div>
            </div>
        </#list>
    <#else>
        <div class="alert alert-warning text-center">No topics found.</div>
    </#if>
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
