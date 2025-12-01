<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${writer.name} - Profile</title>
    <style>
        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 20px;
        }

        .profile-card {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            padding: 30px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: #ddd;
            display: inline-block;
            flex-shrink: 0;
        }

        .profile-name {
            font-size: 28px;
            font-weight: bold;
            margin: 0;
        }

        .profile-info p {
            margin: 5px 0;
            font-size: 16px;
        }

        h2 {
            margin-top: 30px;
            border-bottom: 2px solid #eee;
            padding-bottom: 5px;
            font-size: 20px;
        }

        ul {
            list-style: none;
            padding-left: 0;
        }

        li {
            background-color: #f9f9f9;
            margin: 5px 0;
            padding: 10px 15px;
            border-radius: 8px;
            transition: 0.2s;
        }

        li:hover {
            background-color: #e0e0ff;
        }

        .section {
            display: flex;
            flex-direction: column;
        }
    </style>
</head>
<body>
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
