<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create New Writer</title>
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

        h1 {
            font-size: 28px;
            margin: 0;
            font-weight: bold;
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

        .create-btn {
            background-color: #4a69bd;
            color: white;
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

        <h1>Create Writer</h1>

        <form action="/writers" method="post">

            <label>Name</label>
            <input type="text" name="name" required>

            <label>Email</label>
            <input type="email" name="email">

            <label>Phone</label>
            <input type="text" name="phoneNumber">

            <label>Profile Image URL</label>
            <input type="text" name="imageUrl" placeholder="https://example.com/image.jpg">

            <label>Bio</label>
            <textarea name="bio" rows="5" placeholder="Tell readers about this writer"></textarea>

            <label>Source</label>
            <select name="source.id">
                <#list sources as s>
                    <option value="${s.id}">${s.name}</option>
                </#list>
            </select>

            <button type="submit" class="create-btn">Create Writer</button>
        </form>

        <a href="/writers" class="back-link">← Back to Writers</a>

    </div>
</div>

</body>
</html>
