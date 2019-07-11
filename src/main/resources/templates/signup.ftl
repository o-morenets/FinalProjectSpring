<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>

<@c.page>
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><@s.message "signup.panel.title"/></h3>
                </div>
                <div class="panel-body">
                    <form method="post" action="/signup" name="form" autocomplete="off">
                        <div class="form-group">
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
                        <div class="form-group">
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
                        <div class="form-group">
                            <label id="inputEmailLabel" for="inputEmail"><@s.message "signup.panel.email"/></label>
                            <input type="email"
                                   class="form-control ${(emailError??)?string('is-invalid', '')}"
                                   id="inputEmail"
                                   placeholder="<@s.message "signup.panel.email"/>"
                                   value="<#if userSignupDto??>${userSignupDto.username}</#if>"
                                   required
                                   name="username">
                            <#if emailError??>
                                <div class="invalid-feedback">
                                    <@s.message "signup.email.userExists"/>
                                </div>
                            </#if>
                        </div>
                        <div class="form-group">
                            <label id="inputPasswordLabel" class="control-label"
                                   for="inputPassword"><@s.message "signup.panel.password"/></label>
                            <input type="password"
                                   class="form-control ${(passwordError??)?string('is-invalid', '')}"
                                   id="inputPassword"
                                   placeholder="<@s.message "signup.panel.password"/>"
                                   required
                                   name="password">
                            <#if passwordError??>
                                <div class="invalid-feedback">
                                    <@s.message "signup.password.different"/>
                                </div>
                            </#if>
                        </div>
                        <div class="form-group">
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
                        <button id="btnSubmit" type="submit" class="btn btn-success">
                            <@s.message "signup.panel.button.signup"/>
                        </button>
                        <input name="${_csrf.parameterName}" value="${_csrf.token}" type="hidden"/>
                    </form>
                </div>
            </div>
        </div>
    </div>
</@c.page>