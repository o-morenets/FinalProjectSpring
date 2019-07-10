<div class="row">
    <div class="col-md-12">
        <ul class="nav justify-content-center">
            <li class="nav-item">
                <a class="nav-link active" href="/">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="/login">Login</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/users">All users (ADMIN)</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/userInfo">User Info (USER)</a>
            </li>
        </ul>
        <form method="post" action="/logout">
            <button class="button" type="submit">
                Logout
            </button>
            <input name="${_csrf.parameterName}" value="${_csrf.token}" type="hidden"/>
        </form>
    </div>
</div>
