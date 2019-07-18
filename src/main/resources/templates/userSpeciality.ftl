<#import "parts/common.ftl" as c>

<@c.page>
    ${user.lastName} - choose your speciality

    <form action="/users/updateSpec" method="post">
        <div class="form-check">
            <input class="form-check-input" type="radio" name="specRadios" value="-1" id="spec_none" checked>
            <label class="form-check-label" for="spec_none">
                ---
            </label>
        </div>
        <#list specialities as speciality>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="specRadios" value="${speciality.id}"
                       id="spec_${speciality.id}">
                <label class="form-check-label" for="spec_${speciality.id}">
                    ${speciality.name}
                </label>
            </div>
        </#list>
        <input type="hidden" name="userId" value="${user.id}"/>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit">Save</button>
    </form>
</@c.page>
