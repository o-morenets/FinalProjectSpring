<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>

<@c.page>
    <div class="row">
        <div class="mx-auto">
            <div class="card">
                <div class="card-body">
                    <form action="/users/sendMessages" method="post" novalidate>
                        <div class="form-group-row">
                            <label for="passGrade">
                                <@s.message "form.control.passGrade"/>
                            </label>
                            <input class="form-control ${(passGradeError??)?string('is-invalid', '')}"
                                    id="passGrade" type="number" min="0.0" max="100.0" step="any" name="passGrade">
                            <#if passGradeError??>
                                <div class="invalid-feedback">
                                    <@s.message "${passGradeError}"/>
                                </div>
                            </#if>
                        </div>
                        <div class="form-group-row">
                            <button type="submit" class="btn btn-primary mt-3">
                                <@s.message "button.sendMessages"/>
                            </button>
                        </div>
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    </form>
                </div>
            </div>
        </div>
    </div>
</@c.page>