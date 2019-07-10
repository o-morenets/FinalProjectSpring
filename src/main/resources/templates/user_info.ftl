<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>

<@c.page>
    <div>Welcome, ${userInfo.getUsername()}</div>
</@c.page>