<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit ${writer.name}</title>
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
            overflow: hidden;
            background-color: #ddd;
        }

        .profile-name {
            font-size: 28px;
            font-weight: bold;
            margin: 0;
        }

        label {
            font-weight: bold;
            margin-bottom: 6px;
            display: block;
        }

        input, textarea, select {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-bottom: 15px;
            font-size: 15px;
        }

        button {
            padding: 12px 18px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .save-btn {
            background-color: #4a69bd;
            color: white;
        }

        .delete-btn {
            background-color: #d9534f;
            color: white;
            margin-top: 10px;
        }

        .back-link {
            margin-top: 10px;
            display: inline-block;
            font-weight: bold;
            color: #4a69bd;
            text-decoration: none;
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
                        style="width: 100%; height: 100%; object-fit: cover; border-radius: 50%;">
            </div>
            <h1 class="profile-name">Edit ${writer.name}</h1>
        </div>

        <form action="/writers/${writer.id}/update" method="post">

            <label>Name</label>
            <input type="text" name="name" value="${writer.name}" required>

            <label>Email</label>
            <input type="email" name="email" value="${writer.email?if_exists}">

            <label>Phone</label>
            <input type="text" name="phoneNumber" value="${writer.phoneNumber?if_exists}">

            <label>Profile Image URL</label>
            <input type="text" name="imageUrl" value="${writer.imageUrl?if_exists}">

            <label>Bio</label>
            <textarea name="bio" rows="5">${writer.bio?if_exists}</textarea>

            <label>Source</label>
            <select name="source.id">
                <#list sources as s>
                    <option value="${s.id}" <#if writer.source?exists && s.id == writer.source.id>selected</#if>>
                        ${s.name}
                    </option>
                </#list>
            </select>

            <button type="submit" class="save-btn">Save Changes</button>
        </form>

        <form action="/writers/${writer.id}/delete" method="post">
            <button type="submit" class="delete-btn">Delete Writer</button>
        </form>

        <a href="/writers" class="back-link">← Back to Writers</a>

    </div>
</div>

</body>
</html>
