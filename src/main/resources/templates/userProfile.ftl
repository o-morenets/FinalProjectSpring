<#import "parts/common.ftl" as c>

<@c.page>
    <h5>${user.getUsername()}</h5>
    <form method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Email:</label>
            <div class="col-sm-6">
                <label>
                    <input type="email" name="email" class="form-control" placeholder="some@some.com"
                           value="${user.getEmail()!''}" />
                </label>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">First Name:</label>
            <div class="col-sm-6">
                <label>
                    <input type="text" name="firstName" class="form-control" placeholder="First Name"
                           value="${user.getFirstName()!''}"/>
                </label>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Last Name:</label>
            <div class="col-sm-6">
                <label>
                    <input type="text" name="lastName" class="form-control" placeholder="Last Name"
                           value="${user.getLastName()!''}"/>
                </label>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button class="btn btn-primary" type="submit">Save</button>
    </form>
</@c.page>
