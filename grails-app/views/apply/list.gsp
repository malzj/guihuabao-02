
<%@ page import="com.guihuabao.Apply" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'apply.label', default: 'Apply')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-apply" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-apply" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="type" title="${message(code: 'apply.type.label', default: 'Type')}" />
					
						<g:sortableColumn property="applyuid" title="${message(code: 'apply.applyuid.label', default: 'Applyuid')}" />
					
						<g:sortableColumn property="applyusername" title="${message(code: 'apply.applyusername.label', default: 'Applyusername')}" />
					
						<g:sortableColumn property="content" title="${message(code: 'apply.content.label', default: 'Content')}" />
					
						<g:sortableColumn property="approvaluid" title="${message(code: 'apply.approvaluid.label', default: 'Approvaluid')}" />
					
						<g:sortableColumn property="approvalusername" title="${message(code: 'apply.approvalusername.label', default: 'Approvalusername')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${applyInstanceList}" status="i" var="applyInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${applyInstance.id}">${fieldValue(bean: applyInstance, field: "type")}</g:link></td>
					
						<td>${fieldValue(bean: applyInstance, field: "applyuid")}</td>
					
						<td>${fieldValue(bean: applyInstance, field: "applyusername")}</td>
					
						<td>${fieldValue(bean: applyInstance, field: "content")}</td>
					
						<td>${fieldValue(bean: applyInstance, field: "approvaluid")}</td>
					
						<td>${fieldValue(bean: applyInstance, field: "approvalusername")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${applyInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
