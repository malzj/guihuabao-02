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
                            公司
                    </header>

                    <table>
                        <tr>
                            <td>企业名称：</td>
                            <td width="345"><g:fieldValue bean="${companyInstance}" field="companyname"/></td>
                        </tr>
                        <tr>
                            <td>企业简称：</td>
                            <td><g:fieldValue bean="${companyInstance}" field="companyAbbrev"/></td>
                        </tr>
                        <tr>
                            <td>企业联系人：</td>
                            <td><g:fieldValue bean="${companyInstance}" field="contactName"/></td>
                        </tr>
                        <tr>
                            <td>职务：</td>
                            <td><g:fieldValue bean="${companyInstance}" field="job"/></td>
                        </tr>
                        <tr>
                            <td>公司电话：</td>
                            <td><g:fieldValue bean="${companyInstance}" field="phone"/></td>
                        </tr>
                        <tr>
                            <td>移动电话：</td>
                            <td><g:fieldValue bean="${companyInstance}" field="telephone"/></td>
                        </tr>
                        <tr>
                            <td>电子邮件：</td>
                            <td><g:fieldValue bean="${companyInstance}" field="email"/></td>
                        </tr>
                        <tr>
                            <td>传真：</td>
                            <td><g:fieldValue bean="${companyInstance}" field="fax"/></td>
                        </tr>
                        <tr>
                            <td>企业类型：</td>
                            <td><g:fieldValue bean="${companyInstance}" field="companyType"/></td>
                        </tr>
                        <tr>
                            <td>企业成立时间：</td>
                            <td><g:fieldValue bean="${companyInstance}" field="regtime"/></td>
                        </tr>
                        <tr>
                            <td>通信地址：</td>
                            <td><g:fieldValue bean="${companyInstance}" field="address"/></td>
                        </tr>
                        <tr>
                            <td>邮政编码：</td>
                            <td><g:fieldValue bean="${companyInstance}" field="postalcode"/></td>
                        </tr>
                        <tr>
                            <td>网址：</td>
                            <td><g:fieldValue bean="${companyInstance}" field="website"/></td>
                        </tr>
                        <tr>
                            <td>备注：</td>
                            <td><g:fieldValue bean="${companyInstance}" field="remark"/></td>
                        </tr>
                        <tr>
                            <td>使用时间：</td>
                            <td><g:fieldValue bean="${companyInstance}" field="dateUse"/></td>
                        </tr>
                        <tr>
                            <td>
                                创建时间：
                            </td>
                            <td>
                                <g:fieldValue bean="${companyInstance}" field="dateCreat"/>
                            </td>
                        </tr>
                        <tr>
                            <td>公司logo：</td>
                            <td><img alt="" src="${resource(dir: 'images', file: ''+companyInstance.logoimg+'')}" width="340" alt="" /></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td align="right">
                                <g:form>
                                    <g:hiddenField name="id" value="${companyInstance?.id}" />
                                    <g:link controller="login" action="companyEdit" id="${companyInstance?.id}" class="btn btn-info">修改</g:link>
                                    <g:actionSubmit type="submit" class="btn btn-info" action="companyDelete"  value="删除" onclick="return confirm('确定删除?');" />
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