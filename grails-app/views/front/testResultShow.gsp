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
    <ul class="steps clearfix">
        <li class="stp active">
            <span>第一步</span>
            <p>现状评估</p>
        </li>
        <li class="arrow"></li>
        <li class="stp">
            <span>第二步</span>
            <p>规模目标</p>
        </li>
        <li class="arrow"></li>
        <li class="stp">
            <span>第三步</span>
            <p>财务目标</p>
        </li>
        <li class="arrow"></li>
        <li class="stp">
            <span>第四步</span>
            <p>组织架构</p>
        </li>
        <li class="arrow"></li>
        <li class="stp">
            <span>第五步</span>
            <p>工作推进</p>
        </li>
    </ul>
<div class="test-question">
    <div class="score">
        <p>您的公司连锁规划评分为<span>${doneTest.totalScore}分</span></p>
        <div class="analysis">
            <g:if test="${doneTest.totalScore<50}">
                您当前各方面基础尚弱，连锁发展成功概率小于20%。
            </g:if>
            <g:elseif test="${doneTest.totalScore>=50&&doneTest.totalScore<65}">
                您当前连锁发展成功概率30%,需要集中精力在基础工作上扎实推进。
            </g:elseif>
            <g:elseif test="${doneTest.totalScore>=65&&doneTest.totalScore<80}">
                您具备一定的连锁发展基础，通过专业连锁模式规划和资源聚焦，可以实现超过50%的成功概率。
            </g:elseif>
            <g:elseif test="${doneTest.totalScore>=80&&doneTest.totalScore<90}">
                您各方面的基础较好，连锁发展成功概率超过60%,在模式和体系建设上仍急需完善。
            </g:elseif>
            <g:elseif test="${doneTest.totalScore>=90&&doneTest.totalScore<100}">
                您的连锁发展基础已经很优秀，补充些连锁体系建设能力，连锁发展成功概率超过70%。
            </g:elseif>
            ${doneTest.analysis}
        </div>
    </div>
    <div style="text-align: center;margin-top: 55px;">
        <g:link action="testAgain" id="${doneTest.id}" type="submit" class="btn btn-set">重做</g:link>
        <g:link action="programmeModule" type="submit" class="btn btn-info">返回</g:link>
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