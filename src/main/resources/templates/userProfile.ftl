<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>

<@c.page>
    <h5>${principal.getLastName()} ${principal.getFirstName()}</h5>
    <@s.message "user.speciality.name"/>:
    <#if principal.getSpeciality()??>
        <span class="badge badge-info">${principal.getSpeciality().getName()}</span>
        <br/>
        Grades:
        <#list grades as grade>
            <tr>
                <td>${grade.getSubject()}</td>
                <td>${grade.getGrade()}</td>
            </tr>
        </#list>
    <#else>
        <@s.message "user.speciality.notSelected"/>
        <a href="${principal.getId()}" class="badge badge-warning">Select</a>
    </#if>
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
</@c.page>
