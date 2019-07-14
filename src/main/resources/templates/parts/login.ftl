<#macro login path isRegisterForm>
    <#import "/spring.ftl" as s/>

    <form class="needs-validation" novalidate action="${path}" method="post">
        <div class="form-group-row">
            <label class="control-label"
                   for="inputUsername"><@s.message "form.control.username"/></label>
            <input type="text"
                   class="form-control ${(usernameError??)?string('is-invalid', '')}"
                   id="inputUsername"
                   placeholder="<@s.message "form.control.username"/>"
                   value="<#if user??>${user.username}</#if>"
                   required
                   autofocus
                   name="username">
            <#if usernameError??>
                <div class="invalid-feedback">
                    <@s.message "${usernameError}"/>
                </div>
            </#if>
        </div>
        <div class="form-group-row">
            <label class="control-label"
                   for="inputPassword"><@s.message "form.control.password"/></label>
            <input type="password"
                   class="form-control ${(passwordError??)?string('is-invalid', '')}"
                   id="inputPassword"
                   placeholder="<@s.message "form.control.password"/>"
                   required
                   name="password">
            <#if passwordError??>
                <div class="invalid-feedback">
                    <@s.message "${passwordError}"/>
                </div>
            </#if>
        </div>
        <#if !isRegisterForm>
            <div class="form-group-row">
                <div class="col-sm-offset-2 col-12">
                    <div class="row justify-content-between">
                        <div class="col-md-7 mt-2 checkbox">
                            <label>
                                <input type="checkbox" name='remember-me'> <@s.message "form.control.rememberMe"/>
                            </label>
                        </div>
                        <div class="col-md-5 mt-2">
                            <p class="text-right"><a href="/signup"><@s.message "form.link.signup"/></a></p>
                        </div>
                    </div>
                </div>
            </div>
        </#if>
        <#if isRegisterForm>
            <div class="form-group-row">
                <label class="control-label"
                       for="inputPasswordRetype"><@s.message "form.control.passwordRetype"/></label>
                <input type="password"
                       class="form-control ${(password2Error??)?string('is-invalid', '')}"
                       id="inputPasswordRetype"
                       placeholder="<@s.message "form.control.passwordRetype"/>"
                       required
                       name="password2">
                <#if password2Error??>
                    <div class="invalid-feedback">
                        <@s.message "${password2Error}"/>
                    </div>
                </#if>
            </div>
            <div class="form-group-row">
                <label class="control-label"
                       for="inputEmail"><@s.message "form.control.email"/></label>
                <input type="email"
                       class="form-control ${(emailError??)?string('is-invalid', '')}"
                       id="inputEmail"
                       placeholder="<@s.message "form.control.email"/>"
                       value="<#if user??>${user.email}</#if>"
                       required
                       name="email">
                <#if emailError??>
                    <div class="invalid-feedback">
                        <@s.message "form.invalid.email"/>
                    </div>
                </#if>
            </div>
            <div class="form-group-row">
                <label class="control-label"
                       for="inputFirstName"><@s.message "form.control.firstName"/></label>
                <input type="text"
                       class="form-control ${(firstNameError??)?string('is-invalid', '')}"
                       id="inputFirstName"
                       placeholder="<@s.message "form.control.firstName"/>"
                       value="<#if user??>${user.firstName}</#if>"
                       required
                       name="firstName">
                <#if firstNameError??>
                    <div class="invalid-feedback">
                        <@s.message "form.invalid.firstName"/>
                    </div>
                </#if>
            </div>
            <div class="form-group-row">
                <label class="control-label"
                       for="inputLastName"><@s.message "form.control.lastName"/></label>
                <input type="text"
                       class="form-control ${(lastNameError??)?string('is-invalid', '')}"
                       id="inputLastName"
                       placeholder="<@s.message "form.control.lastName"/>"
                       value="<#if user??>${user.lastName}</#if>"
                       required
                       name="lastName">
                <#if lastNameError??>
                    <div class="invalid-feedback">
                        <@s.message "form.invalid.lastName"/>
                    </div>
                </#if>
            </div>
        </#if>
        <div class="form-group-row">
            <div class="col-sm-offset-2 col-sm-6 mt-2">
                <button id="btnSubmit" type="submit" class="btn btn-success">
                    <#if isRegisterForm>
                        <@s.message "form.button.signup"/>
                    <#else>
                        <@s.message "form.button.login"/>
                    </#if>
                </button>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    </form>
</#macro>

<#macro logout>
    <#include "security.ftl">
    <#import "/spring.ftl" as s/>

    <#if known>
        <form action="/logout" method="post">
            <button class="btn btn-secondary" type="submit">
                <@s.message "menu.logout"/>
            </button>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        </form>
    <#else>
        <a class="btn btn-primary" href="/login" role="button"><@s.message "menu.login"/></a>
    </#if>
</#macro>