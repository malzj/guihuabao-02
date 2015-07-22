<%@ page import="com.guihuabao.CompanyUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'companyUser.label', default: 'CompanyUser')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<a href="#list-companyUser" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                  default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="list-companyUser" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>

            <g:sortableColumn property="username"
                              title="${message(code: 'companyUser.username.label', default: 'Username')}"/>

            <g:sortableColumn property="password"
                              title="${message(code: 'companyUser.password.label', default: 'Password')}"/>

            <g:sortableColumn property="cid" title="${message(code: 'companyUser.cid.label', default: 'Cid')}"/>

            <g:sortableColumn property="rid" title="${message(code: 'companyUser.rid.label', default: 'Rid')}"/>

            <g:sortableColumn property="name" title="${message(code: 'companyUser.name.label', default: 'Name')}"/>

            <g:sortableColumn property="img" title="${message(code: 'companyUser.img.label', default: 'Img')}"/>

        </tr>
        </thead>
        <tbody>
        <g:each in="${companyUserInstanceList}" status="i" var="companyUserInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${companyUserInstance.id}">${fieldValue(bean: companyUserInstance, field: "username")}</g:link></td>

                <td>${fieldValue(bean: companyUserInstance, field: "password")}</td>

                <td>${fieldValue(bean: companyUserInstance, field: "cid")}</td>

                <td>${fieldValue(bean: companyUserInstance, field: "rid")}</td>

                <td>${fieldValue(bean: companyUserInstance, field: "name")}</td>

                <td>${fieldValue(bean: companyUserInstance, field: "img")}</td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${companyUserInstanceTotal}"/>
    </div>
</div>
</body>
</html>
