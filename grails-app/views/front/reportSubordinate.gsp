<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 15-6-16
  Time: 下午3:59
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>规划宝后台管理系统</title>

    <!-- Bootstrap core CSS -->
    <link href="${resource(dir: 'css', file: 'bootstrap.min.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'bootstrap-reset.css')}" rel="stylesheet">
    <!--external css-->
    <link href="${resource(dir: 'assets/font-awesome/css', file: 'font-awesome.css')}" rel="stylesheet">
    <link href="${resource(dir: 'assets/jquery-easy-pie-chart', file: 'jquery.easy-pie-chart.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'owl.carousel.css')}" rel="stylesheet">

    <!--right slidebar-->
    <link href="${resource(dir: 'css', file: 'slidebars.css')}" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="${resource(dir: 'css', file: 'style.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'style-responsive.css')}" rel="stylesheet">

    <link href="${resource(dir: 'css', file: 'ownset.css')}" rel="stylesheet">
</head>

<body>

<section id="container" >
    <!--header start-->
    <g:render template="header" />
    <div style="height:110px;"></div>
    <!--header end-->
    <!--sidebar start-->
    <div class="row">
        <div class="col-xs-2" style="height:100%"></div>
        <g:render template="zhoubao_siderbar" />
        <!--sidebar end-->
        <!--main content start-->
        <section id="main-content" class="col-xs-10">
            <section class="wrapper">
                <div class="xstask">
                    <g:if test="${unfirst}">
                        <span><a href="javascript:history.go(-1);"><i class="fa fa-chevron-left" style="margin-right: 10px;"></i>返回上一级</a></span>
                    </g:if>
                    <g:else><span>下属任务</span></g:else>
                </div>
                <g:if test="${bumenList&&session.user.pid!=3}">
                    <div class="index-group mb0">
                        <div class="index-head">
                            <span class="title"><i class="fa fa-caret-down" style="margin-right: 10px;"></i>下属部门</span>
                        </div>
                        <ul class="xsreport clearfix">
                            <g:each in="${bumenList}" var="info">
                                <li><g:link action="reportSubordinate" params="[bid: info.id,cid: info.cid]"><span>${info.name}</span></g:link></li>
                            </g:each>
                        </ul>
                    </div>
                </g:if>
                <g:if test="${companyUserList}">
                    <div class="index-group" style="margin-top: -1px;">
                        <div class="index-head">
                            <span class="title"><i class="fa fa-caret-down" style="margin-right: 10px;"></i>下属成员</span>
                        </div>
                        <ul class="xsreport clearfix">
                            <g:each in="${companyUserList}" var="info">
                                <li><g:link action="xsReportShow" params="[uid: info.id,cid: info.cid]"><span>${info.name}</span></g:link></li>
                            </g:each>
                        </ul>
                    </div>
                </g:if>
            </section>
            <!--main content end-->

        </section>
        <!-- js placed at the end of the document so the pages load faster -->
        <script src="${resource(dir: 'js', file: 'jquery.js')}"></script>
        <script src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
        <script class="include" type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dcjqaccordion.2.7.js')}"></script>
        <script src="${resource(dir: 'js', file: 'jquery.scrollTo.min.js')}"></script>
        <script src="${resource(dir: 'js', file: 'jquery.nicescroll.js')}" type="text/javascript"></script>
        <script src="${resource(dir: 'js', file: 'jquery.sparkline.js')}" type="text/javascript"></script>
        <script src="${resource(dir: 'assets/jquery-easy-pie-chart/', file: 'jquery.easy-pie-chart.js')}"></script>
        <script src="${resource(dir: 'js', file: 'owl.carousel.js')}" ></script>
        <script src="${resource(dir: 'js', file: 'jquery.customSelect.min.js')}" ></script>
        <script src="${resource(dir: 'js', file: 'respond.min.js')}" ></script>

        <!--right slidebar-->
        <script src="${resource(dir: 'js', file: 'slidebars.min.js')}"></script>

        <!--common script for all pages-->
        <script src="${resource(dir: 'js', file: 'common-scripts.js')}"></script>

        <!--script for this page-->
        <script src="${resource(dir: 'js', file: 'sparkline-chart.js')}"></script>
        <script src="${resource(dir: 'js', file: 'easy-pie-chart.js')}"></script>
        <script src="${resource(dir: 'js', file: 'count.js')}"></script>

</body>
</html>