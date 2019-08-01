<#macro page>
    <#import "/spring.ftl" as s/>

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="/css/bootstrap.min.css">
        <title><@s.message "admission.title"/></title>
    </head>

    <body>
    <#include "navbar.ftl">
    <div class="container-fluid mt-5">
        <#nested>
    </div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Bootstrap JS -->
    <script src="/jquery/jquery-3.4.1.slim.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    </body>
    </html>
</#macro>
