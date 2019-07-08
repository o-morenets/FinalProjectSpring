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

</div>
</body>
</html>