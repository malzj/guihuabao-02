
<%@ page import="com.guihuabao.Company" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'company.label', default: 'Company')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-company" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-company" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list company">
			
				<g:if test="${companyInstance?.companyname}">
				<li class="fieldcontain">
					<span id="companyname-label" class="property-label"><g:message code="company.companyname.label" default="Companyname" /></span>
					
						<span class="property-value" aria-labelledby="companyname-label"><g:fieldValue bean="${companyInstance}" field="companyname"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${companyInstance?.remark}">
				<li class="fieldcontain">
					<span id="remark-label" class="property-label"><g:message code="company.remark.label" default="Remark" /></span>
					
						<span class="property-value" aria-labelledby="remark-label"><g:fieldValue bean="${companyInstance}" field="remark"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${companyInstance?.address}">
				<li class="fieldcontain">
					<span id="address-label" class="property-label"><g:message code="company.address.label" default="Address" /></span>
					
						<span class="property-value" aria-labelledby="address-label"><g:fieldValue bean="${companyInstance}" field="address"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${companyInstance?.phone}">
				<li class="fieldcontain">
					<span id="phone-label" class="property-label"><g:message code="company.phone.label" default="Phone" /></span>
					
						<span class="property-value" aria-labelledby="phone-label"><g:fieldValue bean="${companyInstance}" field="phone"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${companyInstance?.dateCreat}">
				<li class="fieldcontain">
					<span id="dateCreat-label" class="property-label"><g:message code="company.dateCreat.label" default="Date Creat" /></span>
					
						<span class="property-value" aria-labelledby="dateCreat-label"><g:formatDate date="${companyInstance?.dateCreat}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${companyInstance?.dateUse}">
				<li class="fieldcontain">
					<span id="dateUse-label" class="property-label"><g:message code="company.dateUse.label" default="Date Use" /></span>
					
						<span class="property-value" aria-labelledby="dateUse-label"><g:formatDate date="${companyInstance?.dateUse}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${companyInstance?.id}" />
					<g:link class="edit" action="edit" id="${companyInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
