<!DOCTYPE html>
<#import "/spring.ftl" as s/>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><@s.message "signup.title"/></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.8/angular.min.js"></script>
</head>

<body ng-app="registration_form" ng-controller="AppCtrl">

<div class="container">
    <#include "parts/lang.ftl">
    <#include "parts/menu.ftl">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="panel panel-default"">
            <h3 id="resultMessage">{{message}}</h3>
                <div class="panel-heading">
                    <h3 class="panel-title"><@s.message "signup.panel.title"/></h3>
                </div>
                <div class="panel-body">
                    <form name="form" autocomplete="off" novalidate
                          ng-submit="form.$valid && sendForm(auth)">
                        <div class="form-group">
                            <label id="inputFirstNameLabel"
                                   for="inputFirstName"><@s.message "signup.panel.firstName"/></label>
                            <input type="text"
                                   class="form-control"
                                   id="inputFirstName"
                                   placeholder="<@s.message "signup.panel.firstName"/>"
                                   required
                                   ng-model="auth.firstName">
                        </div>
                        <div class="form-group">
                            <label id="inputLastNameLabel"
                                   for="inputLastName"><@s.message "signup.panel.lastName"/></label>
                            <input type="text"
                                   class="form-control"
                                   id="inputLastName"
                                   placeholder="<@s.message "signup.panel.lastName"/>"
                                   required
                                   ng-model="auth.lastName">
                        </div>
                        <div class="form-group">
                            <label id="inputEmailLabel" for="inputEmail"><@s.message "signup.panel.email"/></label>
                            <input type="email"
                                   class="form-control"
                                   id="inputEmail"
                                   placeholder="<@s.message "signup.panel.email"/>"
                                   required
                                   ng-model="auth.username">
                        </div>
                        <div class="form-group">
                            <label id="inputPasswordLabel" class="control-label"
                                   for="inputPassword"><@s.message "signup.panel.password"/></label>
                            <input type="password"
                                   class="form-control"
                                   id="inputPassword"
                                   placeholder="<@s.message "signup.panel.password"/>"
                                   required
                                   ng-model="auth.password">
                        </div>
                        <button id="btnSubmit" type="submit" class="btn btn-success"
                                ng-disabled="form.$invalid">
                            <@s.message "signup.panel.button.signup"/>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<script type="text/javascript" src="/js/signup.js"></script>
</body>
</html>