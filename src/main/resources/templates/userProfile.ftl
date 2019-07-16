<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>

<@c.page>
    <h5>${usr.getLastName()} ${usr.getFirstName()}</h5>
    <@s.message "user.speciality.name"/>:
    <#if usr.getSpeciality()??>
        <span class="badge badge-info">${usr.getSpeciality().getName()}</span>
        <br/>
        Grades:
        <#list grades as grade>
            <#if grade??>
                <tr>
                    <td>${grade.getSubject()}</td>
                    <td>${grade.getGrade()}</td>
                </tr>
            </#if>
        </#list>
    <#else>
        <@s.message "user.speciality.notSelected"/>
        <a href="${usr.getId()}" class="badge badge-warning">Select</a>
    </#if>
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
</@c.page>
