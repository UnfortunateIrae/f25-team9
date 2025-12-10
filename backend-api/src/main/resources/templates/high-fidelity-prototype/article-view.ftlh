<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${article.title}</title>
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

<div class="container" style="max-width: 800px;">
    <h2>${article.title}</h2>
    <p class="text-muted">Author: ${article.writer.name?default("Unknown")}</p>

    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <p class="mb-0" style="white-space: pre-wrap;">${article.content}</p>
        </div>
    </div>

    <div class="d-flex gap-2">
        <form action="/articles/edit/${article.id}" method="get">
            <button class="btn btn-primary w-100">Edit</button>
        </form>

        <form action="/articles/delete/${article.id}" method="post">
            <button class="btn btn-danger w-100"
                    onclick="return confirm('Are you sure you want to delete this article?')">
                Delete
            </button>
        </form>
    </div>

    <a href="/topics/${article.topic.id}" class="btn btn-secondary w-100 mt-3">Back to Topic</a>
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
