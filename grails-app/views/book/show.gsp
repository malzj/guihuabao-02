
<%@ page import="com.guihuabao.Book" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-book" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-book" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list book">
			
				<g:if test="${bookInstance?.bookName}">
				<li class="fieldcontain">
					<span id="bookName-label" class="property-label"><g:message code="book.bookName.label" default="Book Name" /></span>
					
						<span class="property-value" aria-labelledby="bookName-label"><g:fieldValue bean="${bookInstance}" field="bookName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bookInstance?.bookImg}">
				<li class="fieldcontain">
					<span id="bookImg-label" class="property-label"><g:message code="book.bookImg.label" default="Book Img" /></span>
					
						<span class="property-value" aria-labelledby="bookImg-label"><g:fieldValue bean="${bookInstance}" field="bookImg"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bookInstance?.remark}">
				<li class="fieldcontain">
					<span id="remark-label" class="property-label"><g:message code="book.remark.label" default="Remark" /></span>
					
						<span class="property-value" aria-labelledby="remark-label"><g:fieldValue bean="${bookInstance}" field="remark"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bookInstance?.dateCreate}">
				<li class="fieldcontain">
					<span id="dateCreate-label" class="property-label"><g:message code="book.dateCreate.label" default="Date Create" /></span>
					
						<span class="property-value" aria-labelledby="dateCreate-label"><g:formatDate date="${bookInstance?.dateCreate}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${bookInstance?.id}" />
					<g:link class="edit" action="edit" id="${bookInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
