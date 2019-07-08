<!DOCTYPE html>
<#import "/spring.ftl" as s/>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><@s.message "allUsers.title"/></title>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.8/angular.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>

<body ng-app="users_form" ng-controller="UserCtrl" data-ng-init="getUsers()">
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
                        <tr ng-repeat="u in users">
                            <td>{{u.userId}}</td>
                            <td>{{u.firstName}}</td>
                            <td>{{u.lastName}}</td>
                            <td>{{u.username}}</td>
                            <td>{{u.authorities}}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/users.js"></script>
</body>
</html>