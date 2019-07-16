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
                            <th><@s.message "user.id"/></th>
                            <th><@s.message "user.username"/></th>
                            <th><@s.message "user.email"/></th>
                            <th><@s.message "user.firstName"/></th>
                            <th><@s.message "user.lastName"/></th>
                            <th><@s.message "user.roles"/></th>
                            <th><@s.message "user.speciality.name"/></th>
                            <th><@s.message "userList.link.action"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list users as user>
                            <tr>
                                <td>${user.getId()}</td>
                                <td>${user.getUsername()}</td>
                                <td>${user.getEmail()}</td>
                                <td>${user.getFirstName()}</td>
                                <td>${user.getLastName()}</td>
                                <td><#list user.getAuthorities() as role>${role}<#sep>, </#list></td>
                                <td><#if user.getSpeciality()??>${user.getSpeciality().getName()}<#else>---</#if></td>
                                <td><a href="/users/${user.getId()}">edit</a></td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</@c.page>