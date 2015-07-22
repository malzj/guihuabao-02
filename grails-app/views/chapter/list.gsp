
<%@ page import="com.guihuabao.Chapter" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'chapter.label', default: 'Chapter')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-chapter" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-chapter" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="chapterName" title="${message(code: 'chapter.chapterName.label', default: 'Chapter Name')}" />
					
						<g:sortableColumn property="remark" title="${message(code: 'chapter.remark.label', default: 'Remark')}" />
					
						<g:sortableColumn property="dateCreate" title="${message(code: 'chapter.dateCreate.label', default: 'Date Create')}" />
					
						<th><g:message code="chapter.syllabus.label" default="Syllabus" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${chapterInstanceList}" status="i" var="chapterInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${chapterInstance.id}">${fieldValue(bean: chapterInstance, field: "chapterName")}</g:link></td>
					
						<td>${fieldValue(bean: chapterInstance, field: "remark")}</td>
					
						<td><g:formatDate date="${chapterInstance.dateCreate}" /></td>
					
						<td>${fieldValue(bean: chapterInstance, field: "syllabus")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${chapterInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
