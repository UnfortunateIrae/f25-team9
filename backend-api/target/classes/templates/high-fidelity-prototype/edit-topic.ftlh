<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Topic</title>
    <style>
        /* Blue home theme (same as homepage) */
        :root{
          --primary: #0E2B66;
          --primary-2: #23459E;
          --secondary: #5AA9E6;
          --nav-deep: #081432;
          --accent: #FFC107;
          --bg: #0E2B66;
          --card: rgba(255,255,255,0.06);
          --card-2: rgba(255,255,255,0.08);
          --muted: rgba(255,255,255,0.8);
          --text: #ffffff;
        }

        *{box-sizing:border-box}
        html,body{height:100%}
        body{
            font-family:Inter,Segoe UI,Helvetica,Arial,sans-serif;
            background:var(--bg);
            color:var(--text);
            margin:0;
            padding:20px;
        }

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

        /* Buttons */
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

        .delete-btn{
            background:#b3261e;
            box-shadow:0 8px 24px rgba(50,0,0,0.4);
        }
        .delete-btn:hover{
            background:#d93c2c;
        }

        a.back{
            display:inline-block;
            text-align:center;
            margin-top:18px;
            color:var(--secondary);
            font-weight:700;
            text-decoration:none;
        }

        a.back:hover{
            text-decoration:underline;
        }

        /* Form wrapper spacing */
        .form-section{
            margin-top:25px;
        }
    </style>

</head>
<body>
<h1>Edit Topic</h1>

<form action="/topics/update/${topic.id}" method="post">
    <label>Name:</label>
    <input type="text" name="name" value="${topic.name}" required />

    <label>URL:</label>
    <input type="text" name="url" value="${topic.url!}" />

    <h3>Assign Writers:</h3>
    <div class="writer-grid">
        <#if allWriters?? && allWriters?size gt 0>
            <#list allWriters as writer>
                <label class="writer-card <#if topic.writers?seq_contains(writer)>selected</#if>">
                    <input type="checkbox" name="writerIds" value="${writer.id}"
                           <#if topic.writers?seq_contains(writer)>checked</#if> />
                    ${writer.name}
                </label>
            </#list>
        <#else>
            <p>No writers available</p>
        </#if>
    </div>

    <button type="submit" style="margin-top:15px;">Update Topic</button>
</form>

<form action="/topics/${topic.id}/delete" method="post">
    <button type="submit" style="margin-top:10px;">Delete Topic</button>
</form>

<a href="/topics" style="display:block; margin-top:15px;">Back</a>

<script>
    // Toggle selected class when clicking a writer card
    document.querySelectorAll('.writer-card').forEach(card => {
        card.addEventListener('click', e => {
            const checkbox = card.querySelector('input[type="checkbox"]');
            checkbox.checked = !checkbox.checked;
            card.classList.toggle('selected', checkbox.checked);
        });
    });
</script>

</body>
</html>

