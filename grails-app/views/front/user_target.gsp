<%--
  Created by IntelliJ IDEA.
  User: karl
  Date: 2015/7/28
  Time: 10:13
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

    <link rel="stylesheet" type="text/css" href="${resource(dir: 'assets/bootstrap-datepicker/css', file: 'datepicker.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'assets/bootstrap-datetimepicker/css', file: 'datetimepicker.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'assets/bootstrap-daterangepicker', file: 'daterangepicker-bs3.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'assets/bootstrap-timepicker/compiled', file: 'timepicker.css')}" />
    <style>
        body{-webkit-text-size-adjust:none;}
        .btime,.etime{width:87px;height:25px;display:block;border:1px solid #d2d2d2;text-align:center;line-height:25px;}
        .btime{margin-right: 12px;}
        .tar_whole{border:1px solid #d2d2d2;width:250px;height:210px;margin:0 15px 15px 0;cursor:pointer;}
        .tar_title{padding:14px;border-bottom: 1px solid #d2d2d2}
        .tar_content{margin:20px 0;font-size:20px;line-height:56px;}
        .percent{clear: both;width:56px;height:56px;margin-left:10px;text-align:center;line-height:56px;border:3px solid #d2d2d2;border-radius: 50px;}
        .passwordedit input[type='text']{width:100%;height:38px;border:1px solid #d2d2d2;text-indent: 10px;}
        .passwordedit input[type='button']{width:82px;height:34px;border:none;background:#03a9f4;color:#fff;}
    </style>
</head>

<body>

<section id="container" >
    <!--header start-->
    <g:render template="header" />
    <!--header end-->
    <!--sidebar start-->
    <g:render template="spaside" />
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <div class="col-tb">
                <div class="col-cell">
                    <div class="toolkit">
                        <span>我的目标</span>
                        <div class="shaixuan">
                            <a class="task-order">排序<i class="fa fa-caret-down"></i></a>
                            <ul>

                                <li>
                                    <g:link action="user_target" params="[selected: 1]">按目标到期时间</g:link>
                                </li>
                                <li>
                                    <g:link action="user_target" params="[selected: 2]">按目标创建时间</g:link>

                                </li>

                            </ul>
                        </div>
                        <a href="#" id="newapply" class="f-r"><i class="fa fa-plus-circle"></i>新建目标</a>
                    </div>
                    <div class="content">
                        <div style="margin-top:20px;" class="clearfix">



                            <g:each in="${targetInstanceList}" var="targetInstance">

                            <div class="tar_whole f-l">
                                <div class="tar_title clearfix" >
                                    <img class="f-l" src="${resource(dir:'img/target-img',file:'1.png')}" title="tar_img1"/>
                                    <div class="f-l" style="margin-left:10px;">

                                        <h2 style="font-size:20px;margin:4px;color:#40bdf5;">${targetInstance.title}</h2>
                                        负责人：<span>${com.guihuabao.CompanyUser.findByIdAndCid(targetInstance.fzuid,session.company.id).username}</span>
                                    </div>
                                    <div style="font-size:20px;" class="f-r">
                                        <a href="#" style="margin-left: 10px;color:#40bdf5"><i class="fa fa-edit" id="tar_edit"></i></a>
                                        <a href="#" style="color:#40bdf5"><i class="fa fa-trash-o"></i></a>
                                    </div>
                                </div>

                                <div class="tar_content clearfix">
                                    <div class="f-l percent">0%</div>
                                    <div class="f-l"style="margin-left: 10px;">共<span>1</span>位同事参与</div>
                                </div>
                                <div class="clearfix" style="width:188px;margin:0 auto;">
                                    <span class="btime f-l">${targetInstance.btime}</span><span class="etime f-l">${targetInstance.etime}</span>
                                </div>

                            </div>
                            </g:each>

                            <div class="tar_whole f-l">
                                <div class="tar_title clearfix" >
                                    <img class="f-l" src="${resource(dir:'img/target-img',file:'1.png')}" title="tar_img1"/>
                                    <div class="f-l" style="margin-left:10px;">
                                        <h2 style="font-size:20px;margin:4px;color:#40bdf5;">目标名称</h2>
                                        负责人：<span>艾瑞特</span>
                                    </div>
                                    <div style="font-size:20px;" class="f-r">

                                        <a href="#" style="margin-left: 10px;color:#40bdf5"><i class="fa fa-edit" id="tar_edit"></i></a>
                                        <a href="#" style="color:#40bdf5"><i class="fa fa-trash-o" id="tar_delete"></i></a>
                                    </div>
                                </div>

                                <div class="tar_content clearfix">
                                    <div class="f-l percent">0%</div>
                                    <div class="f-l"style="margin-left: 10px;">共<span>1</span>位同事参与</div>
                                </div>
                                <div class="clearfix" style="width:188px;margin:0 auto;">
                                    <span class="btime f-l">2015-04-25</span><span class="etime f-l">2015-04-30</span>
                                </div>

                            </div>

                            <div class="tar_whole f-l">
                                <div class="tar_title clearfix" >
                                    <img class="f-l" src="${resource(dir:'img/target-img',file:'1.png')}" title="tar_img1"/>
                                    <div class="f-l" style="margin-left:10px;">
                                        <h2 style="font-size:20px;margin:4px;color:#40bdf5;">目标名称</h2>
                                        负责人：<span>艾瑞特</span>
                                    </div>
                                    <div style="font-size:20px;" class="f-r">

                                        <a href="#" style="margin-left: 10px;color:#40bdf5"><i class="fa fa-edit" id="tar_edit"></i></a>
                                        <a href="#" style="color:#40bdf5"><i class="fa fa-trash-o"></i></a>
                                    </div>
                                </div>

                                <div class="tar_content clearfix">
                                    <div class="f-l percent">0%</div>
                                    <div class="f-l"style="margin-left: 10px;">共<span>1</span>位同事参与</div>
                                </div>
                                <div class="clearfix" style="width:188px;margin:0 auto;">
                                    <span class="btime f-l">2015-04-25</span><span class="etime f-l">2015-04-30</span>
                                </div>

                            </div>

                            <div class="tar_whole f-l">
                                <div class="tar_title clearfix" >
                                    <img class="f-l" src="${resource(dir:'img/target-img',file:'1.png')}" title="tar_img1"/>
                                    <div class="f-l" style="margin-left:10px;">
                                        <h2 style="font-size:20px;margin:4px;color:#40bdf5;">目标名称</h2>
                                        负责人：<span>艾瑞特</span>
                                    </div>
                                    <div style="font-size:20px;" class="f-r">

                                        <a href="#" style="margin-left: 10px;color:#40bdf5"><i class="fa fa-edit" id="tar_edit"></i></a>
                                        <a href="#" style="color:#40bdf5"><i class="fa fa-trash-o"></i></a>
                                    </div>
                                </div>

                                <div class="tar_content clearfix">
                                    <div class="f-l percent">0%</div>
                                    <div class="f-l"style="margin-left: 10px;">共<span>1</span>位同事参与</div>
                                </div>
                                <div class="clearfix" style="width:188px;margin:0 auto;">
                                    <span class="btime f-l">2015-04-25</span><span class="etime f-l">2015-04-30</span>
                                </div>

                            </div>

                            <div class="tar_whole f-l">
                                <div class="tar_title clearfix" >
                                    <img class="f-l" src="${resource(dir:'img/target-img',file:'1.png')}" title="tar_img1"/>
                                    <div class="f-l" style="margin-left:10px;">
                                        <h2 style="font-size:20px;margin:4px;color:#40bdf5;">目标名称</h2>
                                        负责人：<span>艾瑞特</span>
                                    </div>
                                    <div style="font-size:20px;" class="f-r">

                                        <a href="#" style="margin-left: 10px;color:#40bdf5"><i class="fa fa-edit" id="tar_edit"></i></a>
                                        <a href="#" style="color:#40bdf5"><i class="fa fa-trash-o"></i></a>
                                    </div>
                                </div>

                                <div class="tar_content clearfix">
                                    <div class="f-l percent">0%</div>
                                    <div class="f-l"style="margin-left: 10px;">共<span>1</span>位同事参与</div>
                                </div>
                                <div class="clearfix" style="width:188px;margin:0 auto;">
                                    <span class="btime f-l">2015-04-25</span><span class="etime f-l">2015-04-30</span>
                                </div>

                            </div>



                        </div>



                    </div>


                </div>
            </div>

        </section>
        <!--main content end-->

        <!--footer start-->
        %{--<footer class="site-footer">--}%
        %{--<div class="text-center">--}%
        %{--2013 &copy; FlatLab by VectorLab.--}%
        %{--<a href="index.html#" class="go-top">--}%
        %{--<i class="fa fa-angle-up"></i>--}%
        %{--</a>--}%
        %{--</div>--}%
        %{--</footer>--}%
        <!--footer end-->
    </section>
<!--新建弹层 start-->
<div class="passwordedit" id="newapplydetail">
    <div class="m_box" style="width:804px;">
        <header class="panel-heading" style="padding:10px 28px;">
            <span><i class="yh"></i>添加新目标</span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>
        <g:form url="[controller:'front',action:'targetSave']">
        <ul>
            <li class="clearfix">
                <div align="right" class="f-l" style="margin-right: 10px;"><img src="${resource(dir:'img/target-img',file:'1.png')}"></div>
                <div class="f-l">
                    <input type="text" name="title" placeholder="添加目标名称" style="margin-top: 5px;width:690px;"/>
                </div>

            </li>
            <li>
                <textarea name="content" rows="4" placeholder="这里可以添加目标详情" style="width:100%;height:68px;resize: none;"></textarea>
            </li>
            <li>
                <table width="100%" class="table table-bordered" style="border-spacing: 0;">
                    <tr>
                        <th style="text-align: center;width:15%;background:#f8f8f8">负责人</th>
                        <td width="85%"><input  name="fzuid" style="border:none;width:100%"/></td>

                    </tr>
                    <tr>
                        <th style="text-align:center;width:15%;background:#f8f8f8" >起止日</th>
                        <td>
                            %{--<input type="text" name="btime" style="width:88px;height:28px;"/>—<input type="text" name="etime" style="width:88px;height:28px;"/>--}%
                            <input id="startdate" name="bigentime" value="" readonly="" class="default-date-picker" type="text" style="width:100px;">-<input id="enddate" name="overtime" value="" readonly="" class="form_datetime" type="text" style="width:133px;">
                        </td>

                    </tr>
                </table>
            </li>
            <li class="clearfix">
                <div class="f-r">
                    <input type="button"  value="保存" style="margin-right: 10px;"/>
                    <input type="button"  value="保存并分解目标" style="width:160px;"/>
                </div>
            </li>
        </ul>
        </g:form>
    </div>
</div>
<!--新建弹层 end-->
<!--目标分解 start-->
<div class="passwordedit" id="tar_fj">
    <div class="m_box" style="width:804px;">
        <header class="panel-heading" style="padding:10px 28px;">
            <span><i class="yh"></i>目标分解</span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>

        <ul>

            <li class="clearfix">
                <h2 style="padding:0;margin: 0 20px 0 0;font-size: 20px;color:#03a9f4" class="f-l">任务一：<span style="color:#797979;">企业数据报告分析</span></h2>
                <div class="f-l" style="font-size: 20px;">
                    <a href="#" style="font-size:20px;"><i class="fa fa-edit"></i></a>
                    <a href="#" style="font-size:20px;"><i class="fa fa-trash-o"></i></a>
                </div>
            </li>
            <li class="clearfix">
                <table class="table table-bordered f-l" style="border-spacing: 0;margin-right: 20px;width:48%">
                    <tr>
                        <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">负责人</th>
                        <td width="75%"><input  name="fzuid" style="border:none;width:100%"/></td>

                    </tr>
                    <tr>
                        <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务权重</th>
                        <td>
                            <input  name="fzuid" style="border:none;width:75%"/>
                        </td>
                    </tr>
                </table>
                <table class="table table-bordered f-l" style="border-spacing: 0;width:48%;">
                    <tr>
                        <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;">起止日</th>
                        <td width="75%"><span>2015-06-09</span>—<span>2015-06-09</span></td>

                    </tr>
                    <tr>
                        <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>
                        <td>
                            <span>进行中</span>
                        </td>
                    </tr>
                </table>
            </li>
            <li>
                <h2  id="newmission" style="padding:0;margin: 0 20px 0 0;font-size: 20px;" ><i class="fa fa-plus-circle" style="margin-right: 10px;"></i>新建任务<span>(剩余任务权重<span id="percent-mission">40</span>%)</span></h2>
            </li>
            <li class="clearfix">
                <input type="submit" value="提交" class="f-r"  disabled/>
            </li>
        </ul>
    </div>
</div>
<!--目标分解 end-->

<!--选择图片 start-->
<div class="passwordedit" id="select_img">
    <div class="m_box" style="width:804px;">
        <header class="panel-heading" style="padding:10px 28px;">
            <span>选择图片</span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>

        <ul>

            <li class="clearfix">
                <h2 style="padding:0;margin: 0 20px 0 0;font-size: 20px;" class="f-l">任务一：<span>企业数据报告分析</span></h2>
                <div class="f-l" style="font-size: 20px;">
                    <a href="#" style="font-size:20px;"><i class="fa fa-edit"></i></a>
                    <a href="#" style="font-size:20px;"><i class="fa fa-trash-o"></i></a>
                </div>
            </li>
            <li class="clearfix">
                <table class="table table-bordered f-l" style="border-spacing: 0;margin-right: 20px;width:48%">
                    <tr>
                        <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">负责人</th>
                        <td width="75%"><input  name="fzuid" style="border:none;width:100%"/></td>

                    </tr>
                    <tr>
                        <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务权重</th>
                        <td>
                            <input  name="fzuid" style="border:none;width:75%"/>
                        </td>
                    </tr>
                </table>
                <table class="table table-bordered f-l" style="border-spacing: 0;width:48%;">
                    <tr>
                        <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;">起止日</th>
                        <td width="75%"><span>2015-06-09</span>—<span>2015-06-09</span></td>

                    </tr>
                    <tr>
                        <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>
                        <td>
                            <span>进行中</span>
                        </td>
                    </tr>
                </table>
            </li>
            <li>
                <h2  id="newmission" style="padding:0;margin: 0 20px 0 0;font-size: 20px;" ><i class="fa fa-plus-circle" style="margin-right: 10px;"></i>新建任务<span>(剩余任务权重<span id="percent-mission">40</span>%)</span></h2>
            </li>
            <li class="clearfix">
                <input type="button" value="提交" class="f-r"  disabled/>
            </li>
        </ul>
    </div>
</div>
<!--选择图片 end-->

<!--新建任务 start-->
<div class="passwordedit" id="newmissiondetail">
    <div class="m_box" style="width:804px;">
        <header class="panel-heading" style="padding:10px 28px;">
            <span><i class="yh"></i>新建任务</span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>

        <ul>

            <li >
                <input type="text" name="title" placeholder="一句话描述任务"/>
            </li>
            <li>
                <input type="text" name="content" placeholder="添加任务详情"/>
            </li>
            <li>
                <table class="table table-bordered" style="border-spacing: 0;margin-right: 20px;">
                    <tr>
                        <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">执行人</th>
                        <td width="75%"><a href="#" style="color:#03a9f4;line-height:40px;"><i class="fa fa-plus-square-o" ></i></a></td>

                    </tr>
                    <tr>
                        <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;line-height: 30px;">起止日</th>
                        <td width="75%"> <input id="startdate" name="bigentime" value="" readonly="" class="default-date-picker" type="text" style="width:100px;">-<input id="enddate" name="overtime" value="" readonly="" class="form_datetime" type="text" style="width:133px;"></td>

                    </tr>
                    <tr>
                        <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">任务权重</th>
                        <td width="75%"><input  name="fzuid" style="border:none;width:100%"/></td>

                    </tr>
                    <tr>
                        <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>
                        <td>
                            <span>进行中</span>
                        </td>
                    </tr>
                </table>
            </li>

            <li class="clearfix">
                <input type="button" value="确认" class="f-r" style="width:82px;height:34px;border:none;background:#03a9f4;color:#fff;"/>
            </li>
        </ul>
    </div>
</div>
<!--新建任务 end-->

<!--目标详情 start-->
<div class="passwordedit" id="tar_detail" style="position:absolute;overflow: scroll;">
    <div class="m_box" style="width:804px;overflow: scroll;">
        <header class="panel-heading" style="padding:10px 28px;">
            <span>目标详情<i class="fa fa-print" style="margin:0 10px;color:#03a9f4;"></i><i class="fa fa-file-text" style="color:#03a9f4;"></i></span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>

        <ul>

            <li class="clearfix">
                <div align="right" class="f-l" style="margin-right: 10px;"><img src="${resource(dir:'img/target-img',file:'1.png')}"></div>
                <h2 class="f-l" style="padding:0;margin: 0 20px 0 0;font-size: 20px;line-height:48px;">企业数据报告</h2>
            </li>
            <li>
                详情：需要人力资源部门配合，周末完成
            </li>
            <li>
                负责人：艾瑞克
            </li>
            <li>
                起止日：2015-04-06—2015-05-19
            </li>

            <h2 style="padding:10px 0;font-size: 20px;border-bottom: 1px solid #d2d2d2;">目标分解</h2>

            <ul style="padding:0;margin:0;">
                <li class="clearfix">
                    <h2 style="padding:0 20px 10px 0;margin: 0;font-size: 20px;color:#03a9f4">任务一：<span style="color:#797979;">企业数据报告分析</span></h2>

                    <table class="table table-bordered f-l" style="border-spacing: 0;margin-right: 20px;width:48%">
                        <tr>
                            <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">负责人</th>
                            <td width="75%"><span></span></td>

                        </tr>
                        <tr>
                            <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务权重</th>
                            <td>
                                <span></span>
                            </td>
                        </tr>
                    </table>
                    <table class="table table-bordered f-l" style="border-spacing: 0;width:48%;">
                        <tr>
                            <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;">起止日</th>
                            <td width="75%"><span>2015-06-09</span>—<span>2015-06-09</span></td>

                        </tr>
                        <tr>
                            <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>
                            <td>
                                <span>进行中</span>
                            </td>
                        </tr>
                    </table>
                </li>
                <li class="clearfix">
                    <h2 style="padding:0 20px 10px 0;margin: 0;font-size: 20px;color:#03a9f4">任务一：<span style="color:#797979;">企业数据报告分析</span></h2>

                    <table class="table table-bordered f-l" style="border-spacing: 0;margin-right: 20px;width:48%">
                        <tr>
                            <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">负责人</th>
                            <td width="75%"><span></span></td>

                        </tr>
                        <tr>
                            <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务权重</th>
                            <td>
                                <span></span>
                            </td>
                        </tr>
                    </table>
                    <table class="table table-bordered f-l" style="border-spacing: 0;width:48%;">
                        <tr>
                            <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;">起止日</th>
                            <td width="75%"><span>2015-06-09</span>—<span>2015-06-09</span></td>

                        </tr>
                        <tr>
                            <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>
                            <td>
                                <span>进行中</span>
                            </td>
                        </tr>
                    </table>
                </li>
                <li class="clearfix">
                    <h2 style="padding:0 20px 10px 0;margin: 0;font-size: 20px;color:#03a9f4">任务一：<span style="color:#797979;">企业数据报告分析</span></h2>

                    <table class="table table-bordered f-l" style="border-spacing: 0;margin-right: 20px;width:48%">
                        <tr>
                            <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">负责人</th>
                            <td width="75%"><span></span></td>

                        </tr>
                        <tr>
                            <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务权重</th>
                            <td>
                                <span></span>
                            </td>
                        </tr>
                    </table>
                    <table class="table table-bordered f-l" style="border-spacing: 0;width:48%;">
                        <tr>
                            <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;">起止日</th>
                            <td width="75%"><span>2015-06-09</span>—<span>2015-06-09</span></td>

                        </tr>
                        <tr>
                            <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>
                            <td>
                                <span>进行中</span>
                            </td>
                        </tr>
                    </table>
                </li>
            </ul>
        </ul>

    </div>
</div>
<!--目标详情 end-->
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
    <script src="${resource(dir: 'js', file: 'advanced-form-components.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-datepicker/js', file: 'bootstrap-datepicker.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-datetimepicker/js', file: 'bootstrap-datetimepicker.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-daterangepicker', file: 'moment.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-daterangepicker', file: 'daterangepicker.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-colorpicker/js', file: 'bootstrap-colorpicker.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-timepicker/js', file: 'bootstrap-timepicker.js')}"></script>
<!--right slidebar-->
    <script src="${resource(dir: 'js', file: 'slidebars.min.js')}"></script>

    <!--common script for all pages-->
    <script src="${resource(dir: 'js', file: 'common-scripts.js')}"></script>

    <!--script for this page-->
    <script src="${resource(dir: 'js', file: 'sparkline-chart.js')}"></script>
    <script src="${resource(dir: 'js', file: 'easy-pie-chart.js')}"></script>
    <script src="${resource(dir: 'js', file: 'count.js')}"></script>

    <script>
        $(document).ready(function() {
            $("#tar_edit").click(function(){
                $("#tar_fj").css('display','block');
                event.stopPropagation();
            })
            $("#newmission").click(function(){
                $("#tar_whole").css('display','none');
                $("#newmissiondetail").css('display','block');
            })
            $("#newapply").click(function(){
                $("#newapplydetail").css("display","block");
            });
            $(".close").click(function(){
                $("#newapplydetail").css("display","none");
                $("#tar_detail").css("display","none");
                $("#newmissiondetail").css('display','none');
                $("#tar_fj").css('display','none');
            });
            $(".toolkit .task-order").click(function () {
                var ul = $(".toolkit .shaixuan ul");

                if (ul.css("display") == "none") {
                    ul.slideDown("fast");
                    $(".toolkit .task-order").css("border-bottom", "1px solid #fff");
                } else {
                    ul.slideUp("fast");
                    $(".toolkit .task-order").css("border-bottom", "none");
                }
        });
            $(".tar_whole").click(function(){
                $("#tar_detail").css("display","block");
            })

            /* $("#newapply").click(function(){
                $("#newapplydetail").css("display","block");
            });
            $(".close").click(function(){
                $("#newapplydetail").css("display","none");
            });

            $("#apply_tab tr").click(function(){
                $("#applydetails").css("display","block");
            })
            $(".close").click(function(){
                $("#applydetails").css("display","none");
            });*/

        })
    </script>
    %{--<script>--}%

    %{--//owl carousel--}%

    %{--$(document).ready(function() {--}%
    %{--$("#owl-demo").owlCarousel({--}%
    %{--navigation : true,--}%
    %{--slideSpeed : 300,--}%
    %{--paginationSpeed : 400,--}%
    %{--singleItem : true,--}%
    %{--autoPlay:true--}%

    %{--});--}%
    %{--});--}%

    %{--//custom select box--}%

    %{--$(function(){--}%
    %{--$('select.styled').customSelect();--}%
    %{--});--}%

    %{--</script>--}%

</body>
</html>