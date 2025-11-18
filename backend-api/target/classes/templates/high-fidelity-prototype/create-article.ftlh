<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Article</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">

    <h2 class="text-center mb-4">Create New Article</h2>

    <form action="/articles" method="post">

        <input type="hidden" name="topicId" value="${topicId}" />

        <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" name="title" class="form-control" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Content</label>
            <textarea name="content" rows="6" class="form-control" required></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Writer</label>
            <select name="writerId" class="form-select" required>
                <#list writers as writer>
                    <option value="${writer.id}">${writer.name}</option>
                </#list>
            </select>
        </div>

        <button type="submit" class="btn btn-primary w-100">Save</button>
    </form>

    <a href="/topics/${topicId}" class="btn btn-outline-secondary w-100 mt-3">Cancel</a>

</div>
</body>
</html>
