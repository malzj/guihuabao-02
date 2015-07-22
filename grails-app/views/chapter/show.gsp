
<%@ page import="com.guihuabao.Chapter" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'chapter.label', default: 'Chapter')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-chapter" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-chapter" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list chapter">
			
				<g:if test="${chapterInstance?.chapterName}">
				<li class="fieldcontain">
					<span id="chapterName-label" class="property-label"><g:message code="chapter.chapterName.label" default="Chapter Name" /></span>
					
						<span class="property-value" aria-labelledby="chapterName-label"><g:fieldValue bean="${chapterInstance}" field="chapterName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${chapterInstance?.remark}">
				<li class="fieldcontain">
					<span id="remark-label" class="property-label"><g:message code="chapter.remark.label" default="Remark" /></span>
					
						<span class="property-value" aria-labelledby="remark-label"><g:fieldValue bean="${chapterInstance}" field="remark"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${chapterInstance?.contents}">
				<li class="fieldcontain">
					<span id="contents-label" class="property-label"><g:message code="chapter.contents.label" default="Contents" /></span>
					
						<g:each in="${chapterInstance.contents}" var="c">
						<span class="property-value" aria-labelledby="contents-label"><g:link controller="content" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${chapterInstance?.dateCreate}">
				<li class="fieldcontain">
					<span id="dateCreate-label" class="property-label"><g:message code="chapter.dateCreate.label" default="Date Create" /></span>
					
						<span class="property-value" aria-labelledby="dateCreate-label"><g:formatDate date="${chapterInstance?.dateCreate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${chapterInstance?.syllabus}">
				<li class="fieldcontain">
					<span id="syllabus-label" class="property-label"><g:message code="chapter.syllabus.label" default="Syllabus" /></span>
					
						<span class="property-value" aria-labelledby="syllabus-label"><g:link controller="syllabus" action="show" id="${chapterInstance?.syllabus?.id}">${chapterInstance?.syllabus?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${chapterInstance?.id}" />
					<g:link class="edit" action="edit" id="${chapterInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
