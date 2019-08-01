<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>
<#import "/spring.ftl" as s/>

<@c.page>
    <div class="row justify-content-center">
        <div class="col-sm-8 col-md-6">
            <div class="card">
                <div class="card-header">
                    <h5><@s.message "card.signup.header"/></h5>
                </div>
                <div class="card-body">
                    <@l.login "/signup" true />
                </div>
            </div>
        </div>
    </div>
</@c.page>