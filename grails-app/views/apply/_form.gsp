<%@ page import="com.guihuabao.Apply" %>



<div class="fieldcontain ${hasErrors(bean: applyInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="apply.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${applyInstance?.type}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: applyInstance, field: 'applyuid', 'error')} ">
	<label for="applyuid">
		<g:message code="apply.applyuid.label" default="Applyuid" />
		
	</label>
	<g:textField name="applyuid" value="${applyInstance?.applyuid}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: applyInstance, field: 'applyusername', 'error')} ">
	<label for="applyusername">
		<g:message code="apply.applyusername.label" default="Applyusername" />
		
	</label>
	<g:textField name="applyusername" value="${applyInstance?.applyusername}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: applyInstance, field: 'content', 'error')} ">
	<label for="content">
		<g:message code="apply.content.label" default="Content" />
		
	</label>
	<g:textField name="content" value="${applyInstance?.content}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: applyInstance, field: 'approvaluid', 'error')} ">
	<label for="approvaluid">
		<g:message code="apply.approvaluid.label" default="Approvaluid" />
		
	</label>
	<g:textField name="approvaluid" value="${applyInstance?.approvaluid}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: applyInstance, field: 'approvalusername', 'error')} ">
	<label for="approvalusername">
		<g:message code="apply.approvalusername.label" default="Approvalusername" />
		
	</label>
	<g:textField name="approvalusername" value="${applyInstance?.approvalusername}"/>
</div>

