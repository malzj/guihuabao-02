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
                            %{--<g:while test="${i<12}">--}%
                                %{--<%i++%>--}%
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
                            %{--</g:while>--}%
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
                            <button id="view" class="rbtn btn-blue ml25">预览</button>
                        </div>
                    </div>

                        <div class="hang">
                            <h4 class="chx">本周工作成效</h4>
                            <textarea id="performance" name="performance">${myReportInfo?.performance}</textarea>
                        </div>
                        <div class="hang">
                            <h4 class="xd">总结心得</h4>
                            <textarea id="xinde" name="xinde">${myReportInfo?.xinde}</textarea>
                        </div>
                        <div class="hang">
                            <h4 class="jh">下周工作计划</h4>
                            <textarea id="plan" name="plan">${myReportInfo?.plan}</textarea>
                        </div>
                        <div class="hang">
                            <h4 class="hz">部门协同合作</h4>
                            <textarea id="cooperate" name="cooperate">${myReportInfo?.cooperate}</textarea>
                        </div>
                    <g:form url="[controller:'front',action:'reportUpdate']" method="post"  enctype= "multipart/form-data">
                        <g:hiddenField name="id" value="${myReportInfo?.id}" />
                        <g:hiddenField name="version" value="${myReportInfo?.version}" />
                        <g:hiddenField name="cid" value="${session.company.id}" />
                        <g:hiddenField name="bid" value="${session.user.bid}" />

                        <div class="hang">
                            <span class="f-l">附件：</span><div class="xuxian"><input type="file" name="file1" value="" /><span><a href="${resource(dir: 'uploadfile', file: ''+myReportInfo?.uploadFile+'')}">${myReportInfo?.uploadFile}</a></span></div>
                        </div>
                        <button disabled="disabled" class="f-r rbtn btn-blue mt25">提交</button>
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
            $(".zhoubao textarea").bind("blur",function(){
                var name=$(this).attr("name")
                var value=$(this).val()

                $.ajax({
                    url:'${webRequest.baseUrl}/front/reportSave?id=${myReportInfo?.id}&version=${myReportInfo?.version}&uid=${session.user.id}&username=${session.user.username}&cid=${session.company.id}&year=${year}&month=${month}&week=${week}&'+name+'='+encodeURI(value),
                    dataType: "jsonp",
                    jsonp: "callback",
                    success: function (data) {
                        // 去渲染界面
                        if(data.msg){
//                            alert("修改成功！");
                            window.location.reload();
                        }else{
                            alert("修改失败！");
                        }
                    }
                })
            });
            //报告预览
            $("#view").click(function(){
                var html
                $.ajax({
                    url:'${webRequest.baseUrl}/front/ylReport?id=${myReportInfo?.id}&cid=${myReportInfo?.cid}',
                    dataType: "jsonp",
                    jsonp: "callback",
                    success: function (data) {
                        // 去渲染界面
                        html='<div class="hang"><h4 class="chx">本周工作成效</h4><p>'+data.reportInfo.performance+'</p></div>';
                        html+='<div class="hang"><h4 class="xd">总结心得</h4><p>'+data.reportInfo.xinde+'</p></div>';
                        html+='<div class="hang"><h4 class="jh">下周工作计划</h4><p>'+data.reportInfo.plan+'</p></div>';
                        html+='<div class="hang"><h4 class="hz">部门协同合作</h4><p>'+data.reportInfo.cooperate+'</p></div>';
                        $(".popup_box .m_box .content").append(html);
                    }
                })
                $(".popup_box").css("display","block");
            });
            $(".close").click(function(){
                $(".popup_box").css("display","none");
                $(".popup_box .m_box .content").empty();
            });
            cansubmit();
            //判断是否能提交
            function cansubmit(){
                var performance=$('#performance').val();
                var xinde=$('#xinde').val();
                var plan=$('#plan').val();
                var cooperate=$('#cooperate').val();
                if(performance&&xinde&&plan&&cooperate){
                    $(".zhoubao .rbtn").removeAttr("disabled")
                }
            }
        })
    </script>

</body>
</html>