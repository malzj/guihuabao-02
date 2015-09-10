<%--
  Created by IntelliJ IDEA.
  User: karl
  Date: 2015/7/22
  Time: 14:22
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
    <style>
    .info_content{border:none;padding:0;}
    #text{padding:0;background:none;}
    #apply_top{width:100%; height:50px;text-align:center;background:#fff;border:1px solid #d2d2d2;margin-right:-1px;}
    #apply_top td{border-right:1px solid #d2d2d2;border-bottom:1px solid #d2d2d2;}


    .icon{background:#03a9f4;color:#fff;width:20px;height:20px;display:inline-block;border-radius:50px;margin-right:10px;}
    #apply_tab{font-size:14px;padding:0;margin:20px 0 -1px 0;border:1px solid #d2d2d2;background:#fff;}
    #apply_tab tr{border-bottom:1px solid #d2d2d2;display:block;}
    #apply_tab .th{background:#f8f8f8;}
    #apply_tab td{padding:10px;margin:0;}
    #apply_tab tr td:nth-of-type(1){width:140px;}
    #apply_tab tr td:nth-of-type(2){width:600px;}
    #apply_tab tr td:nth-of-type(3){width:200px;}
    #apply_tab tr td:nth-of-type(4){width:140px;}
    #apply_tab tr td:nth-of-type(5){width:400px;}
    #apply_tab tr td:nth-of-type(6){width:140px;}
    .select{width:300px;height:35px;border:1px solid #d0d0d0;}
    textarea{border:1px solid #d0d0d0;width:500px;height:400px;resize:none;}
    .panel-content{margin:15px;}
    .panel-content li{margin:15px 0;}

    </style>
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
        <g:render template="spaside"/>
        <!--sidebar end-->
        <!--main content start-->
        <section id="main-content" class="col-xs-10" style="padding-left: 0;">
            <section class="wrapper">

                <div class="info_content">
                    <!--<div class="info_title">-->
                    <table id="apply_top" width="100%" height="50px">
                        <tr>
                            <td width="106px">我的申请</td>
                            <td style=" position:relative;width:96px;">
                                <div id="myfilter" ><span id="filter-content">筛选</span><span style="margin-left:20px;"><i class="fa fa-sort-down"></i></span></div>
                                <ul id="filter">
                                    <li><g:link action="copyToMe">默认</g:link></li>
                                    <li><g:link action="copyToMe" params="[selected: 1]">未查看</g:link></li>
                                    <li><g:link action="copyToMe" params="[selected: 0]">已查看</g:link></li>
                                </ul>
                            </td>
                            <td width="1308px"></td>
                        </tr>
                    </table>
                    <!--</div>-->
                    <div class=" clearfix" id="text">
                        <table width="100%" id="apply_tab">
                            <tr class="th">
                                <td >申请类型</td>
                                <td>申请内容</td>
                                <td>审批人</td>
                                <td>审批结果</td>
                                <td>审批反馈</td>
                                <td>申请时间</td>
                            </tr>
                            <g:each in="${applylist}" status="i" var="applyInstance">
                                <tr data-id="${applyInstance.id}" data-version="${applyInstance.version}">
                                    <td>${applyInstance.type}</td>
                                    <td>${applyInstance.content}</td>
                                    <td>${applyInstance.approvalusername}</td>
                                    <td>${applyInstance.status}</td>
                                    <td>${applyInstance.approvetext}</td>
                                    <td>${applyInstance.dateCreate.format("yyyy-MM-dd")}</td>
                                </tr>
                            </g:each>
                        </table>
                        <div class="pagination">
                            <g:paginate total="${applyInstanceTotal}" />
                        </div>
                    </div>
                </div>
            </section>
        </section>
        <!--main content end-->

</section>
<!--申请详情弹层 start-->
<div class="passwordedit addscroll" id="applydetails">
    <div class="m_box" style="width:804px;">
        <header class="panel-heading">
            <span><i class="yh"></i>申请详情</span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>
        <div class="panel-content">
            <ul>
                <li>申请类型：<span></span></li>
                <li>审批人：<span></span></li>
                <li>申请内容：<span></span></li>
                <li>申请时间：<span></span></li>
                <li>申请结果：<span></span></li>
                <li>审核反馈：<span></span></li>
            </ul>
        </div>

    </div>
</div>
<!--申请详情弹层 end-->
<!-- js placed at the end of the document so the pages load faster -->
<script src="${resource(dir:'js',file:'jquery.js')}"></script>
<script src="${resource(dir:'js',file:'bootstrap.min.js')}"></script>
<script class="include" type="text/javascript" src="${resource(dir:'js',file:'jquery.dcjqaccordion.2.7.js')}"></script>
<script src="${resource(dir:'js',file:'jquery.scrollTo.min.js')}"></script>
<script src="${resource(dir:'js',file:'jquery.nicescroll.js')}"></script>
<script src="${resource(dir:'js',file:'jquery.sparkline.js')}"></script>
<script src="${resource(dir:'assets/jquery-easy-pie-chart',file:'jquery.easy-pie-chart.js')}"></script>
<script src="${resource(dir:'js',file:'owl.carousel.js')}" ></script>
<script src="${resource(dir:'js',file:'jquery.customSelect.min.js')}" ></script>
<script src="${resource(dir:'js',file:'respond.min.js')}" ></script>

<!--right slidebar-->
<script src="${resource(dir:'js',file:'slidebars.min.js')}"></script>

<!--common script for all pages-->
<script src="${resource(dir:'js',file:'common-scripts.js')}"></script>

<!--script for this page-->
<script src="${resource(dir:'js',file:'sparkline-chart.js')}"></script>
<script src="${resource(dir:'js',file:'easy-pie-chart.js')}"></script>
<script src="${resource(dir:'js',file:'count.js')}"></script>

<!--弹出框 js-->
<script type="text/javascript">
    $(document).ready(function(){

        $("#apply_tab tr").click(function(){
            var applyId = $(this).attr("data-id");
            var version = $(this).attr("data-version");
            var applyType = $(this).children("td:eq(0)").html();
            var applyContent = $(this).children("td:eq(1)").html();
            var approvalusername = $(this).children("td:eq(2)").html();
            var applyStauts = $(this).children("td:eq(3)").html();
            var approvetext = $(this).children("td:eq(4)").html();
            var applyDate = $(this).children("td:eq(5)").html();
            $(".panel-content ul li:eq(0) span").html(applyType)
            $(".panel-content ul li:eq(1) span").html(approvalusername)
            $(".panel-content ul li:eq(2) span").html(applyContent)
            $(".panel-content ul li:eq(3) span").html(applyDate)
            $(".panel-content ul li:eq(4) span").html(applyStauts)
            $(".panel-content ul li:eq(5) span").html(approvetext)
            $.ajax({
                url:'${webRequest.baseUrl}/front/copyRemindUpdate?id='+encodeURI(applyId)+'&version='+encodeURI(version),
                dataType: "jsonp",
                jsonp: "callback",
                success: function (data) {
//                    // 去渲染界面
//                    if(data.msg){
//                        alert("保存成功！")
//                    }else{
//                        alert("保存失败！");
//                    }
                }
            })
            $("#applydetails").css("display","block");
        })
        $(".close").click(function(){
            $("#applydetails").css("display","none");
        });
        $("#myfilter").click(function(){
            $("#myfilter").parent().css("border-bottom","1px solid #fff");
            $("#filter").css("display","block");
            $("#filter").click(function(ev){
                var ev=ev||window.event();
                var target=ev.srcElement||ev.target;
                $("#filter-content").html(target.innerHTML);
                $("#filter").css("display","none");
                $("#myfilter").parent().css("border-bottom","1px solid #d2d2d2");
            })
        })

    })
</script>
</body>
</html>