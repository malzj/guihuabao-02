<%--
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
            <section class="wrapper wrapper_reset">
                <div class="hxzs_content clearfix row">

                    <div class="book_show col-xs-12 ">
                        <div class="top clearfix">
                            <div class="address f-l">
                                案例>列表>内容
                            </div>
                            <div class="pick_page f-r">
                                %{--<a class="single_page"><i></i>单页</a>--}%
                                %{--<a class="double_page"><i></i>双页</a>--}%
                                <g:if test="${contentsize.toInteger() != 0&&contentsize.toInteger() != 1}">
                                <g:if test="${offset.toInteger() != 0}"><g:link action="example" id="${toolId}"  params="[offset:offset.toInteger()-1]"  class="pre_page ml25" >上一页</g:link> </g:if>
                                <g:if test="${offset.toInteger() < contentsize.toInteger()/2}"> <g:link action="example" id="${toolId}" params="[offset:offset.toInteger()+1]" class="next_page">下一页</g:link></g:if>
                                </g:if>
                            </div>
                        </div>
                        <div class="row" style="padding:0 15px;position:relative">
                            <div style="position: absolute;top:0;left: 0;z-index:10000;width:100%;height:100%;;"></div>
                            <div class="page b-k col-xs-12">${content}</div>

                        </div>
                    </div>
                </div>
            </section>
            <!--main content end-->

        </section>
    </div>
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

        $(function(){
            $(".menu>li>span").click(function(){
                $(this).next(".weeks").toggle();
            })
        })




    </script>
</body>
</html>