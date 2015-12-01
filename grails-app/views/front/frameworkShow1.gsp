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
    <link href="${resource(dir: 'css', file: 'styleone.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'style-responsive.css')}" rel="stylesheet">

    <link href="${resource(dir: 'css', file: 'ownset.css')}" rel="stylesheet">
</head>

<body>

<section id="container" >
<!--header start-->
<g:render template="header" />
<!--header end-->
<!--main content start-->
<section id="main-content" style="margin-left: 0px;">
    <section class="wrapper" style="margin-top: 94px;">
        <div class="testPaper">
        <div class="test-question reset">
            <div class="test-title">企业组织架构</div>
                <div class="show-department">
                    <p><span>${session.company.companyname}组织架构。</span></p>
                    <figure class="org-chart cf">
                        <div class="board ">
                            <ul class="columnOne column">
                                <li>
                                    <span>
                                        股东大会
                                    </span>
                                </li>
                            </ul>
                            <ul class="columnTwo column">
                                <li>
                                    <span>
                                        战略委员会
                                    </span>
                                </li>
                                <li>
                                    <span>
                                        股东大会
                                    </span>
                                </li>
                            </ul>
                            <ul class="columnOne column">
                                <li>
                                    <span>
                                        董事会
                                    </span>
                                </li>
                            </ul>
                            <ul class="columnOne column" style="margin-top:32px;">
                                <li>
                                    <span>
                                        总经理
                                    </span>
                                </li>
                            </ul>
                        </div>
                        <ul id="departments" class="departments finally-solve">
                            <g:each in="${departmentList}" var="departmentInstance">
                                <li class="department" data-id="${departmentInstance?.id}" data-departmentid="${departmentInstance?.departmentId}">
                                    <span>
                                        <input name="name" value="${departmentInstance?.name}" class="edit-input" readonly="readonly">
                                    </span>
                                    <ul class="department-jobs">
                                        <g:each in="${departmentInstance.jobs}" var="jobInstance">
                                        <li>
                                            <span>
                                                <input name="name" value="${jobInstance}" class="edit-input" readonly="readonly">
                                            </span>
                                        </li>
                                        </g:each>
                                    </ul>
                                </li>
                            </g:each>
                        </ul>
                    </figure>
                </div>
                <div style="text-align: center;margin:90px 0 63px; ">
                    <g:link action="programmeModule" class="btn btn-info" style="width:118px;margin-left: 24px;">返回</g:link>
                </div>
                </div>
        </div>
    </section>
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

%{--<script>--}%

%{--//owl carousel--}%

%{--$(document).ready(function() {--}%
%{--$("#owl-demo").owlCarousel({--}%
%{--navigation : true,--}%
%{--slideSpeed : 300,--}%
%{--paginationSpeed : 400,--}%
%{--singleItem : true,--}%
%{--autoPlay:true--}%

%{--});--}%
%{--});--}%

%{--//custom select box--}%

%{--$(function(){--}%
%{--$('select.styled').customSelect();--}%
%{--});--}%

%{--</script>--}%
</body>
</html>