<%@ page import="com.guihuabao.Role" %>



<div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'remark', 'error')} ">
	<label for="remark">
		<g:message code="role.remark.label" default="Remark" />
		
	</label>
	<g:textField name="remark" value="${roleInstance?.remark}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'rolename', 'error')} ">
	<label for="rolename">
		<g:message code="role.rolename.label" default="Rolename" />
		
	</label>
	<g:textField name="rolename" value="${roleInstance?.rolename}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'dateCreat', 'error')} required">
	<label for="dateCreat">
		<g:message code="role.dateCreat.label" default="Date Creat" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dateCreat" precision="day"  value="${roleInstance?.dateCreat}"  />
</div>

