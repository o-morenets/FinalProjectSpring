<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>
<#include "parts/security.ftl">

<@c.page>
    <div class="row justify-content-center">
        <div class="card">
            <div class="card-header">
                <h5>${user.lastName} ${user.firstName}</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col">
                        <@s.message "user.speciality.name"/>:
                    </div>

                    <#if user.speciality??>
                        <div class="col">
                            <span class="badge badge-info mb-3">${user.speciality.name}</span>
                        </div>
                    <#else>
                        <@s.message "user.speciality.notSelected"/>
                        <#if !isAdmin>
                            <a href="/users/${user.getId()}/speciality" class="badge badge-warning ml-3">
                                <@s.message "button.select"/>
                            </a>
                        </#if>
                    </#if>
                </div>

                <#if user.speciality??>
                    <div class="row">
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
                                    <div class="form-row text-center">
                                        <div class="col-12">
                                            <button type="submit" class="btn btn-primary mt-3">
                                                <@s.message "button.save"/>
                                            </button>
                                        </div>
                                    </div>
                                </#if>
                            <#else>
                                <@s.message "message.noSubjects"/>
                            </#if>
                            <input type="hidden" name="userId" value="${user.id}"/>
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        </form>
                    </div>
                </#if>
            </div>
            <#if !isAdmin && user.speciality??>
                <div class="card-footer text-muted">
                    <@s.message "user.averageGrade"/>
                </div>
            </#if>
        </div>
    </div>
</@c.page>
