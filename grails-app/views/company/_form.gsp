<%@ page import="com.guihuabao.Company" %>



<div class="fieldcontain ${hasErrors(bean: companyInstance, field: 'companyname', 'error')} ">
	<label for="companyname">
		<g:message code="company.companyname.label" default="Companyname" />
		
	</label>
	<g:textField name="companyname" value="${companyInstance?.companyname}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyInstance, field: 'remark', 'error')} ">
	<label for="remark">
		<g:message code="company.remark.label" default="Remark" />
		
	</label>
	<g:textField name="remark" value="${companyInstance?.remark}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyInstance, field: 'address', 'error')} ">
	<label for="address">
		<g:message code="company.address.label" default="Address" />
		
	</label>
	<g:textField name="address" value="${companyInstance?.address}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyInstance, field: 'phone', 'error')} ">
	<label for="phone">
		<g:message code="company.phone.label" default="Phone" />
		
	</label>
	<g:textField name="phone" value="${companyInstance?.phone}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyInstance, field: 'dateCreat', 'error')} required">
	<label for="dateCreat">
		<g:message code="company.dateCreat.label" default="Date Creat" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dateCreat" precision="day"  value="${companyInstance?.dateCreat}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: companyInstance, field: 'dateUse', 'error')} required">
	<label for="dateUse">
		<g:message code="company.dateUse.label" default="Date Use" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dateUse" precision="day"  value="${companyInstance?.dateUse}"  />
</div>

