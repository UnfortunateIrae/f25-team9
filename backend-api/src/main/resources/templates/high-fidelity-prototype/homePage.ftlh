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

<#if writer??>
    <div class="hero">
        <h1>Writer Dashboard</h1>
        <p>Manage your articles and view your topics</p>
        <div class="cta">
            <a class="btn-cta" href="/articles/create">Create New Article</a>
        </div>
    </div>

    <div class="container layout">
        <aside class="sidebar">
            <div class="card panel">
                <h3 class="panel-title">Your Topics</h3>
                <div class="links-vertical">
                    <#if writerTopics?? && writerTopics?size gt 0>
                        <#list writerTopics as topic>
                            <a href="/topics/${topic.id}" class="small-link">${topic.name}</a>
                        </#list>
                    <#else>
                        <p class="muted">No topics assigned</p>
                    </#if>
                </div>
            </div>

            <div class="card panel">
                <h4 class="panel-title">Quick Actions</h4>
                <div class="links-vertical">
                    <a href="/articles/create" class="small-link">Write Article</a>
                    <a href="/writers/${writer.id}" class="small-link">My Profile</a>
                    <a href="/topics" class="small-link">All Topics</a>
                </div>
            </div>
        </aside>

        <main class="main">
            <h2 class="section-title">Your Articles</h2>
            <#if writerArticles?? && writerArticles?size gt 0>
                <div class="topics-grid">
                    <#list writerArticles as article>
                        <div class="topic-card">
                            <div class="topic-head">
                                <h3>${article.title}</h3>
                            </div>
                            <div style="margin-top:12px;display:flex;gap:8px;flex-wrap:wrap;">
                                <a class="learn" href="/articles/${article.id}">View</a>
                                <a class="learn" href="/articles/${article.id}/edit" style="background:rgba(255,255,255,0.08);">Edit</a>
                                <form action="/articles/${article.id}/delete" method="post" style="display:inline;">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="learn" style="background:rgba(220,53,69,0.2);border:1px solid rgba(220,53,69,0.5);cursor:pointer;" 
                                            onclick="return confirm('Are you sure you want to delete this article?')">Delete</button>
                                </form>
                            </div>
                        </div>
                    </#list>
                </div>
            <#else>
                <div class="card panel">
                    <p class="muted">You haven't written any articles yet.</p>
                    <a href="/articles/create" class="btn-cta" style="display:inline-block;margin-top:12px;">Write Your First Article</a>
                </div>
            </#if>
        </main>
    </div>
<#else>
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
                            <div style="margin-top:12px">
                                <a class="learn" href="/topics/${topic.id}">Explore</a>
                            </div>
                        </div>
                    </#list>
                <#else>
                    <p class="muted">No topics available</p>
                </#if>
            </div>
        </main>
    </div>
</#if>

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
