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
    <g:render template="siderbar" />
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <div class="wrapper_title">
                <span class="f-l"><i class="yh"></i>公告列表</span>
                <form class="f-r">
                    <input type="text" name="search" />
                    <input type="submit" value="" />
                </form>
                <g:link controller="front" action="companyNoticeCreate" class="f-r"><i class="fa fa-plus-circle"></i>新建公告</g:link>
            </div>
            <div class="content">
                <table class="table table-striped table-advance table-hover">
                    <tr class="even">
                        <th width="10%">#编号</th>
                        <th width="80%">标题</th>
                        <th>操作</th>
                    </tr>
                    <g:each in="${companyNoticeInstanceList}" status="i" var="companyNoticeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td>${companyNoticeInstance.id}</td>

                            <td><g:link controller="front" action="companyNoticeShow" id="${companyNoticeInstance?.id}">${companyNoticeInstance.title}</g:link></td>
                            <td>
                                <g:link action="companyNoticeShow" id="${companyNoticeInstance?.id}" class="btn btn-success btn-xs"><i class="fa fa-eye"></i></g:link>
                                <g:link action="companyNoticeEdit" id="${companyNoticeInstance?.id}" class="btn btn-primary btn-xs"><i class="fa fa-pencil"></i></g:link>
                                <g:link action="companyNoticeDelete" id="${companyNoticeInstance?.id}" class="btn btn-danger btn-xs" onclick="return confirm('确定删除？');"><i class="fa fa-trash-o "></i></g:link>
                            </td>


                        </tr>
                    </g:each>
                </table>
                <div class="pagination">
                    <g:paginate total="${companyNoticeInstanceTotal}" />
                </div>
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

    <script>

    //owl carousel

    $(document).ready(function() {
    $("#owl-demo").owlCarousel({
    navigation : true,
    slideSpeed : 300,
    paginationSpeed : 400,
    singleItem : true,
    autoPlay:true

    });
    });

    //custom select box

    $(function(){
    $('select.styled').customSelect();
    });

    </script>

</body>
</html>