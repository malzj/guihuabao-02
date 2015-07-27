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
    <g:render template="zhoubao_siderbar" />
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper wrapper_reset">
            <div class="hxzs_content clearfix">
                <div class="book_list">
                    <ul class="zblist">
                        <g:each in="${zhoubaoInstance}" var="zhoubaoInfo">
                            <li>
                                <g:link action="replyReport" params="[year: zhoubaoInfo.year,month: zhoubaoInfo.month,week: zhoubaoInfo.week]">
                                    <img src="" height="35" width="35" />
                                    <div class="text">
                                        <h4>第${zhoubaoInfo.week}周工作报告</h4>
                                        <span>${zhoubaoInfo.dateCreate}</span>
                                    </div>
                                </g:link>
                            </li>
                        </g:each>
                    </ul>
                </div>
                <div class="zhoubao">
                    <div class="top clearfix">
                        <div class="address f-l">
                            oscar第1周的工作报告
                        </div>
                    </div>
                    <div class="discuss clearfix">
                        <h4>反馈及评论</h4>
                    </div>
                    <div id="reply_container">
                        <g:each in="${zhoubaoReportInfo?.replyReports}" var="replyInfo">
                            <div class="reply_box">
                                <div class="name"><g:if test="${replyInfo.puid==session.user.id}">我</g:if><g:else>${replyInfo.puname}</g:else>&nbsp;回复&nbsp;<g:if test="${replyInfo.bpuid==session.user.id}">我</g:if><g:else>${replyInfo.bpuname}</g:else></div>
                                <p>${replyInfo.content}</p>
                                <span>${replyInfo.date}</span><g:if test="${replyInfo.puid==session.user.id}"><a href="javascript:;" class="reply">回复</a></g:if>
                                <div class="shuru">
                                    <span>回复&nbsp;${replyInfo.puname}</span>
                                    <g:form url="[controller:'front',action:'myReplySave']">
                                        <g:hiddenField name="id" value="${zhoubaoReportInfo?.id}"></g:hiddenField>
                                        <g:hiddenField name="bpuid" value="${replyInfo.puid}"></g:hiddenField>
                                        <g:hiddenField name="bpuname" value="${replyInfo.puname}"></g:hiddenField>
                                        <g:hiddenField name="cid" value="${zhoubaoReportInfo?.cid}"></g:hiddenField>
                                        <g:hiddenField name="puid" value="${session.user.id}"></g:hiddenField>
                                        <g:hiddenField name="puname" value="${session.user.username}"></g:hiddenField>
                                        <g:hiddenField name="year" value="${zhoubaoReportInfo?.year}"></g:hiddenField>
                                        <g:hiddenField name="month" value="${zhoubaoReportInfo?.month}"></g:hiddenField>
                                        <g:hiddenField name="week" value="${zhoubaoReportInfo?.week}"></g:hiddenField>
                                        <div class="mt10">
                                            <textarea name="content"></textarea>
                                        </div>
                                        <button class="fbtn btn-white mt10">回复</button>
                                        <button class="fbtn btn-white mt10 ml20">取消</button>
                                    </g:form>
                                </div>
                            </div>
                        </g:each>
                    </div>
                </div>
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
    <!--月份列表js-->
    <script type="text/javascript">
        $(function(){
            $(window).bind('resize load', function(){

                $(".wrapper_reset").css("zoom",$(window).width()/1920);
                $(".wrapper_reset").find().css("zoom",$(window).width()/1920);
                $(".wrapper_reset").find().css("-moz-transform","scale("+$(window).width()/1920+")");
                $(".wrapper_reset").find().css("-moz-transform-origin","top left");


            });
            $(".menu>li>span").click(function(){
                $(this).next(".weeks").toggle();
            })
            $(".weeks>li>span").click(function(){
                $(".weeks li").removeAttr("class")
                $(this).parent().attr("class","active")
            })
            $(".zhoubao .reply_box .reply").click(function(){
                $(this).next(".shuru").toggle();
            })

        })
    </script>
</body>
</html>