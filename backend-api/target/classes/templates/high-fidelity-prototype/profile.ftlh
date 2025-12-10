<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <link rel="stylesheet" href="/CSS/profile.css">
</head>
<body>

<nav>
    <ul>
        <li><a href="/home" class="active">Profile</a></li>
        <li><a href="/articles">Articles</a></li>
        <li><a href="/login">Logout</a></li>
    </ul>
</nav>

<header class="profile-header">
    <div class="profile-info">
        <img src="${customer.imageUrl!'/images/default-profile.png'}" alt="Profile Photo" class="profile-img">
        <h1>${customer.name}</h1>
        <p>${customer.email}</p>
        <p>${customer.phoneNumber}</p>
    </div>

    <div class="profile-actions">
        <a href="/customer/edit/${customer.id}" class="btn">Edit Profile</a>
        <a href="/subscriptions" class="btn secondary">Manage Subscriptions</a>
    </div>
</header>

<section class="profile-section">
    <h2>Active Subscriptions</h2>

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
            <p>No active subscriptions yet.</p>
        </#if>
    </div>
</section>

<footer>
    <p>© 2025 Newsletter Platform</p>
</footer>

</body>
</html>
