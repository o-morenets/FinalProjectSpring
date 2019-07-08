<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Info</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<#include "parts/lang.ftl">
<#include "parts/menu.ftl">

<h2>User Info Page</h2>
<h3>Welcome : <span>@{request.userPrincipal.name}</span></h3>
<b>This is protected page!</b> 
<br/><br/>
<div>${userInfo}></div>
</body>
</html>