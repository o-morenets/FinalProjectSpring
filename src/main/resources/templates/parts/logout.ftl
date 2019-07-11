<#macro logout>
    <#include "security.ftl">
    <#if known>
        <form action="/logout" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button class="btn btn-secondary" type="submit">
                <@s.message "menu.logout" />
            </button>
        </form>
    <#else>
        <a class="btn btn-primary" href="/login" role="button"><@s.message "menu.login"/></a>
    </#if>
</#macro>