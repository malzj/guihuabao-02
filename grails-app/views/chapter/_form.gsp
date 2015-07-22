<%@ page import="com.guihuabao.Chapter" %>



<div class="fieldcontain ${hasErrors(bean: chapterInstance, field: 'chapterName', 'error')} ">
	<label for="chapterName">
		<g:message code="chapter.chapterName.label" default="Chapter Name" />
		
	</label>
	<g:textField name="chapterName" value="${chapterInstance?.chapterName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chapterInstance, field: 'remark', 'error')} ">
	<label for="remark">
		<g:message code="chapter.remark.label" default="Remark" />
		
	</label>
	<g:textField name="remark" value="${chapterInstance?.remark}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: chapterInstance, field: 'contents', 'error')} ">
	<label for="contents">
		<g:message code="chapter.contents.label" default="Contents" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${chapterInstance?.contents?}" var="c">
    <li><g:link controller="content" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="content" action="create" params="['chapter.id': chapterInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'content.label', default: 'Content')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: chapterInstance, field: 'dateCreate', 'error')} required">
	<label for="dateCreate">
		<g:message code="chapter.dateCreate.label" default="Date Create" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dateCreate" precision="day"  value="${chapterInstance?.dateCreate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: chapterInstance, field: 'syllabus', 'error')} required">
	<label for="syllabus">
		<g:message code="chapter.syllabus.label" default="Syllabus" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="syllabus" name="syllabus.id" from="${com.guihuabao.Syllabus.list()}" optionKey="id" required="" value="${chapterInstance?.syllabus?.id}" class="many-to-one"/>
</div>

