<%@ page import="com.guihuabao.Book" %>



<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'bookName', 'error')} ">
	<label for="bookName">
		<g:message code="book.bookName.label" default="Book Name" />
		
	</label>
	<g:textField name="bookName" value="${bookInstance?.bookName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'bookImg', 'error')} ">
	<label for="bookImg">
		<g:message code="book.bookImg.label" default="Book Img" />
		
	</label>
	<g:textField name="bookImg" value="${bookInstance?.bookImg}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'remark', 'error')} ">
	<label for="remark">
		<g:message code="book.remark.label" default="Remark" />
		
	</label>
	<g:textField name="remark" value="${bookInstance?.remark}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'dateCreate', 'error')} required">
	<label for="dateCreate">
		<g:message code="book.dateCreate.label" default="Date Create" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dateCreate" precision="day"  value="${bookInstance?.dateCreate}"  />
</div>

