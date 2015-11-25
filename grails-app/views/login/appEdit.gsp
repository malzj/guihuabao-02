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
    <!--sidebar start-->
    <g:render template="sidebar" />
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper mt80">
            <div class="middle_content">
                <div class="m_box">

                    <header class="panel-heading">
                        编辑
                    </header>

                    <g:form class="form-horizontal tasi-form" url="[controller:'login',action:'appUpdate']" method="post"  enctype= "multipart/form-data">
                        <g:hiddenField name="id" value="${appsInstance?.id}"></g:hiddenField>
                        <g:hiddenField name="version" value="${appsInstance?.version}"></g:hiddenField>
                        <table>
                            <tr>
                                <td>名称：</td>
                                <td width="345"><input name="appName" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${appsInstance?.appName}"></td>
                            </tr>
                            <tr>
                                <td>应用链接：</td>
                                <td width="345"><input name="appurl" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${appsInstance?.appurl}"></td>
                            </tr>
                            <tr>
                                <td>应用分类：</td>
                                <td width="345">
                                    <select name="apptype">
                                        <option value="1" <g:if test="${appsInstance?.apptype=='1'}">selected="selected" </g:if>>基础应用</option>
                                        <option value="2" <g:if test="${appsInstance?.apptype=='2'}">selected="selected" </g:if>>更多应用</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>封面：</td>
                                <td>
                                    <input id="up_img" name="file" type="file" />
                                    <div id="imgdiv" class="zsimg"><img id="imgShow" src="${resource(dir: 'uploadfile/appimg', file: ''+appsInstance?.appImg+'')}" /></div>
                                    <span>上传封面：（232*196）</span>
                                </td>
                            </tr>
                            <tr>
                                <td>创建时间：</td>
                                <td><g:datePicker name="dateCreate" precision="day" value="${appsInstance?.dateCreate}" /> </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <button type="submit" class="btn btn-info">保存</button>
                                    <g:link action="appList" class="btn btn-info">返回</g:link>
                                </td>
                            </tr>
                        </table>
                    </g:form>
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
    <!--上传图片预览 js-->
    <script src="${resource(dir: 'js', file: 'uploadPreview.js')}"></script>
    <script type="text/javascript">
        window.onload = function () {
            new uploadPreview({ UpBtn: "up_img", DivShow: "imgdiv", ImgShow: "imgShow" });
        }
    </script>

</body>
</html>