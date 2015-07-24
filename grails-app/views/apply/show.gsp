
<%@ page import="com.guihuabao.Apply" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'apply.label', default: 'Apply')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-apply" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-apply" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list apply">
			
				<g:if test="${applyInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="apply.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${applyInstance}" field="type"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${applyInstance?.applyuid}">
				<li class="fieldcontain">
					<span id="applyuid-label" class="property-label"><g:message code="apply.applyuid.label" default="Applyuid" /></span>
					
						<span class="property-value" aria-labelledby="applyuid-label"><g:fieldValue bean="${applyInstance}" field="applyuid"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${applyInstance?.applyusername}">
				<li class="fieldcontain">
					<span id="applyusername-label" class="property-label"><g:message code="apply.applyusername.label" default="Applyusername" /></span>
					
						<span class="property-value" aria-labelledby="applyusername-label"><g:fieldValue bean="${applyInstance}" field="applyusername"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${applyInstance?.content}">
				<li class="fieldcontain">
					<span id="content-label" class="property-label"><g:message code="apply.content.label" default="Content" /></span>
					
						<span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${applyInstance}" field="content"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${applyInstance?.approvaluid}">
				<li class="fieldcontain">
					<span id="approvaluid-label" class="property-label"><g:message code="apply.approvaluid.label" default="Approvaluid" /></span>
					
						<span class="property-value" aria-labelledby="approvaluid-label"><g:fieldValue bean="${applyInstance}" field="approvaluid"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${applyInstance?.approvalusername}">
				<li class="fieldcontain">
					<span id="approvalusername-label" class="property-label"><g:message code="apply.approvalusername.label" default="Approvalusername" /></span>
					
						<span class="property-value" aria-labelledby="approvalusername-label"><g:fieldValue bean="${applyInstance}" field="approvalusername"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${applyInstance?.id}" />
					<g:link class="edit" action="edit" id="${applyInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
