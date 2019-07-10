<!DOCTYPE HTML>
<#import "/spring.ftl" as s/>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><@s.message "welcome.title"/></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>

<body>
<div class="container">
    <#include "parts/lang.ftl">
    <#include "parts/menu.ftl">

    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <h2>
                <@s.message "welcome.message"/>
            </h2>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <a href="/spec">Get All Specialities (GET)</a>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            Add Speciality (POST)
            <form method="post" action="/spec">
                <div class="row">
                    <div class="col">
                        <input name="name" type="text" class="form-control" placeholder="Speciality name">
                    </div>
                </div>
                <button type="submit" class="btn btn-secondary">Add</button>
                <input name="${_csrf.parameterName}" value="${_csrf.token}" type="hidden"/>
            </form>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <a href="/specialities/1/users">Get All Users (GET)</a>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            Add User (POST)
            <form method="post" action="/specialities/1/users">
                <div class="row">
                    <div class="col">
                        <input name="firstName" type="text" class="form-control" placeholder="First name">
                    </div>
                    <div class="col">
                        <input name="lastName" type="text" class="form-control" placeholder="Last name">
                    </div>
                </div>
                <input name="${_csrf.parameterName}" value="${_csrf.token}" type="hidden"/>
                <button type="submit" class="btn btn-secondary">Add</button>
            </form>
        </div>
    </div>

</div>
</body>
</html>