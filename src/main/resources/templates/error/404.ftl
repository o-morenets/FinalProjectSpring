<#import "../parts/common.ftl" as c>
<#import "/spring.ftl" as s/>

<@c.page>
    <div class="alert alert-danger" role="alert">
        <h3>404</h3>
    </div>
    <div class="card">
        <div class="card-body">
            <p class="lead"><@s.message "error.404.message"/></p>
        </div>
    </div>
</@c.page>