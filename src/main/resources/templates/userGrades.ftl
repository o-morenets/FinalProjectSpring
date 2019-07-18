<#import "parts/common.ftl" as c>

<@c.page>

    User Grades

    <form action="/users/updateGrades" method="post">
        <input type="hidden" name="userId" value="${user.id}"/>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit">Save</button>
    </form>
</@c.page>
