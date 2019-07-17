<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>

<@c.page>
    <h5>${usr.getLastName()} ${usr.getFirstName()}</h5>
    <@s.message "user.speciality.name"/>:
    <#if usr.getSpeciality()??>
        <span class="badge badge-info">${usr.getSpeciality().getName()}</span>
        <br/>
        <#if gradesDto?has_content>
            Grades:
            <table>
                <thead>
                <tr>
                    <th>Subject</th>
                    <th>Grade</th>
                </tr>
                </thead>
                <tbody>
                <#list gradesDto as grade>
                    <tr>
                        <td>${grade.getSubject().getName()}</td>
                        <td>${grade.getGrade()}</td>
                    </tr>
                </#list>
                </tbody>
            </table>
        <#else>
            - No grades -
        </#if>
    <#else>
        <@s.message "user.speciality.notSelected"/>
        <a href="${usr.getId()}" class="badge badge-warning">Select</a>
    </#if>
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
</@c.page>
