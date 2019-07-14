<#macro login path isRegisterForm>
    <#import "/spring.ftl" as s/>

    <form action="${path}" method="post">
        <div class="form-group-row">
            <label id="inputUsernameLabel"
                   for="inputUsernameEl"><@s.message "login.panel.username"/></label>
            <input type="text"
                   class="form-control"
                   id="inputUsernameEl"
                   placeholder="<@s.message "login.panel.username"/>"
                   required
                   autofocus
                   name="username">
        </div>
        <div class="form-group-row">
            <label id="inputPasswordLabel"
                   for="inputPasswordEl"><@s.message "login.panel.password"/></label>
            <input type="password"
                   class="form-control"
                   id="inputPasswordEl"
                   placeholder="<@s.message "login.panel.password"/>"
                   required
                   name="password">
        </div>
        <#if !isRegisterForm>
            <div class="form-group-row">
                <div class="col-sm-offset-2 col-12">
                    <div class="row justify-content-between">
                        <div class="col-md-7 mt-2 checkbox">
                            <label>
                                <input type="checkbox" name='remember-me'> <@s.message "login.panel.rememberMe"/>
                            </label>
                        </div>
                        <div class="col-md-5 mt-2">
                            <p class="text-right"><a href="/signup"><@s.message "login.panel.signup"/></a></p>
                        </div>
                    </div>
                </div>
            </div>
        </#if>
        <#if isRegisterForm>
            <div class="form-group-row">
                <label id="inputPasswordLabel" class="control-label"
                       for="inputPassword"><@s.message "signup.panel.password"/></label>
                <input type="password"
                       class="form-control ${(password2Error??)?string('is-invalid', '')}"
                       id="inputPassword"
                       placeholder="<@s.message "signup.panel.passwordRetype"/>"
                       required
                       name="password2">
                <#if password2Error??>
                    <div class="invalid-feedback">
                        <@s.message "signup.password.empty" />
                    </div>
                </#if>
            </div>
            <div class="form-group-row">
                <label id="inputEmailLabel"
                       for="inputEmailEl"><@s.message "login.panel.email"/></label>
                <input type="email"
                       class="form-control"
                       id="inputEmailEl"
                       placeholder="<@s.message "login.panel.email"/>"
                       required
                       autofocus
                       name="email">
            </div>
            <div class="form-group-row">
                <label id="inputFirstNameLabel"
                       for="inputFirstName"><@s.message "signup.panel.firstName"/></label>
                <input type="text"
                       class="form-control ${(firstNameError??)?string('is-invalid', '')}"
                       id="inputFirstName"
                       placeholder="<@s.message "signup.panel.firstName"/>"
                       value="<#if userSignupDto??>${userSignupDto.firstName}</#if>"
                       required
                       name="firstName">
                <#if firstNameError??>
                    <div class="invalid-feedback">
                        <@s.message "signup.firstName.empty"/>
                    </div>
                </#if>
            </div>
            <div class="form-group-row">
                <label id="inputLastNameLabel"
                       for="inputLastName"><@s.message "signup.panel.lastName"/></label>
                <input type="text"
                       class="form-control ${(lastNameError??)?string('is-invalid', '')}"
                       id="inputLastName"
                       placeholder="<@s.message "signup.panel.lastName"/>"
                       value="<#if userSignupDto??>${userSignupDto.lastName}</#if>"
                       required
                       name="lastName">
                <#if lastNameError??>
                    <div class="invalid-feedback">
                        <@s.message "signup.lastName.empty"/>
                    </div>
                </#if>
            </div>
        </#if>
        <div class="form-group-row">
            <div class="col-sm-offset-2 col-sm-6 mt-2">
                <button id="btnSubmit" type="submit" class="btn btn-success">
                    <#if isRegisterForm>
                        <@s.message "signup.panel.button.signup"/>
                    <#else>
                        <@s.message "login.panel.button.submit"/>
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
                <@s.message "menu.logout" />
            </button>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        </form>
    <#else>
        <a class="btn btn-primary" href="/login" role="button"><@s.message "menu.login" /></a>
    </#if>
</#macro>