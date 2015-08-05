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
        .passwordedit .button{width:82px;height:34px;border:none;background:#03a9f4;color:#fff;}
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

                            <g:each in="${targetInstance}" var="targetInfo">

                            <div class="tar_whole f-l">
                                <input type="hidden" value="${targetInfo.id}"  />
                                <div class="tar_title clearfix" >
                                    <img class="f-l" src="${resource(dir:'img/target-img',file:'1.png')}" title="更换图片"/>
                                    <div class="f-l" style="margin-left:10px;">

                                        <h2 style="font-size:20px;margin:4px;color:#40bdf5;">${targetInfo.title}</h2>
                                        负责人：<span>${com.guihuabao.CompanyUser.findByIdAndCid(targetInfo.fzuid,session.company.id).name}</span>
                                    </div>
                                    <div class="f-r">
                                        <a href="#" style="color:#40bdf5;font-size:20px;"><i class="fa fa-edit tar_edit" title="目标分解"></i></a>
                                        <input type="hidden" value="${targetInfo.id}"  />
                                        <g:link action="targetDelete" id="${targetInfo.id}" style="color:#40bdf5;font-size:20px;"><i class="fa fa-trash-o tar_delete" title="删除目标"></i></g:link>
                                    </div>
                                </div>

                                <div class="tar_content clearfix">
                                    <div class="f-l percent">${targetInfo.percent}%</div>
                                    <div class="f-l"style="margin-left: 10px;">共<span>${targetInfo.mission.size()}</span>位同事参与</div>
                                </div>
                                <div class="clearfix" style="width:235px;margin:0 auto;">
                                    <span class="btime f-l">${targetInfo.begintime}</span><span class="etime f-l" style="width:133px;">${targetInfo.etime}</span>
                                </div>

                            </div>
                            </g:each>

                            <span style="display: none;" id="var_all"></span>


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
<div class="passwordedit" id="newapplydetail" style="position:absolute;overflow: scroll;">
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
                        <td width="85%">${session.user.name}<input  name="fzuid" value="${session.user.id}" type="hidden"/></td>

                    </tr>
                    <tr>
                        <th style="text-align:center;width:15%;background:#f8f8f8;line-height: 40px;" >起止日</th>
                        <td style="line-height: 40px;">
                            %{--<input type="text" name="btime" style="width:88px;height:28px;"/>—<input type="text" name="etime" style="width:88px;height:28px;"/>--}%
                            <input id="startdate" name="begintime" value="" readonly="" class="default-date-picker " type="text" style="width:100px;">—<input id="enddate" name="etime" value="" readonly="" class="form_datetime" type="text" style="width:143px;">
                        </td>

                    </tr>
                </table>
            </li>
            <li class="clearfix">
                <div class="f-r">
                    <g:actionSubmit  value="保存" style="margin-right: 10px;" action="targetSave" class="button"/>
                    <g:actionSubmit class="tar_edit button" value="保存并分解目标" style="width:160px;" action="targetSave"/>
                </div>
            </li>
        </ul>
        </g:form>
    </div>
</div>
<!--新建弹层 end-->
<!--目标分解 start-->
<div class="passwordedit" id="tar_fj" style="position:absolute;overflow: scroll;">
    <div class="m_box" style="width:804px;">
        <header class="panel-heading" style="padding:10px 28px;">
            <span>目标分解</span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>

        <ul>
            <li>
                <h2  id="newmission" style="padding:0;margin: 0 20px 0 0;font-size: 20px;" ><i class="fa fa-plus-circle" style="margin-right: 10px;"></i>新建任务<span>(剩余任务权重<span id="percent-mission">40</span>%)</span></h2>
            </li>
            <li class="clearfix">
                <input type="submit" value="提交" class="f-r button"  disabled />
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
            <form action="">
                <input type="hidden" name="target_id" id="target_id" />
            <li >
                <input type="text" name="title" placeholder="一句话描述任务" id="newmission_title"/>
            </li>
            <li>
                <input type="text" name="content" placeholder="添加任务详情" id="newmission_content"/>
            </li>
            <li>
                <table class="table table-bordered" style="border-spacing: 0;margin-right: 20px;">
                    <tr>
                        <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">执行人</th>
                        <td width="75%"><input type="hidden" id="playuid" name="playuid" value=""  id="newmission_playuid"/>
                            <input type="hidden" id="playbid" name="playbid" value="" />
                            <input type="hidden" id="playname" name="playname" value="" />
                            <div class="zhxr">
                                <a id="playman"><i class="fa fa-plus-square-o" ></i></a>
                            </div></td>

                    </tr>
                    <tr>
                        <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;line-height: 30px;">起止日</th>
                        <td width="75%"> <input id="startdate" name="begintime" value="" readonly="" class="default-date-picker" type="text" style="width:100px;" >-<input id="enddate" name="overtime" value="" readonly="" class="form_datetime" type="text" style="width:143px;"></td>

                    </tr>
                    <tr>
                        <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">任务权重</th>
                        <td width="75%"><input  name="percent" style="border:none;width:100%" id="newmission_percent"/></td>

                    </tr>
                    <tr>
                        <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>
                        <td>
                           <input name="status" value="进行中" readonly style="border:none;" id="newmission_status"/>

                        </td>
                    </tr>
                </table>
            </li>

            <li class="clearfix">
                <button type="submit" class="f-r" style="width:82px;height:34px;border:none;background:#03a9f4;color:#fff;" id="save_mission">确认</button>
            </li>
            </form>
        </ul>
    </div>
</div>
<!--新建任务 end-->
<!--编辑任务 start-->
<div class="passwordedit" id="mission_edit">
    <div class="m_box" style="width:804px;">
        <header class="panel-heading" style="padding:10px 28px;">
            <span><i class="yh"></i>编辑任务</span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>

        <ul>
            <form action="">
                <input type="hidden" name="target_id" id="target_id_edit" />
                <li >
                    <input type="text" name="title" placeholder="一句话描述任务" id="mission_title_edit"/>
                </li>
                <li>
                    <input type="text" name="content" placeholder="添加任务详情" id="mission_content_edit"/>
                </li>
                <li>
                    <table class="table table-bordered" style="border-spacing: 0;margin-right: 20px;">
                        <tr>
                            <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">执行人</th>
                            <td width="75%"><input type="hidden" id="playuid_edit" name="playuid" value="" />
                                <input type="hidden" id="playbid_edit" name="playbid" value="" />
                                <input type="hidden" id="playname_edit" name="playname" value="" />
                                <div class="zhxr">
                                    <a id="playman_edit"><i class="fa fa-plus-square-o" ></i></a>
                                </div></td>

                        </tr>
                        <tr>
                            <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;line-height: 30px;">起止日</th>
                            <td width="75%"> <input id="startdate_edit" name="begintime" value="" readonly="" class="default-date-picker" type="text" style="width:100px;" >-<input id="enddate_edit" name="overtime" value="" readonly="" class="form_datetime" type="text" style="width:143px;"></td>

                        </tr>
                        <tr>
                            <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">任务权重</th>
                            <td width="75%"><input  name="percent" style="border:none;width:100%" id="mission_percent_edit"/></td>

                        </tr>
                        <tr>
                            <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>
                            <td>
                                <input name="status" value="进行中" readonly style="border:none;" id="mission_status_edit"/>

                            </td>
                        </tr>
                    </table>
                </li>

                <li class="clearfix">
                    <button type="submit" class="f-r" style="width:82px;height:34px;border:none;background:#03a9f4;color:#fff;" id="save_mission_edit">确认</button>
                </li>
            </form>
        </ul>
    </div>
</div>
<!--编辑任务 end-->
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
                <h2 class="f-l" style="padding:0;margin: 0 20px 0 0;font-size: 20px;line-height:48px;" id="detail.title"></h2>
            </li>
            <li>
                详情：<span id="detail_content"></span>
            </li>
            <li>
                负责人：<span id="detail_fz"></span>
            </li>
            <li>
                起止日：<span id="detail_btime"></span>—<span id="detail_etime"></span>
            </li>

            <h2 style="padding:10px 0;font-size: 20px;border-bottom: 1px solid #d2d2d2;">目标分解</h2>

            <ul class="rwfj" style="padding:0;margin:0;">
                %{--<li class="clearfix">--}%
                    %{--<h2 style="padding:0 20px 10px 0;margin: 0;font-size: 20px;color:#03a9f4">任务一：<span style="color:#797979;">企业数据报告分析</span></h2>--}%

                    %{--<table class="table table-bordered f-l" style="border-spacing: 0;margin-right: 20px;width:48%">--}%
                        %{--<tr>--}%
                            %{--<th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">负责人</th>--}%
                            %{--<td width="75%"><span></span></td>--}%

                        %{--</tr>--}%
                        %{--<tr>--}%
                            %{--<th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务权重</th>--}%
                            %{--<td>--}%
                                %{--<span></span>--}%
                            %{--</td>--}%
                        %{--</tr>--}%
                    %{--</table>--}%
                    %{--<table class="table table-bordered f-l" style="border-spacing: 0;width:48%;">--}%
                        %{--<tr>--}%
                            %{--<th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;">起止日</th>--}%
                            %{--<td width="75%"><span>2015-06-09</span>—<span>2015-06-09</span></td>--}%

                        %{--</tr>--}%
                        %{--<tr>--}%
                            %{--<th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>--}%
                            %{--<td>--}%
                                %{--<span>进行中</span>--}%
                            %{--</td>--}%
                        %{--</tr>--}%
                    %{--</table>--}%
                %{--</li>--}%


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

<script type="text/javascript" src="${resource(dir: 'assets/fuelux/js', file: 'spinner.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-fileupload', file: 'bootstrap-fileupload.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-wysihtml5', file: 'wysihtml5-0.3.0.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-wysihtml5', file: 'bootstrap-wysihtml5.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-datepicker/js', file: 'bootstrap-datepicker.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-datetimepicker/js', file: 'bootstrap-datetimepicker.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-daterangepicker', file: 'moment.min.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-daterangepicker', file: 'daterangepicker.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-colorpicker/js', file: 'bootstrap-colorpicker.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-timepicker/js', file: 'bootstrap-timepicker.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/jquery-multi-select/js', file: 'jquery.multi-select.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/jquery-multi-select/js', file: 'jquery.quicksearch.js')}"></script>
<!--菜单js-->
<script src="${resource(dir: 'js', file: 'advanced-form-components.js')}"></script>
<script src="${resource(dir: 'js', file: 'context.js')}"></script>
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
            $(".tar_edit").click(function(){

                event.stopPropagation();

                var tid=$(this).parent().next().val();
                $('#var_all').html(tid);

                var html='';
                $.ajax( {
                    url:'${webRequest.baseUrl}/front/tshow?target_id='+tid+'',
                    method:'post',
                    dataType:'json',
                    success:function(data){

                        var target=data.target;

                        var missionlist=data.mission;

                        for(var i=0;i<missionlist.length;i++){
                            html+=' <li class="clearfix">'+
                            '<h2 style="padding:0;margin: 0 20px 0 0;font-size: 20px;color:#03a9f4" class="f-l">任务'+(i+1)+'：<span style="color:#797979;">'+missionlist[i].title+'</span></h2>'+
                            '<div class="f-l" style="font-size: 20px;margin-top:7px;">'+
                                    '<a href="#" id="mission_edit" style="font-size:20px;margin-right:5px;"><i class="fa fa-edit"></i></a>'+
                            '<a href="#" style="font-size:20px;" id="mission_delete"><i class="fa fa-trash-o"></i></a>'+
                            '</div>'+
                            '</li>'+
                            '<li class="clearfix">'+
                                    '<table class="table table-bordered f-l" style="border-spacing: 0;margin-right: 20px;width:48%">'+
                                    '<tr>'+
                                    '<th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">负责人</th>'+
                           ' <td width="75%">'+missionlist[i].fzuid+'</td>'+
                            '</tr>'+
                            '<tr>'+
                           ' <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务权重</th>'+
                            '<td><input  name="fzuid" style="border:none;width:75%" value="'+missionlist[i].percent+'"%/></td>'+
                            '</tr>'+
                            '</table>'+
                            '<table class="table table-bordered f-l" style="border-spacing: 0;width:48%;">'+
                                   ' <tr>'+
                                    '<th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;">起止日</th>'+
                          ' <td width="75%"><span>'+missionlist[i].begintime+'</span>—<span>'+missionlist[i].overtime +'</span></td>'+

                           ' </tr>'+
                           ' <tr>'+
                           ' <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>'+
                           ' <td>'+
                            '<span>'+missionlist[i].status+'</span>'+
                            '</td>'+
                            '</tr>'+
                            '</table>'+
                            '</li>';
                            $('#mission_edit').click(function(){
                                $('#target_id_edit').val(tid);
                                $('#mission_title_edit').val(missionlist[i].title);
                                $('#mission_content_edit').val(missionlist[i].content);
                                $('#playuid_edit').val(mission[i].playuid);
                                $('#startdate_edit').val(missionlist[i].begintime);
                                $('#enddate_edit').val(missionlist[i].overtime);
                                $('#mission_percent_edit').val(missionlist[i].percent);
                                $('#mission_status_edit').val(missionlist[i].status);

                                $('#mission_edit').css('display','block');
                            })
                        }
                        $("#tar_fj ul").prepend(html);
                    },error:function(){alert("获取数据失败");}});


                $("#tar_fj").css('display','block');

                } )

            $(".tar_delete").click(function(){
                event.stopPropagation();
            })


            $("#newapply").click(function(){
                $("#newapplydetail").css("display","block");
            });
            $(".close").click(function(){
//                $("#newapplydetail").css("display","none");
//                $("#tar_detail").css("display","none");
//                $("#newmissiondetail").css('display','none');
//                $("#tar_fj").css('display','none');
                location.reload();
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

            var all_tars=$(".tar_whole");
            var tar_mission='';

//           $.each(all_tars,function() {

            $(".tar_whole").click(function () {
                var tid=$(this).find('input:first').val();
                    $.ajax({
                        url: '${webRequest.baseUrl}/front/tshow?target_id=' +tid  + '',
                        method: 'post',
                        dataType: 'json',
                        success: function (data) {

                            $('#detail_title').html(data.target.title);
                            $('#detail_content').html (data.target.content);
                            $('#detail_fz').html(data.target.fzuid)
                            $('#detail_btime').html ( data.target.begintime);
                            $('#detail_etime').html (data.target.etime);

                            var mission=data.mission;

                            for(var i=0;i<mission.length;i++){

                            tar_mission+='     <li class="clearfix">'+
                            ' <h2 style="padding:0 20px 10px 0;margin: 0;font-size: 20px;color:#03a9f4">任务'+(i+1)+'：<span style="color:#797979;">'+mission[i].title+'</span></h2>'+

                            '<table class="table table-bordered f-l" style="border-spacing: 0;margin-right: 20px;width:48%">'+
                            '<tr>'+
                            ' <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">执行人</th>'+
                            %{--'<td width="75%"><span>'+ ${com.guihuabao.CompanyUser.findByCidAndId(session.user.cid,mission[i].playuid).name}+'</span></td>'+--}%
                            '</tr>'+
                            ' <tr>'+
                            ' <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务权重</th>'+
                            ' <td>'+
                            '<span>'+mission[i].percent+'</span>'+
                            ' </td>'+
                            ' </tr>'+
                            ' </table>'+
                            ' <table class="table table-bordered f-l" style="border-spacing: 0;width:48%;">'+
                            ' <tr>'+
                            '<th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;">起止日</th>'+
                            ' <td width="75%"><span>'+mission[i].begintime+'</span>—<span>'+mission[i].overtimeour+'</span></td>'+
                            '</tr>'+
                            ' <tr>'+
                            '<th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>'+
                            '<td>'+
                            ' <span>'+mission[i].status+'</span>'+
                            '</td>'+
                            '</tr>'+
                            '</table>'+
                            '</li>';
                            $("#tar_detail .rwfj").append(tar_mission);

                           }

                            }
                        ,error:function(){alert("获取数据失败")}})
                            $("#tar_detail").css("display","block");
                            })
//                })



            context.init({preventDoubleContext: false});

            context.attach('#playman', [
                <g:if test=" ${session.user.pid==1}">
                {header: '部门'},
                <g:each in="${bumenInstance}" var="bumenInfo">
                {text: '${bumenInfo.name}', subMenu: [
                    {header: '员工'},
                    <g:each in="${com.guihuabao.CompanyUser.findAllByCidAndBid(session.company.id,bumenInfo.id)}" var="userInfo">
                    {text: '${userInfo.name}', href: '#', action: function(e){
                        $("#playuid").val(${userInfo.id});
                        $("#playbid").val(${userInfo.bid});
                        $("#playname").val("${userInfo.name}");
                        $(this).hide();
                        $(".zhxr").html("${userInfo.name}");
                    }},
                    </g:each>
                ]},
                </g:each>
                </g:if>
                <g:else>
                <g:each in="${com.guihuabao.CompanyUser.findAllByCidAndBid(session.company.id,session.user.bid)}" var="userInfo">
                {text: '${userInfo.name}', href: '#', action: function(e){
                    $("#playuid").val(${userInfo.id});
                    $("#playbid").val(${userInfo.bid});
                    $("#playname").val("${userInfo.name}");
                    $(this).hide();
                    $(".zhxr").html("${userInfo.name}");
                }}
                </g:each>
                </g:else>
            ]);
            $("#newmission").click(function(){
                $('#target_id').val($('#var_all').html());

                $("#tar_whole").css('display','none');
                $("#newmissiondetail").css('display','block');
                $("#save_mission").click(function(){
                    var target_id=$('#target_id').val();
                    var title=$('#newmission_title').val();
                    var content=$('#newmission_content').val();
                    var playuid=$('#newmission_playuid').val();
                    var begintime=$('#startdate').val();
                    var overtime=$('#enddate').val();
                    var percent=$('#newmission_percent').val();
                    var status=$('#newmission_status').val();
                    $.ajax({
                        url:'${webRequest.baseUrl}/front/missionSave',
                        type:'post',
                        dataType:'json',
                        data:{target_id:target_id,title:title,content:content,playuid:playuid,begintime:begintime,overtime:overtime,percent:percent,status:status},
                        success:function(data){

                            var html=' <li class="clearfix">'+
                                    '<h2 style="padding:0;margin: 0 20px 0 0;font-size: 20px;color:#03a9f4" class="f-l">任务'+(data.target.mission.length)+'：<span style="color:#797979;">'+data.title+'</span></h2>'+
                                    '<div class="f-l" style="font-size: 20px;margin-top:7px;">'+
                                    '<a href="#" id="mission_edit" style="font-size:20px;margin-right:5px;"><i class="fa fa-edit"></i></a>'+
                                    '<a href="#" style="font-size:20px;"><i class="fa fa-trash-o"></i></a>'+
                                    '</div>'+
                                    '</li>'+
                                    '<li class="clearfix">'+
                                    '<table class="table table-bordered f-l" style="border-spacing: 0;margin-right: 20px;width:48%">'+
                                    '<tr>'+
                                    '<th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">负责人</th>'+
                                    ' <td width="75%">'+data.playuid+'</td>'+
                                    '</tr>'+
                                    '<tr>'+
                                    ' <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务权重</th>'+
                                    '<td><input  name="fzuid" style="border:none;width:75%" value="'+data.percent+'"%/></td>'+
                                    '</tr>'+
                                    '</table>'+
                                    '<table class="table table-bordered f-l" style="border-spacing: 0;width:48%;">'+
                                    ' <tr>'+
                                    '<th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;">起止日</th>'+
                                    ' <td width="75%"><span>'+data.begintime+'</span>—<span>'+data.overtime +'</span></td>'+

                                    ' </tr>'+
                                    ' <tr>'+
                                    ' <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>'+
                                    ' <td>'+
                                    '<span>'+data.status+'</span>'+
                                    '</td>'+
                                    '</tr>'+
                                    '</table>'+
                                    '</li>';
                            $("#tar_fj ul").prepend(html);
                            $("#newmissiondetail").css('display','none');
                            $("#tar_whole").css('display','block');
                        },
                        error:function(){alert("获取数据失败")}
                    })

                });
            })
        })
    </script>

</body>
</html>