<#import "parts/common.ftl" as c>

<@c.page>

    Grades:

    <form action="/users/updateGrades" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit">Save</button>
    </form>
</@c.page>
