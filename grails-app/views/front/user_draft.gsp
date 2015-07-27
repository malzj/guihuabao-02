<%--
  Created by IntelliJ IDEA.
  User: karl
  Date: 2015/7/23
  Time: 15:45
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
    #myfilter{border:none;width:100%;text-align:center;width:96px;border-bottom:#ff0000;}
    #filter {text-align:left;text-indent:20px; position:absolute;top:49px;left:-1px;border:1px solid #d2d2d2;border-top:none;width:160px;margin:0;background:#fff;z-index:2; display:none;padding-top:20px;}
    #filter li{height:40px;line-height:40px; list-style:none; cursor:pointer;}
    .icon{background:#03a9f4;color:#fff;width:20px;height:20px;display:inline-block;border-radius:50px;margin-right:10px;}
    #apply_tab{font-size:14px;padding:0;margin:20px 0 -1px 0;border:1px solid #d2d2d2;background:#fff;border-spacing:10px 0; border-collapse:collapse;}
    #apply_tab tr{border-bottom:1px solid #d2d2d2;display:block;}
    #apply_tab .th{background:#f8f8f8;}
    #apply_tab td{ padding:10px;margin:0;}
    #apply_tab tr td:nth-of-type(1){width:140px;}
    #apply_tab tr td:nth-of-type(2){width:800px;}
    #apply_tab tr td:nth-of-type(3){width:200px;}
    #apply_tab tr td:nth-of-type(4){width:140px;}
    #apply_tab tr td:nth-of-type(5){width:140px;}
    #apply_tab tr td:nth-of-type(6){width:200px;}
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
    </header>
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
                    <g:link class="dcjq-parent" action="apply">
                        <span>我的申请</span>
                        <em class="f-r">7</em>
                    </g:link>

                </li>
                <li class="sub-menu dcjq-parent-li">
                    <g:link class="dcjq-parent" action="user_approve">
                        <span>我的审批</span>
                        <em class="f-r">7</em>
                    </g:link>

                </li>
                <li class="sub-menu dcjq-parent-li">
                    <g:link class="dcjq-parent active" action="user_draft">
                        <span>草稿箱</span>
                        <em class="f-r">7</em>
                    </g:link>

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
                        <td width="106px">我的申请</td>
                        %{--<td style=" position:relative;width:96px;">--}%
                            %{--<div id="myfilter" href="#"><span id="filter-content">筛选</span><span style="margin-left:20px;"><i class="fa fa-sort-down"></i></span></div>--}%
                            %{--<ul id="filter">--}%
                                %{--<li>默认</li>--}%
                                %{--<li>已通过</li>--}%
                                %{--<li>未通过</li>--}%
                                %{--<li>待处理</li>--}%
                            %{--</ul>--}%
                        %{--</td>--}%
                        <td width="1442px"></td>

                    </tr>
                </table>
                <!--</div>-->
                <div class=" clearfix" id="text">
                    <table width="100%" id="apply_tab">
                        <tr>

                            <td>申请类型</td>
                            <td>申请内容</td>
                            <td>审批人</td>
                            <td>审批结果</td>
                            <td>申请时间</td>
                            <td>
                                操作
                            </td>
                        </tr>
                        <g:each in="${applylist}" status="i" var="applyInstance">
                            <tr>
                                <td>${applyInstance.type}</td>
                                <td>${applyInstance.content}</td>
                                <td>${applyInstance.approvalusername}</td>
                                <td>${applyInstance.status}</td>
                                <td>${applyInstance.dateCreate}</td>
                                <td>
                                    <a href="#" class="draft_pre"><img src="${resource(dir:'img',file:'pre.png')}" alt="pre" title="pre"/></a>
                                    <a href="#" class="draft_edit"><img src="${resource(dir:'img',file:'edit.png')}" alt="edit" title="edit"/></a>
                                    <a href="#" class="draft_delete"><img src="${resource(dir:'img',file:'delete.png')}" alt="delete" title="delete"/></a>
                                </td>
                            </tr>
                        </g:each>
                        %{--<tr>--}%
                            %{--<td>出差申请单</td>--}%
                            %{--<td>新项目调研，需出差五天！</td>--}%
                            %{--<td>营销部经理-法拉利</td>--}%
                            %{--<td>已通过</td>--}%
                            %{--<td>2015-7-15</td>--}%
                            %{--<td>--}%
                                %{--<a href="#" class="draft_pre"><img src="${resource(dir:'img',file:'pre.png')}" alt="pre" title="pre"/></a>--}%
                                %{--<a href="#" class="draft_edit"><img src="${resource(dir:'img',file:'edit.png')}" alt="edit" title="edit"/></a>--}%
                                %{--<a href="#" class="draft_delete"><img src="${resource(dir:'img',file:'delete.png')}" alt="delete" title="delete"/></a>--}%
                            %{--</td>--}%
                        %{--</tr>--}%


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

<!--草稿详情弹层 start-->
<div class="passwordedit" id="draftdetails">
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
        </div>

    </div>
</div>
<!--草稿详情弹层 end-->
<!--草稿编辑弹层 start-->
<div class="passwordedit" id="draftedit">
    <div class="m_box" style="width:804px;height:466px;">
        <header class="panel-heading">
            <span><i class="yh"></i>新建申请</span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>
        <form>
            <table>
                <tr>
                    <td align="right">申请类型</td>
                    <td width="300">
                        <select name="kind" class="select">
                            <option></option>
                            <option value="1">营销部经理-法拉利</option>
                            <option value="2">品牌部经理-艾瑞克</option>
                            <option value="3">财务部副经理-休斯顿</option>
                            <option value="4">董事长-詹姆斯</option>
                            <option value="5">市场部经理-休斯顿</option>
                        </select>
                    </td>

                </tr>
                <tr>
                    <td align="right">审批人</td>
                    <td><!--<input class="form-control form-control-inline input-medium default-date-picker" data-toggle="dropdown" name="newapply" />-->
                        <select name="shenpiren" class="select">
                            <option></option>
                            <option value="1">营销部经理-法拉利</option>
                            <option value="2">品牌部经理-艾瑞克</option>
                            <option value="3">财务部副经理-休斯顿</option>
                            <option value="4">董事长-詹姆斯</option>
                            <option value="2">市场部经理-休斯顿</option>
                        </select>

                    </td>
                </tr>
                <tr>
                    <td align="right">申请内容</td>
                    <td><textarea class=" form-control form-control-inline input-medium default-date-picker"  name="applycontent" cols="60" rows="8"></textarea></td>

                </tr>
                <tr>
                    <td></td>
                    <td>
                        <button type="button" class="btn btn-info">存草稿</button>
                        <button type="submit" class="btn btn-info">提交</button>
                    </td>
                    <td></td>
                </tr>
            </table>
        </form>
    </div>
</div>
<!--草稿编辑弹层 end-->
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

        $(".close").click(function(){
            $("#draftdetails").css("display","none");
            $("#draftedit").css("display","none");
        });
        $(".draft_pre").click(function(){
            $("#draftdetails").css("display","block");
        })
        $(".draft_edit").click(function(){
            $("#draftedit").css("display","block");
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