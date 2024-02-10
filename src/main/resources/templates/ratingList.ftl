<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>

<@c.page>
<div class= "row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header"><@s.message "card.ratingList.title"/></div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th><@s.message "user.lastName"/></th>
                            <th><@s.message "user.firstName"/></th>
                            <th><@s.message "user.email"/></th>
                            <th><@s.message "user.username"/></th>
                            <th><@s.message "user.speciality.name"/></th>
                            <th><@s.message "userList.link.averageGrade"/></th>
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
                                    <#if user.speciality??>
                                        ${user.speciality.name}
                                    <#else>
                                        <span class="badge badge-dark mb-3">
                                            <@s.message "user.speciality.notSelected"/>
                                        </span>
                                    </#if>
                                </td>
                                <td>
                                    <#if user.message??>
                                        <div class="progress">
                                            <div class="progress-bar <#if user.message.entered>bg-success<#else>bg-danger</#if>"
                                                 role="progressbar"
                                                 style="width: ${user.message.averageGrade?round}%;"
                                                 aria-valuemin="0" aria-valuemax="100"
                                                 aria-valuenow="${user.message.averageGrade}">
                                                ${user.message.averageGrade}
                                            </div>
                                        </div>
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