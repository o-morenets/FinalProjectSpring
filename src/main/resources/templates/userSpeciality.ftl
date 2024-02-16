<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>

<@c.page>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">${user.lastName}: <@s.message "card.speciality.title"/></div>
                <div class="card-body">
                    <form action="/users/updateSpec" method="post">
                        <div class="accordion" id="accordionExample">
                            <div class="card">
                                <div class="card-header" id="headingNone">
                                    <h2 class="mb-0">
                                        <button class="btn btn-link" type="button" data-toggle="collapse"
                                                data-target="#collapseNone"
                                                aria-expanded="false" aria-controls="collapseNone">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="specRadios"
                                                       value="-1"
                                                       id="spec_none"
                                                       checked>
                                                <label class="form-check-label" for="spec_none">
                                                    ---
                                                </label>
                                            </div>
                                        </button>
                                    </h2>
                                </div>
                                <div id="collapseNone" class="collapse show" aria-labelledby="headingNone"
                                     data-parent="#accordionExample">
                                </div>
                            </div>

                            <#list specialities as speciality>
                                <div class="card">
                                    <div class="card-header" id="heading_${speciality.id}">
                                        <h2 class="mb-0">
                                            <button class="btn btn-link collapsed" type="button" data-toggle="collapse"
                                                    data-target="#collapse_${speciality.id}" aria-expanded="false"
                                                    aria-controls="collapse_${speciality.id}">

                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="specRadios"
                                                           value="${speciality.id}"
                                                           id="spec_${speciality.id}">
                                                    <label class="form-check-label" for="spec_${speciality.id}">
                                                        ${speciality.name}
                                                    </label>
                                                </div>
                                            </button>
                                        </h2>
                                    </div>
                                    <div id="collapse_${speciality.id}" class="collapse"
                                         aria-labelledby="heading_${speciality.id}"
                                         data-parent="#accordionExample">
                                        <div class="card-body">
                                            <#list speciality.subjects as subject>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            ${subject.name}
                                                        </td>
                                                    </tr>
                                                </table>
                                            </#list>
                                        </div>
                                    </div>
                                </div>
                            </#list>
                        </div>
                        <input type="hidden" name="userId" value="${user.id}"/>
<#--                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>-->
                        <div class="col-12 mt-3 text-center">
                            <button class="btn btn-primary" type="submit">
                                <@s.message "button.save"/>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</@c.page>
