<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>
<#import "/spring.ftl" as s/>

<@c.page>
    <div class="row justify-content-center">
        <div class="col-sm-8 col-md-6">
            <div class="card">
                <div class="card-header">
                    <h5><@s.message "card.login.header"/></h5>
                </div>
                <div class="card-body">
                    <#if logout>
                        <div class="row">
                            <div class="col">
                                <div class="alert alert-primary" role="alert">
                                    <@s.message "form.alert.logout"/>
                                </div>
                            </div>
                        </div>
                    </#if>
                    <#if error>
                        <div class="row">
                            <div class="col">
                                <div class="alert alert-danger" role="alert">
                                    <@s.message "form.alert.error"/>
                                </div>
                            </div>
                        </div>
                    </#if>
                    <div class="row">
                        <div class="col">
                            <@l.login "/login" false/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</@c.page>