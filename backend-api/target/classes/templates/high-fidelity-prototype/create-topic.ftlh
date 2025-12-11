<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Topic</title>
    <link rel="stylesheet" href="/CSS/topic.css">
    <style>
        /* Centered container */
        .container{
            max-width:600px;
            margin:50px auto;
            background:linear-gradient(180deg,rgba(255,255,255,0.04),rgba(255,255,255,0.02));
            border:1px solid rgba(255,255,255,0.05);
            padding:28px;
            border-radius:16px;
            box-shadow:0 12px 32px rgba(0,0,0,0.35);
            backdrop-filter:blur(6px);
        }

        h1{
            margin-top:0;
            text-align:center;
            font-size:30px;
            font-weight:800;
            color:var(--text);
        }

        label{
            display:block;
            font-weight:600;
            margin-bottom:6px;
            color:var(--muted);
        }

        input{
            width:100%;
            padding:12px;
            border-radius:10px;
            border:1px solid rgba(255,255,255,0.08);
            background:rgba(255,255,255,0.08);
            color:white;
            margin-bottom:18px;
            font-size:1rem;
            outline:none;
        }

        input:focus{
            border-color:var(--secondary);
            box-shadow:0 0 10px rgba(90,169,230,0.4);
        }

        button{
            background:var(--primary-2);
            color:white;
            padding:12px 16px;
            font-size:1rem;
            font-weight:700;
            border:none;
            border-radius:12px;
            cursor:pointer;
            width:100%;
            margin-top:8px;
            box-shadow:0 8px 24px rgba(8,20,60,0.35);
            transition:all 0.2s ease;
        }

        button:hover{
            transform:translateY(-3px);
            filter:brightness(1.05);
        }

        a.back{
            display:inline-block;
            text-align:center;
            margin-top:18px;
            color:var(--secondary);
            font-weight:700;
            text-decoration:none;
            width:100%;
        }

        a.back:hover{
            text-decoration:underline;
        }
    </style>
</head>
<body class="topic-page">

<#include "_nav.ftlh">

<div class="container">
    <h1>Create New Topic</h1>

    <form action="/topics" method="post">
        <label>Name:</label>
        <input type="text" name="name" required />

        <button type="submit">Save</button>
    </form>

    <a href="/topics" class="back">Back</a>
</div>

</body>
</html>
