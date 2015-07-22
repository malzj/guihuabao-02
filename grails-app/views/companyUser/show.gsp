<%@ page import="com.guihuabao.CompanyUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'companyUser.label', default: 'CompanyUser')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<a href="#show-companyUser" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                  default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-companyUser" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list companyUser">

        <g:if test="${companyUserInstance?.username}">
            <li class="fieldcontain">
                <span id="username-label" class="property-label"><g:message code="companyUser.username.label"
                                                                            default="Username"/></span>

                <span class="property-value" aria-labelledby="username-label"><g:fieldValue
                        bean="${companyUserInstance}" field="username"/></span>

            </li>
        </g:if>

        <g:if test="${companyUserInstance?.password}">
            <li class="fieldcontain">
                <span id="password-label" class="property-label"><g:message code="companyUser.password.label"
                                                                            default="Password"/></span>

                <span class="property-value" aria-labelledby="password-label"><g:fieldValue
                        bean="${companyUserInstance}" field="password"/></span>

            </li>
        </g:if>

        <g:if test="${companyUserInstance?.cid}">
            <li class="fieldcontain">
                <span id="cid-label" class="property-label"><g:message code="companyUser.cid.label"
                                                                       default="Cid"/></span>

                <span class="property-value" aria-labelledby="cid-label"><g:fieldValue bean="${companyUserInstance}"
                                                                                       field="cid"/></span>

            </li>
        </g:if>

        <g:if test="${companyUserInstance?.rid}">
            <li class="fieldcontain">
                <span id="rid-label" class="property-label"><g:message code="companyUser.rid.label"
                                                                       default="Rid"/></span>

                <span class="property-value" aria-labelledby="rid-label"><g:fieldValue bean="${companyUserInstance}"
                                                                                       field="rid"/></span>

            </li>
        </g:if>

        <g:if test="${companyUserInstance?.name}">
            <li class="fieldcontain">
                <span id="name-label" class="property-label"><g:message code="companyUser.name.label"
                                                                        default="Name"/></span>

                <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${companyUserInstance}"
                                                                                        field="name"/></span>

            </li>
        </g:if>

        <g:if test="${companyUserInstance?.img}">
            <li class="fieldcontain">
                <span id="img-label" class="property-label"><g:message code="companyUser.img.label"
                                                                       default="Img"/></span>

                <span class="property-value" aria-labelledby="img-label"><g:fieldValue bean="${companyUserInstance}"
                                                                                       field="img"/></span>

            </li>
        </g:if>

        <g:if test="${companyUserInstance?.sex}">
            <li class="fieldcontain">
                <span id="sex-label" class="property-label"><g:message code="companyUser.sex.label"
                                                                       default="Sex"/></span>

                <span class="property-value" aria-labelledby="sex-label"><g:fieldValue bean="${companyUserInstance}"
                                                                                       field="sex"/></span>

            </li>
        </g:if>

        <g:if test="${companyUserInstance?.phone}">
            <li class="fieldcontain">
                <span id="phone-label" class="property-label"><g:message code="companyUser.phone.label"
                                                                         default="Phone"/></span>

                <span class="property-value" aria-labelledby="phone-label"><g:fieldValue bean="${companyUserInstance}"
                                                                                         field="phone"/></span>

            </li>
        </g:if>

        <g:if test="${companyUserInstance?.bid}">
            <li class="fieldcontain">
                <span id="bid-label" class="property-label"><g:message code="companyUser.bid.label"
                                                                       default="Bid"/></span>

                <span class="property-value" aria-labelledby="bid-label"><g:fieldValue bean="${companyUserInstance}"
                                                                                       field="bid"/></span>

            </li>
        </g:if>

        <g:if test="${companyUserInstance?.dateCreat}">
            <li class="fieldcontain">
                <span id="dateCreat-label" class="property-label"><g:message code="companyUser.dateCreat.label"
                                                                             default="Date Creat"/></span>

                <span class="property-value" aria-labelledby="dateCreat-label"><g:formatDate
                        date="${companyUserInstance?.dateCreat}"/></span>

            </li>
        </g:if>

    </ol>
    <g:form>
        <fieldset class="buttons">
            <g:hiddenField name="id" value="${companyUserInstance?.id}"/>
            <g:link class="edit" action="edit" id="${companyUserInstance?.id}"><g:message
                    code="default.button.edit.label" default="Edit"/></g:link>
            <g:actionSubmit class="delete" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
