<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>

<@c.page>
    <div>Welcome, ${userInfo.getUsername()}</div>
    <div>First Name: ${user.firstName}</div>
    <div>Last Name: ${user.lastName}</div>
</@c.page>