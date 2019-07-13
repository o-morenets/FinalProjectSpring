<#import "parts/common.ftl" as c>

<@c.page>
${user.getLastName()} - choose your speciality

<form action="/users" method="post">
    <#list specialities as speciality>
    <div>
        <label><input type="radio" name="spec_${speciality.getId()}" />${speciality.getName()}</label>
    </div>
    </#list>
    <input type="hidden" value="${user.id}" name="userId" />
    <input type="hidden" value="${_csrf.token}" name="_csrf" />
    <button type="submit">Save</button>
</form>
</@c.page>
