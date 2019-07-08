<!DOCTYPE html>
<#import "/spring.ftl" as s/>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><@s.message "signup.title"/></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>

<body>
<div class="container">
    <#include "parts/lang.ftl">
    <#include "parts/menu.ftl">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><@s.message "signup.panel.title"/></h3>
            </div>
            <div class="panel-body">
                <form method="post" action="/api/reg_form" name="form" autocomplete="off" novalidate>
                    <div class="form-group">
                        <label id="inputFirstNameLabel"
                               for="inputFirstName"><@s.message "signup.panel.firstName"/></label>
                        <input type="text"
                               class="form-control"
                               id="inputFirstName"
                               placeholder="<@s.message "signup.panel.firstName"/>"
                               required
                               name="firstName">
                    </div>
                    <div class="form-group">
                        <label id="inputLastNameLabel"
                               for="inputLastName"><@s.message "signup.panel.lastName"/></label>
                        <input type="text"
                               class="form-control"
                               id="inputLastName"
                               placeholder="<@s.message "signup.panel.lastName"/>"
                               required
                               name="lastName">
                    </div>
                    <div class="form-group">
                        <label id="inputEmailLabel" for="inputEmail"><@s.message "signup.panel.email"/></label>
                        <input type="email"
                               class="form-control"
                               id="inputEmail"
                               placeholder="<@s.message "signup.panel.email"/>"
                               required
                               name="username">
                    </div>
                    <div class="form-group">
                        <label id="inputPasswordLabel" class="control-label"
                               for="inputPassword"><@s.message "signup.panel.password"/></label>
                        <input type="password"
                               class="form-control"
                               id="inputPassword"
                               placeholder="<@s.message "signup.panel.password"/>"
                               required
                               name="password">
                    </div>
                    <button id="btnSubmit" type="submit" class="btn btn-success">
                        <@s.message "signup.panel.button.signup"/>
                    </button>
                    <input name="${_csrf.parameterName}" value="${_csrf.token}" type="hidden"/>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>