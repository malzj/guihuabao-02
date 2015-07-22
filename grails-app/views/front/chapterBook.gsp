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
    <!--header end-->
    <!--sidebar start-->
    <g:render template="siderbar" />
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <div class="hxzs_content clearfix">
                <div class="book_list">
                    <h2><g:fieldValue bean="${bookInstance}" field="bookName"/></h2>
                    <dl>
                        <g:each in="${syllabusInstanceList}" status="i" var="syllabusInstance">
                        <dt>${syllabusInstance.syllabusName}</dt>
                            <g:each in="${com.guihuabao.Chapter.findAllBySyllabus(syllabusInstance,[sort:"id", order:"asc"])}" status="a" var="chapterInstance">
                            <g:link action="chapterBook" id="${chapterInstance.id}"><dd><span>${chapterInstance.chapterName}</span></dd></g:link>
                            </g:each>
                        </g:each>
                    </dl>
                </div>

                <div class="book_show">
                    <div class="top clearfix">
                        <div class="address f-l">
                            和许助手>${syllabusname}>${chaptername}
                        </div>
                        <div class="pick_page f-r">
                            %{--<a class="single_page"><i></i>单页</a>--}%
                            %{--<a class="double_page"><i></i>双页</a>--}%

                            <g:if test="${offset.toInteger() != 0}"><g:link action="chapterBook" id="${bookId}"  params="[offset:offset.toInteger()-2]"  class="pre_page ml25" >上一页</g:link> </g:if>
                            <g:if test="${offset.toInteger() < contentsize.toInteger()/2+1}"> <g:link action="chapterBook" id="${bookId}" params="[offset:offset.toInteger()+2]" class="next_page">下一页</g:link></g:if>
                        </div>
                    </div>
                    <div class="page b-k">${content}</div>
                    <div class="page b-k ml20">${content1}</div>
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

</body>
</html>