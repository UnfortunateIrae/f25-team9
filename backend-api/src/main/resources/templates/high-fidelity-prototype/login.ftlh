<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Sign In</title>
  <link rel="stylesheet" href="/css/site.css">
</head>
<body>
  <div class="container">
    <div class="card" style="max-width:420px;margin:60px auto;padding:20px;">
      <h2>Sign In</h2>
      <#if error??>
        <div class="alert alert-danger">${error}</div>
      </#if>
      <form method="post" action="/login">
        <label for="email">Email</label>
        <input id="email" name="email" type="email" required>
        <label for="password">Password</label>
        <input id="password" name="password" type="password" required>
        <div style="margin-top:12px"><button class="btn">Sign In</button></div>
      </form>
    </div>
  </div>
</body>
</html>