<#include "security.ftl">
<#import "login.ftl" as l>
<#import "/spring.ftl" as s/>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/"><img alt="" src="/img/book.png"></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/"><@s.message "admission.homePage"/></a>
            </li>
            <#if known>
                <#if isAdmin>
                    <li class="nav-item">
                        <a class="nav-link" href="/users"><@s.message "menu.admin.grades"/></a>
                    </li>
                <#else>
                    <li class="nav-item">
                        <a class="nav-link" href="/users/profile"><@s.message "menu.user.profile"/></a>
                    </li>
                </#if>
            </#if>
        </ul>
        <#if known>
            <div class="navbar-text mr-3">
                <b>${principal.lastName} ${principal.firstName}</b> [${principal.username}]
            </div>
            <#if isAdmin>
                <span class="badge badge-danger"><@s.message "menu.role.admin"/></span>
            <#else>
                <span class="badge badge-info"><@s.message "menu.role.user"/></span>
            </#if>
        <#else>
            <div class="navbar-nav mr-3">
                <li class="nav-item">
                    <a class="nav-link" href="/signup"><@s.message "menu.signup"/></a>
                </li>
            </div>
        </#if>
        <@l.logout />
        <#include "lang.ftl">
    </div>
</nav>
