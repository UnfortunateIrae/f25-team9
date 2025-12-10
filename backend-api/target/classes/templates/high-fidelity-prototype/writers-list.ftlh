<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Writer Directory</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/CSS/topic.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
        <#if customer??>
            <form action="/logout" method="post">
                <button type="submit">Logout</button>
            </form>
        <#else>
            <a href="/login">Login</a>
        </#if>
    </div>
</nav>

<div class="container">
    <h1 class="mb-4 text-center">Writer Directory</h1>
    <div class="mb-3 text-center">
                                <form action="/writers/new" method="get">
                                    <button type="submit" class="btn btn-outline-primary w-100">
                                        Create Writer Profile
                                    </button>
                                </form>
                            </div>
    <#if writers?has_content>
        <#list writers as writer>
            <div class="accordion mb-3" id="accordionWriter${writer.id}">
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingWriter${writer.id}">
                        <button class="accordion-button collapsed" type="button"
                                data-bs-toggle="collapse"
                                data-bs-target="#collapseWriter${writer.id}"
                                aria-expanded="false"
                                aria-controls="collapseWriter${writer.id}">
                            ${writer.name?default("Unnamed Writer")}
                        </button>
                    </h2>
                    <div id="collapseWriter${writer.id}" class="accordion-collapse collapse"
                         aria-labelledby="headingWriter${writer.id}"
                         data-bs-parent="#accordionWriter${writer.id}">
                        <div class="accordion-body">
                            <p class="text-muted mb-2">
                                Email: ${writer.email?default("N/A")},
                                Phone: ${writer.phoneNumber?default("N/A")},
                                Source: <#if writer.source??>${writer.source.name!""}<#else>Freelance</#if>
                            </p>

                            <div class="mb-3 text-center">
                                <form action="/writers/${writer.id}" method="get">
                                    <button type="submit" class="btn btn-outline-primary w-100">
                                        View Writer Profile
                                    </button>
                                </form>
                            </div>
                            <div class="mb-3 text-center">
                                <form action="/writers/${writer.id}/edit" method="get">
                                    <button type="submit" class="btn btn-outline-primary w-100">
                                        Edit Writer Profile
                                    </button>
                                </form>
                            </div>

                            <#if writer.topics?has_content>
                                <div class="accordion" id="accordionTopics${writer.id}">
                                    <#list writer.topics as topic>
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="headingTopic${topic.id}">
                                                <button class="accordion-button collapsed" type="button"
                                                        data-bs-toggle="collapse"
                                                        data-bs-target="#collapseTopic${topic.id}"
                                                        aria-expanded="false"
                                                        aria-controls="collapseTopic${topic.id}">
                                                    ${topic.name?default("Untitled Topic")}
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
                                                                    ${article.title?default("Untitled Article")}
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
