<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>

<@c.page>
    <h5>${usr.getLastName()} ${usr.getFirstName()}</h5>
    <@s.message "user.speciality.name"/>:
    <#if usr.getSpeciality()??>
        <span class="badge badge-info">${usr.getSpeciality().getName()}</span>
        <br/>

        <#if subjectDtoList?has_content>
            Subjects:
            <table>
                <thead>
                <tr>
                    <th>Subject</th>
                    <th>Grade</th>
                </tr>
                </thead>
                <tbody>
                <#list subjectDtoList as subjectDto>
                    <tr>
                        <td>${subjectDto.name}</td>
                        <td><#if subjectDto.grade??>${subjectDto.grade}<#else>---</#if></td>
                    </tr>
                </#list>
                </tbody>
            </table>
        <#else>
            - No subjects -
        </#if>
    <#else>
        <@s.message "user.speciality.notSelected"/>
        <a href="/users/${usr.getId()}/selectSpec" class="badge badge-warning">Select</a>
    </#if>
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
</@c.page>
