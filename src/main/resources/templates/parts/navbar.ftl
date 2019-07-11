<#include "security.ftl">

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/"><@s.message "admission.title"/></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/"><@s.message "admission.homePage"/></a>
            </li>
            <#if user??>
                <li class="nav-item">
                    <a class="nav-link" href="/users/1">Profile</a> <#-- FIXME /users/1-->
                </li>
            </#if>
            <#if isAdmin>
                <li class="nav-item">
                    <a class="nav-link" href="/users">User list</a>
                </li>
            </#if>
        </ul>
        <#if user??>
            <div class="navbar-text mr-3">${name}</div>
        <#else>
            <ul class="navbar-nav mr-3">
                <li class="nav-item">
                    <a class="nav-link" href="/signup"><@s.message "menu.signup" /></a>
                </li>
            </ul>
        </#if>
        <#include "logout.ftl">
        <#include "lang.ftl">
    </div>
</nav>
