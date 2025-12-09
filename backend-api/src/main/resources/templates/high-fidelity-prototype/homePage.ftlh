<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newsletter Home - Customer Portal</title>
    <link rel="stylesheet" href="/CSS/index.css">
</head>
<body> 

<nav> 
    <ul> 
        <li><a href="/index" class="active">Home</a></li> 
        <li><a href="/profile/${customer.id}">Profile</a></li> 
    </ul> 
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
                <p style="color:white;">No subscribed topics</p>
            </#if>
        </div>
    </div>

    <!-- Top 10 Topics Section -->
<h2 class="section-title">Top 10 Topics by Subscribers</h2>
<div id="top-topics" class="topics-grid">
    <#if topTopics?? && topTopics?size gt 0>
        <#list topTopics as topic>
            <a href="/topics/${topic.id}" class="topic-card-link">
                <div class="topic-card">
                    <p>
                        <strong>${topic.name}</strong> — ${topic.customers?size} subscribers
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

</body> 
</html>
