<!DOCTYPE html>
<#import "/spring.ftl" as s/>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><@s.message "allUsers.title"/></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>

<body>
<div class="container">
    <#include "parts/lang.ftl">
    <#include "parts/menu.ftl">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading"><@s.message "allUsers.panel.title"/></div>
                <div class="panel-body">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th><@s.message "allUsers.panel.id"/></th>
                            <th><@s.message "allUsers.panel.firstName"/></th>
                            <th><@s.message "allUsers.panel.lastName"/></th>
                            <th><@s.message "allUsers.panel.email"/></th>
                            <th><@s.message "allUsers.panel.roles"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list users as user>
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.firstName}</td>
                                <td>${user.lastName}</td>
                                <td>${user.username}</td>
                                <td><#list user.authorities as role>${role}<#sep>, </#list></td>
                                <td><a href="/user/${user.id}">edit</a></td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>