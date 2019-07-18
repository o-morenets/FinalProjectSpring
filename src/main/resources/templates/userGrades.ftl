<#import "parts/common.ftl" as c>

<@c.page>

    Grades:

    <table>
        <thead>
        <tr>
            <th>Subject</th>
            <th>Grade</th>
        </tr>
        </thead>
        <tbody>
        <#list gradesDto as grade>
            <tr>
                <td>${grade.subject.name}</td>
                <td>${grade.grade}</td>
            </tr>
        </#list>
        </tbody>
    </table>

    <form action="/users/updateGrades" method="post">
        <input type="hidden" name="userId" value="${user.id}"/>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit">Save</button>
    </form>
</@c.page>
