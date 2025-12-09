<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Topic</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        form {
            margin-bottom: 20px;
        }
        .writer-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }
        .writer-card {
            padding: 10px 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            cursor: pointer;
            user-select: none;
            transition: all 0.2s;
        }
        .writer-card.selected {
            background-color: #007bff;
            color: white;
            border-color: #0056b3;
        }
        input[type="checkbox"] {
            display: none;
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
