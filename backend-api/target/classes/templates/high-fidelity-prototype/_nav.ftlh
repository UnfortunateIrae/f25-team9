<link rel="stylesheet" href="/CSS/nav.css">
<nav class="nav">
    <div class="links">
        <span class="brand-title">Customizable Newsletter</span>
        <a href="/">Home</a>
        <a href="/topics">Topics</a>
        <a href="/articles">Articles</a>
        <a href="/writers">Writers</a>
        <#if customer??>
            <span class="role-badge customer-badge">Customer</span>
            <a href="/profile/${customer.id}">Profile</a>
            <form action="/logout" method="post">
                <button type="submit">Logout</button>
            </form>
        <#elseif writer??>
            <a href="/profiles">Profiles</a>
            <span class="role-badge writer-badge">Writer</span>
            <a href="/writers/${writer.id}">Profile</a>
            <form action="/logout" method="post">
                <button type="submit">Logout</button>
            </form>
        <#else>
            <a href="/login">Login</a>
        </#if>
    </div>
</nav>

<script>
(function(){
    const links = document.querySelectorAll('.nav .links a');
    function setActiveForPath(path){
        links.forEach(a=>{
            try{ a.classList.remove('active') }catch(e){}
            if(path === '/' && a.getAttribute('href') === '/') a.classList.add('active');
            else if(a.getAttribute('href') !== '/' && path.startsWith(a.getAttribute('href'))) a.classList.add('active');
        })
    }
    setActiveForPath(window.location.pathname || '/');
    links.forEach(a=>a.addEventListener('click',e=>{
        links.forEach(l=>l.classList.remove('active'));
        e.currentTarget.classList.add('active');
    }));
})();
</script>
