<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>
<#import "/spring.ftl" as s/>

<@c.page>
    <div class="row justify-content-center">
        <div class="col-6">
            <div class="row">
                <div class="col">
                    <#if logout>
                        <div class="alert alert-primary" role="alert">
                            <@s.message "form.alert.logout"/>
                        </div>
                    </#if>
                    <#if error>
                        <div class="alert alert-danger" role="alert">
                            <@s.message "form.alert.error"/>
                        </div>
                    </#if>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <@l.login "/login" false/>
                </div>
            </div>
        </div>
    </div>
</@c.page>