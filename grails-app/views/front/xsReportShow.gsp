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
    <div class="row">
    <g:render template="zhoubao_siderbar" />
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content "class="col-xs-10" style="padding-left:0;">
        <section class="wrapper">
            <div class="hxzs_content clearfix row">
                <div class="book_list col-xs-3">
                    <h2>
                        <select id="year" name="year">
                            <option value="2014" <g:if test="${year==2014}">selected="selected"</g:if>>2014</option>
                            <option value="2015" <g:if test="${year==2015}">selected="selected"</g:if>>2015</option>
                        </select>
                    </h2>
                    <div class="menu_side">
                        <ul class="menu">
                            <g:each status="k" in="${month1}" var="s" >
                                <li>
                                    <span>${s}月</span>
                                    <ul class="weeks <g:if test="${s==month1[month]}">on</g:if>">
                                        <g:each in="${week1}" var="i">
                                            <li <g:if test="${i==week&&s==month1[month]}">class="active"</g:if> ><a href="javascript:;" data-month="${k}" data-week="${i}"><span>第${i}周</span></a></li>
                                        </g:each>
                                    </ul>
                                </li>
                            </g:each>
                        </ul>
                    </div>
                </div>
                <div class="zhoubao col-xs-9">
                    <div class="top clearfix">
                        <div class="address f-l">
                            ${reportInfo?.username}第${week}周的工作报告
                        </div>
                        <div class="pick_page f-r">
                            <a class="this_week">上一周</a>
                            <a class="this_week">本周</a>
                            <a class="this_week">下一周</a>
                            <button id="view" class="rbtn btn-blue ml25">预览</button>
                        </div>
                    </div>
                    <div class="hang">
                        <h4 class="chx">本周工作成效</h4>
                        <p>${myReportInfo?.performance}</p>
                    </div>
                    <div class="hang">
                        <h4 class="xd">总结心得</h4>
                        <p>${myReportInfo?.xinde}</p>
                    </div>
                    <div class="hang">
                        <h4 class="jh">下周工作计划</h4>
                        <p>${myReportInfo?.plan}</p>
                    </div>
                    <div class="hang">
                        <h4 class="hz">部门协同合作</h4>
                        <p>${myReportInfo?.cooperate}</p>
                    </div>
                    <div class="discuss clearfix">
                        <h4>反馈及评论</h4>
                        <g:form url="[controller:'front',action:'replySave']">
                            <g:hiddenField name="id" value="${myReportInfo?.id}"></g:hiddenField>
                            <g:hiddenField name="bpuid" value="${myReportInfo?.uid}"></g:hiddenField>
                            <g:hiddenField name="bpuname" value="${myReportInfo?.username}"></g:hiddenField>
                            <g:hiddenField name="cid" value="${cid}"></g:hiddenField>
                            <g:hiddenField name="uid" value="${uid}"></g:hiddenField>
                            <g:hiddenField name="year" value="${year}"></g:hiddenField>
                            <g:hiddenField name="month" value="${month}"></g:hiddenField>
                            <g:hiddenField name="week" value="${week}"></g:hiddenField>
                            <g:hiddenField name="puid" value="${session.user.id}"></g:hiddenField>
                            <g:hiddenField name="puname" value="${session.user.username}"></g:hiddenField>
                        <div>
                            <textarea name="content"></textarea>
                        </div>
                        <button type="submit" class="rbtn btn-blue f-r mt25">提交</button>
                        </g:form>
                    </div>
                    <div id="reply_container">
                        <g:each in="${myReportInfo?.replyReport}" var="replyInfo">
                        <div class="reply_box">
                            <div class="name">${replyInfo.puname}&nbsp;回复&nbsp;<g:if test="${replyInfo.bpuid==session.user.id}">我</g:if><g:else>${replyInfo.bpuname}</g:else></div>
                            <p>${replyInfo.content}</p>
                            <span>${replyInfo.date}</span><a href="javascript:;" class="reply">回复</a>
                            <div class="shuru">
                                <span>回复&nbsp;${replyInfo.puname}</span>
                                <g:form url="[controller:'front',action:'replySave']">
                                    <g:hiddenField name="id" value="${myReportInfo?.id}"></g:hiddenField>
                                    <g:hiddenField name="bpuid" value="${replyInfo.bpuid}"></g:hiddenField>
                                    <g:hiddenField name="bpuname" value="${replyInfo.bpuname}"></g:hiddenField>
                                    <g:hiddenField name="cid" value="${cid}"></g:hiddenField>
                                    <g:hiddenField name="uid" value="${uid}"></g:hiddenField>
                                    <g:hiddenField name="year" value="${year}"></g:hiddenField>
                                    <g:hiddenField name="month" value="${month}"></g:hiddenField>
                                    <g:hiddenField name="week" value="${week}"></g:hiddenField>
                                    <g:hiddenField name="puid" value="${session.user.id}"></g:hiddenField>
                                    <g:hiddenField name="puname" value="${session.user.username}"></g:hiddenField>
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
            $(".menu>li>span").click(function(){
                $(this).next(".weeks").toggle();
            })
            $(".weeks>li>a").click(function(){
                $(".weeks li").removeAttr("class");
                $(this).parent().attr("class","active");
                var n_year = $("#year").val();
                var n_month = $(this).attr("data-month");
                var n_week = $(this).attr("data-week");
                window.location.href = '${webRequest.baseUrl}/front/xsReportShow?uid=${uid}&cid=${cid}&year='+n_year+'&month='+n_month+'&week='+n_week;
            })
            $(".zhoubao .reply_box .reply").click(function(){
                $(this).next(".shuru").toggle();
            })
        })
    </script>
</body>
</html>