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
    <g:render template="siderbar" />
<!--sidebar end-->
<!--main content start-->
<section id="main-content" class="col-xs-10" style="padding-left: 0;">
<section class="wrapper">
    <div class="wrapper_title">
        <span class="f-l"><i class="yh"></i>用户列表</span>
        <form class="f-r">
            <input type="text" name="search" />
            <input type="submit" value="" />
        </form>
        <g:link controller="front" action="companyUserCreate" class="f-r"><i class="fa fa-plus-circle"></i>新建用户</g:link>
    </div>
    <div class="content">
        <table class="table table-striped table-advance table-hover">
            <tr class="even">
                <th>#编号</th>
                <th>姓名</th>
                <th>电话</th>
                <th>公司</th>
                <th>部门</th>
                <th>角色</th>
                <th>操作</th>
            </tr>
            <g:each in="${companyUserInstanceList}" status="i" var="companyUserInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td>${fieldValue(bean: companyUserInstance, field: "id")}</td>

                    <td><g:link controller="front" action="companyUserShow" id="${companyUserInstance?.id}">${companyUserInstance.name}</g:link></td>

                    <td>${companyUserInstance.phone}</td>
                    <td>${com.guihuabao.Company.findById(companyUserInstance.cid).companyname}</td>
                    <td>${com.guihuabao.Bumen.findById(companyUserInstance.bid)?.name}</td>
                    <td>${com.guihuabao.Persona.findById(companyUserInstance.pid)?.name}</td>
                    <td>
                        <g:link action="companyUserShow" id="${companyUserInstance?.id}" class="btn btn-success btn-xs"><i class="fa fa-eye"></i></g:link>
                        <g:link action="companyUserEdit" id="${companyUserInstance?.id}" class="btn btn-primary btn-xs"><i class="fa fa-pencil"></i></g:link>
                        <g:link action="companyUserDelete" id="${companyUserInstance?.id}" class="btn btn-danger btn-xs" onclick="return confirm('确定删除？');"><i class="fa fa-trash-o "></i></g:link>
                    </td>


                </tr>
            </g:each>
        </table>
        <div class="pagination">
            <g:paginate total="${companyUserInstanceTotal}" />
        </div>
    </div>
</section>
<!--main content end-->

<!--footer start-->
%{--<footer class="site-footer">--}%
%{--<div class="text-center">--}%
%{--2013 &copy; FlatLab by VectorLab.--}%
%{--<a href="index.html#" class="go-top">--}%
%{--<i class="fa fa-angle-up"></i>--}%
%{--</a>--}%
%{--</div>--}%
%{--</footer>--}%
<!--footer end-->
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