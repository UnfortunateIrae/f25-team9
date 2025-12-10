<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newsletter Home - Customer Portal</title>
    <link rel="stylesheet" href="/CSS/home.css">
</head>
<body>

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

<div class="hero"> 
    <h1>Your Personalized Newsletter Feed</h1> 
    <p>Latest articles from your subscribed topics</p> 
</div> 

<div class="container"> 

    <!-- Topic Filter Section --> 
    <div class="filter-section"> 
        <h3 style="color: white; margin-bottom: 15px;">Filter by Topics:</h3> 
        <div id="topic-filters" class="filter-buttons"> 
            <#if activeSubscriptions?? && activeSubscriptions?size gt 0>
                <#list activeSubscriptions as topic>
                    <button class="filter-btn"
                            onclick="activeTopicId=${topic.id}; loadArticlesForTopic('${topic.name}')">
                        ${topic.name}
                    </button>
                </#list>
            <#else>
                <p class="muted">No topics available</p>
            </#if>
        </div>

        <section class="recent-articles">
            <h2 class="section-title">Recent Articles</h2>
            <div id="recent-articles" class="grid">
                <!-- Filled by app.js via loadRecentArticles -->
            </div>
        </section>
    </main>
    <!-- Top 10 Topics Section -->
    <p>TopTopics size: ${topTopics?size}</p>

<h2 class="section-title">Top 10 Topics by Subscribers</h2>
<div id="top-topics" class="topics-grid">
    <#if topTopics?? && topTopics?size gt 0>
        <#list topTopics as topic>
            <a href="/topics/${topic.id}" class="topic-card-link">
                <div class="topic-card">
                    <p>
                        ${topic.name}: ${subscriberCounts[topic.id?string]}
                    </p>
                </div>
            </a>
        </#list>
    <#else>
        <p style="color:white;">No topics available</p>
    </#if>
</div>

</div>

<script src="/app.js"></script>
<script>
    const customerId = ${customer.id};
    loadRecentArticles(customerId);
</script>

<!-- Nav active handling: highlights clicked link and sets active on load -->
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
        // set on load
        setActiveForPath(window.location.pathname || '/');
        // click handler to highlight
        links.forEach(a=>a.addEventListener('click',e=>{
            links.forEach(l=>l.classList.remove('active'));
            e.currentTarget.classList.add('active');
        }));
    })();
</script>

</body>
</html>
