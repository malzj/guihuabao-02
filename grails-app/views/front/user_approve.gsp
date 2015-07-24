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
    #apply_top{width:100% height:50px;text-align:center;background:#fff;border:1px solid #d2d2d2;margin-right:-1px;}
    #apply_top td{border-right:1px solid #d2d2d2;border-bottom:1px solid #d2d2d2;}
    datalist{width:200px;}
    #myfilter{border:none;width:100%;text-align:center;}
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
    <aside>
        <div id="sidebar"  class="nav-collapse ">
            <div class="sidebar_object">
                <i class="fa fa-edit"></i>
                审批
            </div>
            <!-- sidebar menu start-->
            <ul class="sidebar-menu" id="nav-accordion">
                <li class="sub-menu dcjq-parent-li">
                    <a class="dcjq-parent " href="apply">
                        <span>我的申请</span>
                        <em class="f-r">7</em>
                    </a>

                </li>
                <li class="sub-menu dcjq-parent-li">
                    <a class="dcjq-parent active" href="#">
                        <span>我的审批</span>
                        <em class="f-r">7</em>
                    </a>

                </li>
                <li class="sub-menu dcjq-parent-li">
                    <a class="dcjq-parent" href="user_draft">
                        <span>草稿箱</span>
                        <em class="f-r">7</em>
                    </a>

                </li>
            </ul>
            <!-- sidebar menu end-->
        </div>
    </aside>
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">

            <div class="info_content">
                <!--<div class="info_title">-->
                <table id="apply_top" width="100%" height="50px">
                    <tr>
                        <td width="10%">我的审批</td>
                        <td width="10%">
                            <input id="myfilter" list="filter" value="筛选">
                            <datalist id="filter">
                                <option value="默认">默认</option><dd></dd>
                                <option value="已通过"></option>
                                <option value="未通过"></option>
                                <option value="待处理"></option>
                            </datalist>
                        </td>
                        <td width="80"></td>

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
                        <tr>
                            <td>出差申请单</td>
                            <td>新项目调研，需出差五天！</td>
                            <td>营销部经理-法拉利</td>
                            <td>已通过</td>
                            <td>2015-7-15</td>
                        </tr>
                        <tr>
                            <td>出差申请单</td>
                            <td>新项目调研，需出差五天！</td>
                            <td>营销部经理-法拉利</td>
                            <td>已通过</td>
                            <td>2015-7-15</td>
                        </tr>
                        <tr>
                            <td>出差申请单</td>
                            <td>新项目调研，需出差五天！</td>
                            <td>营销部经理-法拉利</td>
                            <td>已通过</td>
                            <td>2015-7-15</td>
                        </tr>
                        <tr>
                            <td>出差申请单</td>
                            <td>新项目调研，需出差五天！</td>
                            <td>营销部经理-法拉利</td>
                            <td>已通过</td>
                            <td>2015-7-15</td>
                        </tr>

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
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>
        <div class="panel-content">
            <ul>
                <li>申请类型：<span>出差申请单</span></li>
                <li>审批人：<span>营销部经理-法拉利</span></li>
                <li>申请内容：<span>新项目调研，需出差五天！</span></li>
                <li>申请时间：<span>2015-7-15</span></li>
                <li>申请结果：<span>已通过</span></li>
            </ul>
            <input type="button" value="通过" id="pass"/>
            <input type="button" value="未通过" id="nopass"/>
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
            $("#applydetails").css("display","block");
        })
        $(".close").click(function(){
            $("#applydetails").css("display","none");
        });

    })
</script>
</body>
</html>