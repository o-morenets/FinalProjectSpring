<#import "parts/common.ftl" as c>

<@c.page>
${user.lastName} - choose your speciality

<form action="/users" method="post">
    <#list specialities as speciality>
    <div>
        <label><input type="radio" name="spec_${speciality.id}" />${speciality.name}</label>
    </div>
    </#list>
    <input type="hidden" name="userId" value="${user.id}" />
    <input type="hidden" value="${_csrf.token}" name="_csrf" />
    <button type="submit">Save</button>
</form>
</@c.page>
