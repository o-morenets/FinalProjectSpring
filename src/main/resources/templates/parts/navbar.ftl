<#include "security.ftl">
<#import "login.ftl" as l>
<#import "/spring.ftl" as s/>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/"><img alt="" src="book.png"></a>
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
                        <a class="nav-link" href="/users/${principal.id}/grades"><@s.message "menu.user.profile"/></a>
                    </li>
                </#if>
            </#if>
        </ul>
        <#if known>
            <div class="navbar-text mr-3">${name}</div>
        <#else>
            <ul class="navbar-nav mr-3">
                <li class="nav-item">
                    <a class="nav-link" href="/signup"><@s.message "menu.signup"/></a>
                </li>
            </ul>
        </#if>
        <@l.logout />
        <#include "lang.ftl">
    </div>
</nav>
