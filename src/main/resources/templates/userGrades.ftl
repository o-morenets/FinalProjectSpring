<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>
<#include "parts/security.ftl">

<@c.page>
    <h5>${usr.getLastName()} ${usr.getFirstName()}</h5>
    <@s.message "user.speciality.name"/>:
    <#if usr.getSpeciality()??>
        <span class="badge badge-info">${usr.getSpeciality().getName()}</span>
        <br/>

        <form action="/users/updateGrades" method="post">
            <#if userSubjectGradeDtoList?has_content>
                <table>
                    <thead>
                    <tr>
                        <th>Subject</th>
                        <th>Grade</th>
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
                    <button type="submit">Save</button>
                </#if>
            <#else>
                - No subjects -
            </#if>
            <input type="hidden" name="userId" value="${usr.id}"/>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        </form>
    <#else>
        <@s.message "user.speciality.notSelected"/>
        <a href="/users/${usr.getId()}/selectSpec" class="badge badge-warning">Select</a>
    </#if>
</@c.page>
