<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"> 
    <title>Create Article</title> 
    <link rel="stylesheet" href="/CSS/topic.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> 
</head> 

<body class="topic-page">

<#include "_nav.ftlh"> 

<div class="container py-4" style="max-width: 700px;"> 

    <h2 class="mb-4 text-center">Create New Article</h2> 

    <form action="/articles/create" method="post"> 

        <!-- CSRF Token -->
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <!-- Topic Dropdown --> 
        <div class="mb-3"> 
            <label class="form-label">Topic</label> 
            <select name="topicId" class="form-control" required>
                <option value="" disabled <#if !topicId??>selected</#if>>Select a topic</option>
                <#list topics as topic>
                    <option value="${topic.id}" <#if topicId?? && topicId == topic.id>selected</#if>>${topic.name}</option>
                </#list>
            </select>
        </div>

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
            <input name="title" type="text" class="form-control" placeholder="Enter article title" required> 
        </div>

        <!-- Article Content -->
        <div class="mb-3">
            <label class="form-label">Content</label>
            <textarea name="content" rows="12" class="form-control" placeholder="Write your article content here..." required></textarea>
        </div>

        <button type="submit" class="btn btn-success w-100 mb-2">Publish Article</button>
        <a href="/" class="btn btn-secondary w-100">Cancel</a>

    </form>

</div>

</body>
</html>
