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
        <section class="wrapper">
            <div class="hxzs_content clearfix">
                <div class="book_list">
                    <h2>
                        <select id="year" name="year">
                            <option value="2014" <g:if test="${year==2014}">selected="selected"</g:if>>2014</option>
                            <option value="2015" <g:if test="${year==2015}">selected="selected"</g:if>>2015</option>
                        </select>
                    </h2>
                    <div class="menu_side">
                        <ul class="menu">

                            <g:each status="k" in="${dateInfo}" var="weeks" >
                                <li>
                                    <span>${month1[k]}月</span>
                                    <ul class="weeks <g:if test="${(k+1)==month}">on</g:if>">
                                        <g:each in="${weeks}" var="i">
                                            <li <g:if test="${i==week&&(k+1)==month}">class="active"</g:if> ><a href="javascript:;" data-month="${k+1}" data-week="${i}"><span>第${i}周</span></a></li>
                                        </g:each>
                                    </ul>
                                </li>
                            </g:each>
                        %{--<li>--}%
                        %{--<span>2月</span>--}%
                        %{--<ul class="weeks">--}%
                        %{--<li><span>第1周</span></li>--}%
                        %{--<li><span>第2周</span></li>--}%
                        %{--<li><span>第3周</span></li>--}%
                        %{--<li><span>第4周</span></li>--}%
                        %{--</ul>--}%
                        %{--</li>--}%
                        </ul>
                    </div>
                </div>
                <div class="zhoubao">
                    <div class="top clearfix">
                        <div class="address f-l">
                            ${session.user.username}第${week}周的工作报告
                        </div>
                        <div class="pick_page f-r">
                            <g:link action="myReport" class="this_week">本周</g:link>
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
                        <div class="hang">
                            <span class="f-l">附件：</span><a href="${resource(dir: 'uploadfile', file: ''+myReportInfo?.uploadFile+'')}">${myReportInfo?.uploadFile}</a>
                        </div>
                        <g:form url="[controller:'front',action:'reportUpdate']" method="post"  enctype= "multipart/form-data">
                            <g:hiddenField name="id" value="${myReportInfo?.id}" />
                            <g:hiddenField name="version" value="${myReportInfo?.version}" />
                            <g:hiddenField name="cid" value="${session.company.id}" />
                            <button class="f-r rbtn btn-blue mt25">提交</button>
                        </g:form>

                </div>
            </div>
        </section>
        <!--main content end-->

    </section>
    <!--弹出层-->
    <div class="popup_box">
        <div class="m_box">
            <header class="panel-heading">
                <span>工作报告</span>
                <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
            </header>
            <div class="content">
            </div>
        </div>
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
                window.location.href = '${webRequest.baseUrl}/front/reportShow?year='+n_year+'&month='+n_month+'&week='+n_week;
            })
        })
    </script>

</body>
</html>