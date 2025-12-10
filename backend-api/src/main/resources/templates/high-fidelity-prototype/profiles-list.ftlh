<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Profiles</title>
    <link rel="stylesheet" href="/CSS/topic.css">
    <link rel="stylesheet" href="/CSS/profile.css">
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
    <div class="hero"><h1>All Profiles</h1><p class="muted">Click a profile to view details</p></div>

    <#if customers?? && (customers?size > 0)>
        <div class="grid" id="profiles-grid">
            <#list customers as customer>
                <div class="card">
                    <div style="display:flex;align-items:center;gap:12px">
                        <div style="width:64px;height:64px;border-radius:50%;background:linear-gradient(135deg,#667eea,#5aa9e6);display:flex;align-items:center;justify-content:center;color:white;font-weight:700;font-size:20px">
                            ${customer.name?substring(0,1)!""}
                        </div>
                        <div>
                            <h3 style="margin:0">${customer.name!""}</h3>
                            <p class="muted" style="margin:2px 0">${customer.email!""}</p>
                            <p class="small muted" style="margin:0">Subscriptions: ${customer.subscriptions?size?c}</p>
                        </div>
                    </div>
                    <div style="margin-top:12px;text-align:right">
                        <a class="btn" href="/profile/${customer.id}">View Profile</a>
                    </div>
                </div>
            </#list>
        </div>
    <#else>
        <div class="card"><p>No profiles found.</p></div>
    </#if>

</div>
<footer>Newsletter App</footer>
</body>
</html>
