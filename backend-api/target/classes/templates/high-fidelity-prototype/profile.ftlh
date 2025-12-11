<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <link rel="stylesheet" href="/CSS/topic.css">
    <link rel="stylesheet" href="/CSS/profile.css">
</head>
<body class="topic-page">

<#include "_nav.ftlh">

<div class="container">
    <div class="hero">
        <div class="profile-header" style="background:transparent;box-shadow:none;padding:0;display:flex;align-items:center;gap:18px;flex-wrap:wrap;">
            <img src="${customer.imageUrl!'/images/default-profile.png'}" alt="Profile Photo" class="profile-img">
            <div>
                <h1 style="margin:0 0 6px;">${customer.name}</h1>
                <p class="muted" style="margin:0">${customer.email}</p>
                <p class="muted" style="margin:4px 0 0;">${customer.phoneNumber}</p>
            </div>
        </div>
        <div class="profile-actions" style="margin-top:14px;display:flex;gap:10px;flex-wrap:wrap;">
            <a href="/customer/edit/${customer.id}" class="btn-cta">Edit Profile</a>
            <a href="/subscriptions" class="btn">Manage Subscriptions</a>
        </div>
    </div>

    <div class="article-card" style="margin-top:18px;">
        <h2 class="mb-3">Active Subscriptions</h2>
        <div class="subscriptions-list">
            <#if activeSubscriptions?size gt 0>
                <#list activeSubscriptions as topic>
                    <div class="subscription-card">
                        <h3>${topic.name}</h3>
                        <p>${topic.description!""}</p>

                        <form action="/unsubscribe/${topic.id}" method="post">
                            <button type="submit" class="unsubscribe-btn">Unsubscribe</button>
                        </form>
                    </div>
                </#list>
            <#else>
                <p class="muted">No active subscriptions yet.</p>
            </#if>
        </div>
    </div>

    <footer style="margin:24px 0 0;" class="muted">© 2025 Newsletter Platform</footer>
</div>

</body>
</html>
