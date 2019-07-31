<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>
<#include "parts/security.ftl">

<@c.page>
    <h5>${user.lastName} ${user.firstName}</h5>
    <@s.message "user.speciality.name"/>:

    <#if user.speciality??>
        <span class="badge badge-info">${user.speciality.name}</span>
        <br/>

        <form action="/users/updateGrades" method="post">
            <#if userSubjectGradeList?has_content>
                <table>
                    <thead>
                    <tr>
                        <th><@s.message "userGrades.table.subject"/></th>
                        <th><@s.message "userGrades.table.grade"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list userSubjectGradeList as userSubjectGrade>
                        <tr>
                            <td>
                                <label for="subject_${userSubjectGrade.subject.id}">
                                    ${userSubjectGrade.subject.name}
                                </label>
                            </td>
                            <td>
                                <input type="number"
                                       id="subject_${userSubjectGrade.subject.id}"
                                       name="subject_${userSubjectGrade.subject.id}"
                                       value="<#if userSubjectGrade.grade??>${userSubjectGrade.grade}</#if>"
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
                <@s.message "message.noSubjects"/>
            </#if>
            <input type="hidden" name="userId" value="${user.id}"/>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        </form>
    <#else>
        <@s.message "user.speciality.notSelected"/>
        <#if !isAdmin>
            <a href="/users/${user.getId()}/speciality" class="badge badge-warning"><@s.message "button.select"/></a>
        </#if>
    </#if>
</@c.page>
