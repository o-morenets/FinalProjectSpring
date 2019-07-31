<#import "../parts/common.ftl" as c>
<#import "/spring.ftl" as s/>

<@c.page>
    <div class="alert alert-warning" role="alert">
        <h3>403</h3>
    </div>
    <div class="card">
        <div class="card-body">
            <p class="lead"><@s.message "error.403.message"/></p>
        </div>
    </div>
</@c.page>