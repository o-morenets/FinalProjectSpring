<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>

<@c.page>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading"><@s.message "userList.panel.title"/></div>
                <div class="panel-body">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th><@s.message "user.lastName"/></th>
                            <th><@s.message "user.firstName"/></th>
                            <th><@s.message "user.email"/></th>
                            <th><@s.message "user.username"/></th>
                            <th><@s.message "user.speciality.name"/></th>
                            <th><@s.message "userList.link.grades"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list users as user>
                            <tr>
                                <td>${user.lastName}</td>
                                <td>${user.firstName}</td>
                                <td>${user.email}</td>
                                <td>${user.username}</td>
                                <td>
                                    <#if user.speciality??>${user.speciality.name}
                                    <#else>-<@s.message "user.speciality.notSelected"/>-
                                    </#if>
                                </td>
                                <td>
                                    <#if user.speciality??>
                                        <a href="/users/${user.id}/grades" class="badge badge-warning">
                                            <@s.message "userList.link.grades"/>
                                        </a>
                                    </#if>
                                </td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</@c.page>