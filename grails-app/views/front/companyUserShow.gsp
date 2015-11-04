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
            <div class="middle_content">
                <div class="m_box">
                    <header class="panel-heading">
                        <span><i class="yh"></i>用户信息</span>
                    </header>
                    <table>
                        <tr>
                            <td>姓名：</td>
                            <td width="345">${fieldValue(bean: companyUserInstance, field: "name")}</td>
                        </tr>
                        <tr>
                            <td>用户名：</td>
                            <td>${fieldValue(bean: companyUserInstance, field: "username")}</td>
                        </tr>
                        <tr>
                            <td>密码：</td>
                            <td>${fieldValue(bean: companyUserInstance, field: "password")}</td>
                        </tr>
                        <tr>
                            <td>手机号：</td>
                            <td>${fieldValue(bean: companyUserInstance, field: "phone")}</td>
                        </tr>
                        <%
                            def bumen=com.guihuabao.Bumen.findByCidAndId(session.company.id,companyUserInstance.bid)
                        %>
                        <tr>
                            <td>部门：</td>
                            <td>${(bumen)?bumen.name:"无"}</td>
                        </tr>
                        <tr>
                            <td>
                                角色：
                            </td>
                            <td>${com.guihuabao.Persona.findById(companyUserInstance.pid)?.name}</td>
                        </tr>
                        <tr>
                            <td>
                                职位：
                            </td>
                            <td>${companyUserInstance?.position}</td>
                        </tr>
                        <tr>
                            <td>
                                时间：
                            </td>
                            <td>${fieldValue(bean: companyUserInstance, field: "dateCreat")}</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td align="right">
                                <g:form>
                                    <g:hiddenField name="id" value="${companyUserInstance?.id}" />
                                    <g:link controller="front" action="companyUserEdit" id="${companyUserInstance?.id}" class="btn btn-info">修改</g:link>
                                    <g:actionSubmit type="submit" class="btn btn-info" action="companyUserDelete"  value="删除" onclick="return confirm('确定删除?');" />
                                    <a href="javascript:history.go(-1);" class="ml15 btn btn-info">取消</a>
                                </g:form>
                            </td>
                        </tr>
                    </table>
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