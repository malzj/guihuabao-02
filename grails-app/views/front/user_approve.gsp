<%--
  Created by IntelliJ IDEA.
  User: karl
  Date: 2015/7/23
  Time: 15:39
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
    #myfilter{border:none;text-align:center;width:96px;border-bottom:#ff0000;}
    #filter {text-align:left;text-indent:20px; position:absolute;top:49px;left:-1px;border:1px solid #d2d2d2;border-top:none;width:160px;margin:0;background:#fff;z-index:2; display:none;}
    #filter li{height:40px;line-height:40px; list-style:none; cursor:pointer;}
    .icon{background:#03a9f4;color:#fff;width:20px;height:20px;display:inline-block;border-radius:50px;margin-right:10px;}
    #apply_tab{font-size:14px;padding:0;margin:0;border:1px solid #d2d2d2;margin-bottom:-1px;margin-top:20px;background:#fff;}
    #apply_tab tr{border-bottom:1px solid #d2d2d2;display:block;}
    #apply_tab .th{background:#f8f8f8;}
    #apply_tab td{padding:10px;margin:0;}
    #apply_tab td:nth-of-type(1){width:140px;}
    #apply_tab td:nth-of-type(2){width:1000px;}
    #apply_tab td:nth-of-type(3){width:200px;}
    #apply_tab td:nth-of-type(4){width:140px;}
    #apply_tab td:nth-of-type(5){width:140px;}
    .select{width:300px;height:35px;border:1px solid #d0d0d0;}
    textarea{border:1px solid #d0d0d0;width:500px;height:400px;resize:none;}
    .panel-content{margin:15px;}
    .panel-content li{margin:15px 0;}
    #pass,#nopass{width:80px; height:32px;border-radius:3px;border:none;color:#fff;}
    #pass{background:#03a9f4;}
    #nopass{background:#ff0000;}
    </style>
</head>
<body>

<section id="container" >
    <!--header start-->
    <g:render template="header" />
    <!--header end-->
    <!--sidebar start-->
    <g:render template="spaside"/>
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">

            <div class="info_content">
                <!--<div class="info_title">-->
                <table id="apply_top" width="100%" height="50px">
                    <tr>
                        <td width="106px">我的审批</td>
                        <td style=" position:relative;width:96px;">
                            <div id="myfilter" href="#"><span id="filter-content">筛选</span><span style="margin-left:20px;"><i class="fa fa-sort-down"></i></span></div>
                            <ul id="filter">
                                <li><g:link action="user_approve">默认</g:link></li>
                                <li><g:link action="user_approve" params="[selected: 1]">已通过</g:link></li>
                                <li><g:link action="user_approve" params="[selected: 2]">未通过</g:link></li>
                                <li><g:link action="user_approve" params="[selected: 0]">未审核</g:link></li>
                            </ul>
                        </td>
                        <td width="1442px"></td>

                    </tr>
                </table>
                <!--</div>-->
                <div  id="text">
                    <table width="100%" id="apply_tab">
                        <tr class="th">
                            <td >申请类型</td>
                            <td>申请内容</td>
                            <td>审批人</td>
                            <td>审批结果</td>
                            <td>申请时间</td>
                        </tr>
                        <g:each in="${applylist}" status="i" var="applyInstance">
                            <tr data-id="${applyInstance.id}" data-version="${applyInstance.version}">
                                <td>${applyInstance.type}申请单</td>
                                <td>${applyInstance.content}</td>
                                <td>${applyInstance.approvalusername}</td>
                                <td>${applyInstance.status}</td>
                                <td>${applyInstance.dateCreate.format("yyyy-MM-dd")}</td>
                            </tr>
                        </g:each>
                        <g:hiddenField name="applyId" id="applyId" ></g:hiddenField>
                        <g:hiddenField name="version" id="version" ></g:hiddenField>
                    </table>
                </div>
            </div>
        </section>
    </section>
    <!--main content end-->

</section>

<!--审批详情弹层 start-->
<div class="passwordedit" id="applydetails">
    <div class="m_box" style="width:804px;">
        <header class="panel-heading">
            <span><i class="yh"></i>申请详情</span>
            <div class="close"><a class="fa fa-times"></a></div>
        </header>
        <div class="panel-content">
            <ul>
                <li>申请类型：<span></span></li>
                <li>审批人：<span></span></li>
                <li>申请内容：<span></span></li>
                <li>申请时间：<span></span></li>
                <li>申请结果：<span></span></li>
            </ul>
            <input type="button" value="通过" id="pass" class="ispass" data-status="1" />
            <input type="button" value="未通过" id="nopass" class="ispass" data-status="2"/>
        </div>

    </div>
</div>
<!--审批详情弹层 end-->
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
            var applyDate = $(this).children("td:eq(4)").html();
            $("#applyId").val(applyId)
            $("#version").val(version)
            $(".panel-content ul li:eq(0) span").html(applyType)
            $(".panel-content ul li:eq(1) span").html(approvalusername)
            $(".panel-content ul li:eq(2) span").html(applyContent)
            $(".panel-content ul li:eq(3) span").html(applyStauts)
            $(".panel-content ul li:eq(4) span").html(applyDate)
            $("#applydetails").css("display","block");
        })
        $(".close").click(function(){
            $("#applydetails").css("display","none");
        });
        $(".ispass").click(function(){
            var applyStauts = $(this).attr("data-status");
            var id = $("#applyId").val();
            var version = $("#version").val();
            $.ajax({
                url:'${webRequest.baseUrl}/front/approveStatus?applystatus='+applyStauts+'&id='+id+'&version='+version,
                dataType: "jsonp",
                jsonp: "callback",
                success: function (data) {
                    // 去渲染界面
                    if(data.msg){
                        $("#applydetails").hide();
                        alert("审核完成！");
                        window.location.reload();
                    }else{
                        $("#applydetails").hide();
                        alert("审核失败！");
                        window.location.reload();
                    }
                }
            })
        })
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