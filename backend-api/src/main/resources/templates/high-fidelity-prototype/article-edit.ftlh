<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit ${article.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">

    <h2 class="text-center mb-4">Edit Article</h2>

    <form action="/articles/${article.id}/update" method="post">

        <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" name="title" value="${article.title}" class="form-control" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Content</label>
            <textarea name="content" rows="6" class="form-control" required>${article.content}</textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Writer</label>
            <select name="writerId" class="form-select" required>
                <#list writers as writer>
                    <option value="${writer.id}" <#if writer.id == article.writer.id>selected</#if>>${writer.name}</option>
                </#list>
            </select>
        </div>

        <button type="submit" class="btn btn-primary w-100">Update</button>
    </form>

    <a href="/articles/${article.id}" class="btn btn-outline-secondary w-100 mt-3">Cancel</a>

</div>
</body>
</html>
