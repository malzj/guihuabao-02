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
                    <div class="book_list col-xs-3">
                        <h2><g:fieldValue bean="${bookInstance}" field="bookName"/></h2>
                        <div class="menu_side">
                            <ul class="menu">

                                <g:each status="i" in="${syllabusInstanceList}" var="syllabusInstance" >
                                    <li>
                                        <span>${syllabusInstance.syllabusName}</span>
                                        <ul class="weeks <g:if test="${syllabusInstance.id==syllabus.id}">on</g:if>">
                                            <g:each in="${com.guihuabao.Chapter.findAllBySyllabus(syllabusInstance,[sort:"id", order:"asc"])}" var="chapterInstance">
                                                <li <g:if test="${chapter.id==chapterInstance.id}">class="active"</g:if> ><g:link action="chapterBook" id="${chapterInstance.id}"><span>${chapterInstance.chapterName}</span></g:link></li>
                                            </g:each>
                                        </ul>
                                    </li>
                                </g:each>
                            </ul>
                        </div>
                    </div>

                    <div class="book_show col-xs-9 ">
                        <div class="top clearfix">
                            <div class="address f-l">
                                工具>列表>内容
                            </div>
                            <div class="pick_page f-r">
                                %{--<a class="single_page"><i></i>单页</a>--}%
                                %{--<a class="double_page"><i></i>双页</a>--}%

                                上一页/下一页
                            </div>
                        </div>
                        <div class="row" style="padding:0 15px;">
                            <div class="page b-k col-xs-12">${content}</div>

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