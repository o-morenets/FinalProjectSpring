<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>
<#include "parts/security.ftl">

<@c.page>
    <div class="row">
        <div class="mx-auto">
            <h2>
                <@s.message "homePage.message"/>
            </h2>
            <#if known>
                <h3>
                    <#if isAdmin>
                        <@s.message "homePage.adminPage"/>
                    <#else>
                        <@s.message "homePage.userPage"/>
                    </#if>
                </h3>
            </#if>
        </div>
    </div>
</@c.page>