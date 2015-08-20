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
        <g:render template="hx_siderbar" />
        <!--sidebar end-->
        <!--main content start-->
        <section id="main-content" class="col-xs-10" style="padding-left: 0;">
            <section class="wrapper">
                <div class="hxzs_heading clearfix">
                    <h2>工具</h2>
                </div>
                <div class="mt25">
                    <g:each in="${bookInstanceList}" status="i" var="bookInstance">
                        <div class="zs_style">
                            <g:link controller="front" action="book" id="${bookInstance.id}">
                                <img src="${resource(dir: 'images', file: ''+bookInstance.bookImg+'')}" height="195" width="235" />
                            </g:link>
                            <span>${bookInstance.bookName}</span>
                        </div>
                    </g:each>
                </div>
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