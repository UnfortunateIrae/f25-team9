<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"> 
    <title>Create Article</title> 
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
</head> 

<body class="bg-light"> 

<div class="container py-4" style="max-width: 700px;"> 

    <h2 class="mb-4 text-center">Create Article</h2> 

    <form action="/articles/create" method="post"> 

        <!-- Hidden Topic ID --> 
        <input type="hidden" name="topicId" value="${topicId}"/> 

        <!-- Writer Dropdown --> 
        <div class="mb-3"> 
            <label class="form-label">Writer</label> 
            <select name="writerId" class="form-control" required>
                <option value="" disabled selected>Select a writer</option>
                <#list writers as writer>
                    <option value="${writer.id}">${writer.name}</option>
                </#list>
            </select>
        </div> 

        <!-- Article Title --> 
        <div class="mb-3"> 
            <label class="form-label">Title</label> 
            <input name="title" type="text" class="form-control" required> 
        </div>

        <!-- Article Content -->
        <div class="mb-3">
            <label class="form-label">Content</label>
            <textarea name="content" rows="8" class="form-control" required></textarea>
        </div>

        <button type="submit" class="btn btn-success w-100 mb-2">Save</button>
        <a href="/topics/${topicId}" class="btn btn-secondary w-100">Cancel</a>

    </form>

</div>

</body>
</html>
