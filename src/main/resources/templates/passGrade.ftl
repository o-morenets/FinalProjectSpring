<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as s/>

<@c.page>
    <div class="row">
        <div class="mx-auto">
            <form action="/users/sendMessages" method="post">
                <div class="form-group-row">
                    <label for="passGrade">
                        <@s.message "form.control.passGrade"/>
                    </label>
                    <input id="passGrade" type="number" min="0" max="100" step="any" name="passGrade">
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
</@c.page>