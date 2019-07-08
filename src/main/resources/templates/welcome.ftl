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
            <a href="/users">Get All Users (JSON)</a>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            Add user
            <form method="post" action="/users">
                <div class="row">
                    <div class="col">
                        <input name="firstName" type="text" class="form-control" placeholder="First name">
                    </div>
                    <div class="col">
                        <input name="lastName" type="text" class="form-control" placeholder="Last name">
                    </div>
                </div>
                <button type="submit" class="btn btn-secondary">Add</button>
            </form>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <a href="/users/1/subjects">Get All Subjects (JSON)</a>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            Add subject
            <form method="post" action="/users/1/subjects">
                <div class="row">
                    <div class="col">
                        <input name="name" type="text" class="form-control" placeholder="Subject name">
                    </div>
                </div>
                <button type="submit" class="btn btn-secondary">Add</button>
            </form>
        </div>
    </div>

</div>
</body>
</html>