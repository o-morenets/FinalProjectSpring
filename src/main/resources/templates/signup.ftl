<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
    <div class="row justify-content-center">
        <div class="col-4">
            <@l.login "/signup" true />
        </div>
    </div>
</@c.page>