<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>
<#import "/spring.ftl" as s/>

<@c.page>
    <#if logout>
        <div class="alert alert-primary" role="alert">
            <@s.message "login.panel.alert.logout"/>
        </div>
    </#if>
    <#if error>
        <div class="alert alert-danger" role="alert">
            <@s.message "login.panel.alert.error"/>
        </div>
    </#if>
    <@l.login "/login" false/>
</@c.page>
