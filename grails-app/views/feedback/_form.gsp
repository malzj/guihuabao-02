<%@ page import="com.guihuabao.Feedback" %>



<div class="fieldcontain ${hasErrors(bean: feedbackInstance, field: 'content', 'error')} ">
	<label for="content">
		<g:message code="feedback.content.label" default="Content" />
		
	</label>
	<g:textField name="content" value="${feedbackInstance?.content}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: feedbackInstance, field: 'username', 'error')} ">
	<label for="username">
		<g:message code="feedback.username.label" default="Username" />
		
	</label>
	<g:textField name="username" value="${feedbackInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: feedbackInstance, field: 'userId', 'error')} ">
	<label for="userId">
		<g:message code="feedback.userId.label" default="User Id" />
		
	</label>
	<g:textField name="userId" value="${feedbackInstance?.userId}"/>
</div>

