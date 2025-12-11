<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${writer.name} - Profile</title>
    <link rel="stylesheet" href="/CSS/topic.css">
    <style>
        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 20px;
        }

        .profile-card {
            background:linear-gradient(180deg,rgba(255,255,255,0.98), rgba(245,250,255,0.95));
            border:1px solid rgba(90,169,230,0.2);
            border-radius: 16px;
            box-shadow: 0 12px 32px rgba(14,43,102,0.2);
            padding: 30px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 20px;
            padding-bottom:20px;
            border-bottom:1px solid rgba(90,169,230,0.15);
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background:linear-gradient(135deg, #667eea, #764ba2);
            display: inline-block;
            flex-shrink: 0;
            overflow:hidden;
            box-shadow:0 8px 24px rgba(102,126,234,0.3);
        }

        .profile-name {
            font-size: 28px;
            font-weight: 700;
            margin: 0 0 10px 0;
            color:#0E2B66;
        }

        .profile-info p {
            margin: 5px 0;
            font-size: 16px;
            color:#4a5568;
        }

        h2 {
            margin-top: 20px;
            margin-bottom:15px;
            padding-bottom: 10px;
            font-size: 22px;
            color:#0E2B66;
            font-weight:700;
            border-bottom: 2px solid rgba(90,169,230,0.2);
        }

        ul {
            list-style: none;
            padding-left: 0;
        }

        li {
            background:linear-gradient(180deg,rgba(90,169,230,0.08),rgba(90,169,230,0.04));
            border:1px solid rgba(90,169,230,0.15);
            color:#062045;
            margin: 8px 0;
            padding: 12px 16px;
            border-radius: 10px;
            transition: 0.2s;
            font-weight:500;
        }

        li:hover {
            background:linear-gradient(180deg,rgba(90,169,230,0.15),rgba(90,169,230,0.1));
            border-color:#5AA9E6;
            transform:translateX(4px);
        }

        .section {
            display: flex;
            flex-direction: column;
        }
    </style>
</head>
<body class="topic-page">

<#include "_nav.ftlh">

<div class="container">
    <div class="profile-card">
        <div class="profile-header">
           <div class="profile-avatar">
        <img 
            src="${writer.imageUrl!'/images/default.png'}"
            alt="${writer.name}" 
            style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;"
        />
        </div>
            <div>
                <h1 class="profile-name">${writer.name}</h1>
                <div class="profile-info">
                    <p>Email: ${writer.email?if_exists}</p>
                    <p>Phone: ${writer.phoneNumber?if_exists}</p>
                    <p>Source: ${writer.sourceName}</p>
                </div>
            </div>
        </div>

        <div class="section">
            <h2>Articles</h2>
            <ul>
                <#list writer.articles?sort_by("title") as article>
                    <li>${article.title}</li>
                </#list>
            </ul>
        </div>

        <div class="section">
            <h2>Topics</h2>
            <ul>
                <#list writer.topics?sort_by("name") as topic>
                    <li>${topic.name}</li>
                </#list>
            </ul>
        </div>
    </div>
</div>
</body>
</html>
