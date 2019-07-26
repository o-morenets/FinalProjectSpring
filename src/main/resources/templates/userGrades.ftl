<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>
<#include "parts/security.ftl">

<@c.page>
    <h5>${user.getLastName()} ${user.getFirstName()}</h5>
    <@s.message "user.speciality.name"/>:

    <#if user.getSpeciality()??>
        <span class="badge badge-info">${user.getSpeciality().getName()}</span>
        <br/>

        <form action="/users/updateGrades" method="post">
            <#if userSubjectGradeDtoList?has_content>
                <table>
                    <thead>
                    <tr>
                        <th><@s.message "userGrades.table.subject"/></th>
                        <th><@s.message "userGrades.table.grade"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list userSubjectGradeDtoList as userSubjectGradeDto>
                        <tr>
                            <td>
                                <label for="subject_${userSubjectGradeDto.subjectId}">${userSubjectGradeDto.subjectName}</label>
                            </td>
                            <td>
                                <input type="number"
                                       id="subject_${userSubjectGradeDto.subjectId}"
                                       name="subject_${userSubjectGradeDto.subjectId}"
                                       value="<#if userSubjectGradeDto.grade??>${userSubjectGradeDto.grade}</#if>"
                                       <#if !isAdmin>disabled</#if>
                                >
                            </td>
                        </tr>
                    </#list>
                    </tbody>
                </table>

                <#if isAdmin>
                    <button type="submit"><@s.message "button.save"/></button>
                </#if>
            <#else>
                <@s.message "msg.noSubjects"/>
            </#if>
            <input type="hidden" name="userId" value="${user.id}"/>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        </form>
    <#else>
        <@s.message "user.speciality.notSelected"/>
        <#if !isAdmin>
            <a href="/users/${user.getId()}/selectSpec" class="badge badge-warning"><@s.message "button.select"/></a>
        </#if>
    </#if>
</@c.page>
