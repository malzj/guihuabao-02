<%@ page import="com.guihuabao.CompanyUser" %>



<div class="fieldcontain ${hasErrors(bean: companyUserInstance, field: 'username', 'error')} ">
    <label for="username">
        <g:message code="companyUser.username.label" default="Username"/>

    </label>
    <g:textField name="username" value="${companyUserInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyUserInstance, field: 'password', 'error')} ">
    <label for="password">
        <g:message code="companyUser.password.label" default="Password"/>

    </label>
    <g:textField name="password" value="${companyUserInstance?.password}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyUserInstance, field: 'cid', 'error')} ">
    <label for="cid">
        <g:message code="companyUser.cid.label" default="Cid"/>

    </label>
    <g:textField name="cid" value="${companyUserInstance?.cid}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyUserInstance, field: 'rid', 'error')} ">
    <label for="rid">
        <g:message code="companyUser.rid.label" default="Rid"/>

    </label>
    <g:textField name="rid" value="${companyUserInstance?.rid}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyUserInstance, field: 'name', 'error')} ">
    <label for="name">
        <g:message code="companyUser.name.label" default="Name"/>

    </label>
    <g:textField name="name" value="${companyUserInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyUserInstance, field: 'img', 'error')} ">
    <label for="img">
        <g:message code="companyUser.img.label" default="Img"/>

    </label>
    <g:textField name="img" value="${companyUserInstance?.img}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyUserInstance, field: 'sex', 'error')} ">
    <label for="sex">
        <g:message code="companyUser.sex.label" default="Sex"/>

    </label>
    <g:textField name="sex" value="${companyUserInstance?.sex}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyUserInstance, field: 'phone', 'error')} ">
    <label for="phone">
        <g:message code="companyUser.phone.label" default="Phone"/>

    </label>
    <g:textField name="phone" value="${companyUserInstance?.phone}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyUserInstance, field: 'bid', 'error')} ">
    <label for="bid">
        <g:message code="companyUser.bid.label" default="Bid"/>

    </label>
    <g:textField name="bid" value="${companyUserInstance?.bid}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: companyUserInstance, field: 'dateCreat', 'error')} ">
    <label for="dateCreat">
        <g:message code="companyUser.dateCreat.label" default="Date Creat"/>

    </label>
    <g:datePicker name="dateCreat" precision="day" value="${companyUserInstance?.dateCreat}" default="none"
                  noSelection="['': '']"/>
</div>

