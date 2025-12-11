<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${customer.name}'s Subscriptions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/CSS/customerSubscriptions.css">
</head>
<body>

<nav class="nav mb-4 p-2 bg-light">
    <div class="links d-flex gap-3">
        <a href="/" style="font-weight:800;font-size:1.2rem;">Newsletter</a>
        <a href="/">Home</a>
        <a href="/topics">Topics</a>
        <a href="/articles">Articles</a>
        <a href="/writers">Writers</a>
        <a href="/profiles">Profiles</a>
        <a href="/login">Login</a>
    </div>
</nav>

<div class="container mt-3">
    <h2>${customer.name}'s Active Subscriptions</h2>

    <#if activeSubscriptions?? && activeSubscriptions?size gt 0>
        <div class="list-group mt-3">
            <#list activeSubscriptions as topic>
                <div class="list-group-item d-flex justify-content-between align-items-center">
                    <a href="/topics/${topic.id}" class="text-decoration-none">
                        ${topic.name!''}
                    </a>

                    <form action="/subscriptions/${topic.id}/cancel" method="post" class="mb-0">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <button type="submit" class="btn btn-sm btn-danger">Unsubscribe</button>
                    </form>
                </div>
            </#list>
        </div>
    <#else>
        <p class="text-muted mt-3">You are not subscribed to any topics yet.</p>
    </#if>

    <a href="/topics" class="btn btn-secondary mt-4 w-100">Browse All Topics</a>
</div>

<script>
    // Simple nav highlighting
    (function(){
        const links = document.querySelectorAll('.nav .links a');
        function setActiveForPath(path){
            links.forEach(a=> a.classList.remove('active'));
            links.forEach(a=>{
                if(a.getAttribute('href') !== '/' && path.startsWith(a.getAttribute('href'))) a.classList.add('active');
                if(path === '/' && a.getAttribute('href') === '/') a.classList.add('active');
            });
        }
        setActiveForPath(window.location.pathname || '/');
    })();
</script>

</body>
</html>
