<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newsletter Home - Customer Portal</title>
    <link rel="stylesheet" href="/CSS/home.css">
</head>
<body>

<#include "_nav.ftlh">

<div class="hero">
    <h1>Your Personalized Newsletter Feed</h1>
    <p>Latest articles from your subscribed topics</p>
    <div class="cta">
        <a class="btn-cta" href="/topics">Explore Topics</a>
    </div>
</div>

<div class="container layout">
    <aside class="sidebar">
        <div class="card panel">
            <h3 class="panel-title">Your Subscriptions</h3>
            <div id="topic-filters" class="filter-buttons">
                <#if activeSubscriptions?? && activeSubscriptions?size gt 0>
                    <#list activeSubscriptions as topic>
                        <button class="filter-btn" onclick="activeTopicId=${topic.id}; loadArticlesForTopic('${topic.name}')">${topic.name}</button>
                    </#list>
                <#else>
                    <p class="muted">No subscribed topics</p>
                </#if>
            </div>
        </div>

        <div class="card panel">
            <h4 class="panel-title">Quick Links</h4>
            <div class="links-vertical">
                <a href="/topics" class="small-link">All Topics</a>
                <a href="/articles" class="small-link">All Articles</a>
                <a href="/profiles" class="small-link">Profiles</a>
            </div>
        </div>
    </aside>

    <main class="main">
        <h2 class="section-title">Top 10 Topics by Subscribers</h2>
        <div id="top-topics" class="topics-grid">
            <#if topTopics?? && topTopics?size gt 0>
                <#list topTopics as topic>
                    <div class="topic-card">
                        <div class="topic-head"><h3>${topic.name}</h3><span class="count small">${subscriberCounts[topic.id?string]!0}</span></div>
                        <p class="small muted">Short description placeholder — add topic summary here.</p>
                        <div style="margin-top:12px">
                            <a class="learn" href="/topics/${topic.id}">Explore</a>
                        </div>
                    </div>
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
    <#if customer??>
    const customerId = ${customer.id};
    loadRecentArticles(customerId);
    </#if>
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
