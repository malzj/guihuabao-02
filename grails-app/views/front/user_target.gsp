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

    <link href="${resource(dir: 'css', file: 'context.standalone.css')}" rel="stylesheet">
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
        #select_img h2{font-size:20px;margin:15px 30px;}
        #select_img .ori{margin-left:120px;}
        #select_img .bx img{margin-right:40px;margin-bottom:40px;}
        #select_img a{cursor:pointer;}
        #select_img .upload{margin-left:20px;line-height:44px;}
        .discuss{padding:10px 30px;}
        .discuss h4,.discuss span {
            font-size: 12px;
            margin: 0px;
            padding: 10px 25px;
            background: transparent url("../img/dis_icon.png") no-repeat scroll 0% -27%;
        }
        .discuss span {cursor: pointer;}
        .discuss textarea {
            width: 100%;
            height: 130px;
            padding: 10px;
            box-shadow: 0px 6px 5px -3px #D5D5D2 inset;
            background-color: #FFF;
            border: 1px solid #D0D0D0;
        }
        .sub li { background: none;}
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
    <div class="col-xs-3" style="height:100%"></div>
    <g:render template="target_sider" />
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content" class="col-xs-9" style="padding-left:0;">
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
                        <a href="#" id="newtarget" class="f-r"><i class="fa fa-plus-circle"></i>新建目标</a>

                    </div>
                    <div class="content">
                        <div style="margin-top:20px;" class="clearfix">

                            <g:each in="${targetInstance}" var="targetInfo">

                            <div class="tar_whole f-l">
                                <input type="hidden" value="${targetInfo.id}"  />
                                <div class="tar_title clearfix" >
                                    <a class="select_img" onclick="stop_Pro(event)"><img class="f-l" src="${resource(dir:'img/target-img',file:''+targetInfo.img+'')}" title="更换图片" width="48px" height="48px"/></a>
                                    <div class="f-l" style="margin-left:10px;">

                                        <h2 style="font-size:20px;margin:4px;color:#40bdf5;">${targetInfo.title}</h2>
                                        负责人：<span>${com.guihuabao.CompanyUser.findByIdAndCid(targetInfo.fzuid,session.company.id).name}</span>
                                    </div>
                                    <div class="f-r">
                                        <a href="#" style="color:#40bdf5;font-size:20px;"  onclick="stop_Pro(event)"><i class="fa fa-edit tar_edit" title="目标分解"></i></a>
                                        <input type="hidden" value="${targetInfo.id}"  />
                                        <g:link controller="front" action="targetDelete" id="${targetInfo.id}" style="color:#40bdf5;font-size:20px;" onclick="confirm('确定删除？');stop_Pro(event)"><i class="fa fa-trash-o tar_delete" title="删除目标"></i></g:link>
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
                            <span style="display: none;" id="all_var"></span>

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
</div>
<!--新建弹层 start-->
<div class="passwordedit" id="newtargetdetail" style="position:absolute;overflow: scroll;">
    <div class="m_box" style="width:804px;">
        <header class="panel-heading" style="padding:10px 28px;">
            <span><i class="yh"></i>添加新目标</span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>
        <g:form url="[controller:'front',action:'targetSave']" method="post">
        <ul>
            <li class="clearfix">
                <div align="right" class="f-l" style="margin-right: 10px;"><img src="${resource(dir:'img/target-img',file:'1.png')}"></div>
                <div class="f-l">
                    <input type="text" name="title" placeholder="添加目标名称" style="margin-top: 5px;width:689px;" class="nr" title="该字段不能为空！" id="tar_title"/>
                </div>

            </li>
            <li>
                <textarea name="content" rows="4" placeholder="这里可以添加目标详情" style="width:100%;height:68px;resize: none;" class="nr" title="该字段不能为空！" id="tar_con"></textarea>
            </li>
            <li>
                <table width="100%" class="table table-bordered" style="border-spacing: 0;">
                    <tr>
                        <th style="text-align: center;width:15%;background:#f8f8f8">负责人</th>
                        <td width="85%" class="nr">${session.user.name}<input  name="fzuid" value="${session.user.id}" type="hidden" class="nr" id="tar_fzuid"/></td>

                    </tr>
                    <tr>
                        <th style="text-align:center;width:15%;background:#f8f8f8;line-height: 40px;" >起止日</th>
                        <td style="line-height: 40px;">
                            %{--<input type="text" name="btime" style="width:88px;height:28px;"/>—<input type="text" name="etime" style="width:88px;height:28px;"/>--}%
                            <input id="startdate" name="begintime" value="" readonly="" class="default-date-picker nr" type="text" style="width:120px;" title="该字段不能为空！">—<input id="enddate" name="etime" value="" readonly="" class="form_datetime nr" type="text" style="width:163px;" title="该字段不能为空！">
                        </td>

                    </tr>
                </table>
            </li>
            <li class="clearfix">
                <div class="f-r">

                    <button type="submit"  style="margin-right: 10px;" class="button" id="save_target">保存</button>
                    <a class="button"  style="width:160px;line-height:32px;display:inline-block;text-align: center;" id="saf"  >保存并分解目标</a>

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

        </ul>

           <a style="cursor: pointer"> <h2  id="newmission" style="padding:0;margin: 0 20px 0 0;font-size: 20px;margin:30px;" ><i class="fa fa-plus-circle" style="margin-right: 10px;"></i>新建任务<span>(剩余任务权重<span id="r_per">40</span>%)</span></h2><span id="rp" style="display:none"></span></a>
           <div id="issubmit" style="margin-left: 30px;color:#03a9f4;"></div>

        <div class="clearfix" style="margin:40px;">
            <input type="submit" value="提交" class="f-r button"  id="submit"  />
        </div>
    </div>
</div>
<!--目标分解 end-->

<!--选择图片 start-->
<div class="passwordedit" id="select_img" style="position:absolute;overflow: scroll;">
    <div class="m_box clearfix" style="width:804px;margin:200px auto;">
        <header class="panel-heading" style="padding:10px 28px;">
            <span>选择图片</span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>

        </header>
        <h2>已选图标</h2>
        <div class="clearfix ori">
            <a class="f-l"><div id="imgDefault"><img  src="" id="img" width="48px" height="48px"/><span style="display:none;" id="filename"></span></div></a>
            <div class="f-l upload">
                <a><form method="post" id="uploadForm" enctype="multipart/form-data">
                    <i class="fa fa-plus-circle"></i>
                    <input type="file" id="up_img" name="file1" style="display:inline-block" class="nr"/>
                    <input type="button" class="btn" id="upload" value="上传" style="width:80px;height:30px;line-height:16px;background:#03a9f4;color:#fff;"/>
               </form></a>
            </div>
        </div>
        <h2>备选图标</h2>
        <div class="ori bx">
            <a><img  src="${resource(dir:'img/target-img',file:'1.png')}"/></a>
            <a><img  src="${resource(dir:'img/target-img',file:'2.png')}"/></a>
            <a><img  src="${resource(dir:'img/target-img',file:'3.png')}"/></a>
            <a><img  src="${resource(dir:'img/target-img',file:'4.png')}"/></a>
            <a><img  src="${resource(dir:'img/target-img',file:'5.png')}"/></a>
            <a><img  src="${resource(dir:'img/target-img',file:'6.png')}"/></a>
            <a><img  src="${resource(dir:'img/target-img',file:'7.png')}"/></a>
            <a><img  src="${resource(dir:'img/target-img',file:'8.png')}"/></a>
            <a><img  src="${resource(dir:'img/target-img',file:'9.png')}"/></a>
            <a><img  src="${resource(dir:'img/target-img',file:'10.png')}"/></a>
            <a><img  src="${resource(dir:'img/target-img',file:'11.png')}"/></a>
            <a><img  src="${resource(dir:'img/target-img',file:'12.png')}"/></a>

        </div>
        <div class="f-r" style="margin-right: 30px;"><input type="button" class="btn" id="upimg" value="确认" style="width:80px;height:30px;line-height:16px;background:#03a9f4;color:#fff;"/></div>
    </div>
</div>
<!--选择图片 end-->

<!--新建任务 start-->
<div class="passwordedit popup_box" id="newmissiondetail">
    <div class="m_box" style="width:804px;">
        <header class="panel-heading" style="padding:10px 28px;">
            <span><i class="yh"></i>新建任务</span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>

        <ul>

                <input type="hidden" name="target_id" id="target_id" class="nr"/>
            <li >
                <input type="text" name="title" placeholder="一句话描述任务" id="newmission_title" class="nr" title="该字段不能为空！"/>
            </li>
            <li>
                <input type="text" name="content" placeholder="添加任务详情" id="newmission_content" class="nr" title="该字段不能为空！"/>
            </li>
            <li>
                <table class="table table-bordered" style="border-spacing: 0;margin-right: 20px;">
                    <tr>
                        <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">执行人</th>
                        <td width="75%" >

                            <input type="hidden"  name="playuid" value=""  id="newmission_playname" class="nr" title="该字段不能为空！"/>
                            <input type="hidden" id="playbid" name="playbid" value="" class="nr" title="该字段不能为空！"/>
                            <input type="hidden" id="playname" name="playname" value="" class="nr" title="该字段不能为空！"/>
                            <div class="dropdown"><span class="zhxr con"></span>
                                <a  id="playman" style="cursor:pointer;" class="menu"  data-toggle="dropdown"><i class="fa fa-plus-square-o"></i></a>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel" style="margin:0;" id="topmenu">

                                    <g:if test="${session.user.pid==1}">
                                        <g:each in="${bumenInstance}" var="bumenInfo">
                                            <li class="dropdown-submenu "  >
                                                <a tabindex="-1"  data-toggle="dropdown" class="bumen">${bumenInfo.name}<span style="display:none" >${bumenInfo.id}</span></a>
                                                <ul class="dropdown-menu"  role="menu" aria-labelledby="dLabel"  style="margin:0;padding-top:20px;">
                                                    <g:each in="${com.guihuabao.CompanyUser.findAllByCidAndBid(session.company.id,bumenInfo.id)}" var="userInfo">
                                                         <li  class="dropdown" ><a class="pn user">${userInfo.name}</a><span style="display:none">${userInfo.id}</span></li>
                                                    </g:each>
                                                </ul>
                                            </li>
                                        </g:each>
                                    </g:if>
                                    <g:else>
                                         <g:each in="${com.guihuabao.CompanyUser.findAllByCidAndBid(session.company.id,session.user.bid)}" var="userInfo">
                                             <li  class="dropdown"><a class="pn">${userInfo.name}<span style="display:-none">${userInfo.id}</span></a></li>
                                         </g:each>
                                    </g:else>
                                </ul>

                            </div></td>

                    </tr>
                    <tr>
                        <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;line-height: 30px;">起止日</th>
                        <td width="75%"> <input id="startdate_mission" name="begintime" value="" readonly="" class="default-date-picker nr" type="text" style="width:120px;" title="该字段不能为空！">-<input id="enddate_mission" name="overtime" value="" readonly="" class="form_datetime nr" type="text" style="width:163px;" title="该字段不能为空！"></td>

                    </tr>
                    <tr>
                        <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">任务权重</th>
                        <td width="75%"><input  name="percent" style="border:none;width:100%" id="newmission_percent" class="nr" title="该字段不能为空且必须是不超过100的数字！"/></td>

                    </tr>
                    <tr>
                        <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>
                        <td>
                            进行中 <input name="status" value="0"  style="border:none;" type="hidden" id="newmission_status"  title="该字段不能为空！"/>

                        </td>
                    </tr>
                </table>
            </li>

            <li class="clearfix">
                <button type="submit" class="f-r" style="width:82px;height:34px;border:none;background:#03a9f4;color:#fff;" id="save_mission">确认</button>
            </li>

        </ul>
    </div>
</div>
<!--新建任务 end-->
<!--编辑任务 start-->
<div class="passwordedit popup_box" id="mission_edit_detail">
    <div class="m_box" style="width:804px;">
        <header class="panel-heading" style="padding:10px 28px;">
            <span><i class="yh"></i>编辑任务</span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>

        <ul>

                <input type="hidden" name="target_id" id="target_id_edit" />
                <li >
                    <input type="text" name="title" placeholder="一句话描述任务" id="mission_title_edit" title="该字段不能为空！"/>
                </li>
                <li>
                    <input type="text" name="content" placeholder="添加任务详情" id="mission_content_edit" title="该字段不能为空！"/>
                </li>
                <li>
                    <table class="table table-bordered" style="border-spacing: 0;margin-right: 20px;">
                        <tr>
                            <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">执行人</th>
                            <td width="75%">
                                <input type="hidden" id="playuid_edit" name="playuid" value="" title="该字段不能为空！"/>
                                <input type="hidden" id="playbid_edit" name="playbid" value="" title="该字段不能为空！"/>
                                <input type="hidden" id="playname_edit" name="playname" value="" title="该字段不能为空！"/>
                                <div class="dropdown"><span class="zhxr con"></span>
                                    <a  id="playman_edit" style="cursor:pointer;" class="menu"  data-toggle="dropdown"><i class="fa fa-plus-square-o"></i></a>
                                    <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel" style="margin:0;" >

                                        <g:if test="${session.user.pid==1}">
                                            <g:each in="${bumenInstance}" var="bumenInfo">
                                                <li class="dropdown-submenu "  >
                                                    <a tabindex="-1"  data-toggle="dropdown" class="bumen">${bumenInfo.name}<span style="display:none" >${bumenInfo.id}</span></a>
                                                    <ul class="dropdown-menu"  role="menu1" aria-labelledby="dLabel"  style="margin:0;padding-top:20px;">
                                                        <g:each in="${com.guihuabao.CompanyUser.findAllByCidAndBid(session.company.id,bumenInfo.id)}" var="userInfo">
                                                            <li  class="dropdown" ><a class="pn user">${userInfo.name}</a><span style="display:none">${userInfo.id}</span></li>
                                                        </g:each>
                                                    </ul>
                                                </li>
                                            </g:each>
                                        </g:if>
                                        <g:else>
                                            <g:each in="${com.guihuabao.CompanyUser.findAllByCidAndBid(session.company.id,session.user.bid)}" var="userInfo">
                                                <li  class="dropdown"><a class="pn">${userInfo.name}<span style="display:none">${userInfo.id}</span></a></li>
                                            </g:each>
                                        </g:else>
                                    </ul>

                                </div></td>

                        </tr>
                        <tr>
                            <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;line-height: 30px;">起止日</th>
                            <td width="75%" style="line-height:36px;"> <input id="startdate_edit" name="begintime" value="" readonly="" class="default-date-picker" type="text" style="width:120px;" title="该字段不能为空！">—<input id="enddate_edit" name="overtime" value="" readonly="" class="form_datetime" type="text" style="width:163px;" title="该字段不能为空！"></td>

                        </tr>
                        <tr>
                            <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">任务权重</th>
                            <td width="75%"><input  name="percent" style="border:none;width:100%" id="mission_percent_edit" title="该字段不能为空且只能为数字！" type="number" /></td>

                        </tr>
                        <tr>
                            <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>
                            <td>
                                <select name="status" style="border:none;" id="mission_status_edit" title="该字段不能为空！">
                                    <option value="0" selected>进行中</option>
                                    <option value="1">完成</option>
                                </select>

                            </td>
                        </tr>
                    </table>
                </li>

                <li class="clearfix">
                    <input type="hidden" id="mid"/>
                    <button type="submit" class="f-r" style="width:82px;height:34px;border:none;background:#03a9f4;color:#fff;" id="save_mission_edit">确认</button>
                </li>

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
                <h2 class="f-l" style="padding:0;margin: 0 20px 0 0;font-size: 20px;line-height:48px;" id="detail_title"></h2>
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

            </ul>
        </ul>

    </div>
</div>
<!--目标详情 end-->
<!--评论及反馈 start-->
<div class="passwordedit" id="task" style="width:100%;background-color:transparent;position:absolute;overflow: scroll;z-index:2000">
    <div class="m_box" style="width:804px;overflow: scroll;">
        <header class="panel-heading" style="padding:10px 28px;">

            <span>评论及反馈<i class="fa fa-print" style="margin:0 10px;color:#03a9f4;"></i><i class="fa fa-file-text" style="color:#03a9f4;"></i></span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>
        %{--<g:hiddenField name="taskid" id="taskid" ></g:hiddenField>--}%
        %{--<g:hiddenField name="version" id="version" ></g:hiddenField>--}%
        <div class="discuss clearfix">
            <h4>反馈及评论</h4>
            <form id="form1">

                <g:hiddenField name="bpuid" id="bpuid"></g:hiddenField>
                <g:hiddenField name="bpuname" id="bpuname"></g:hiddenField>
                <g:hiddenField name="puid" id="puid" value="${session.user.id}"></g:hiddenField>
                <g:hiddenField name="puname" id="puname" value="${session.user.name}"></g:hiddenField>
                <div>
                    <textarea id="content1" name="content"></textarea>
                </div>
                <a href="javascript:;" id="submit1" class="rbtn btn-blue mt25">提交</a>
            </form>
        </div>
        <div id="reply_container">
        </div>
    </div>
</div>
<!--评论及反馈 end-->
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
    <script src="${resource(dir: 'js', file: 'jquery.form.js')}" ></script>
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

    <!--上传图片预览 js-->
    <script src="${resource(dir: 'js', file: 'uploadPreview.js')}"></script>
    <script type="text/javascript">
        window.onload = function () {
            new uploadPreview({ UpBtn: "up_img", DivShow: "imgDefault", ImgShow: "img" });
        }
    </script>
    <script>
        function del(){
            if(confirm('确定删除？')){
                alert('删除成功！');
            }else{
                return false;
            }
        }
        //阻止冒泡
        function stop_Pro(e){
            var e=e || window.event;
            if (e && e.stopPropagation) {
                //W3C取消冒泡事件
                e.stopPropagation();
            } else {
                //IE取消冒泡事件
                window.event.cancelBubble = true;
            }
        }
        $(document).ready(function() {
            //目标分解
            $(".tar_edit").click(function(){
                var tid=$(this).parent().next().val();
                $('#var_all').html(tid);
                $('#submit').attr('disabled',true);
                var html='';
                $.ajax( {
                    url:'${webRequest.baseUrl}/front/tshow',
                    method:'post',
                    dataType:'json',
                    data:{target_id:tid},
                    success:function(data){

                        var target=data.target;
                        var issubmit=(target.issubmit=='1')?'目标已下发！':'该目标未下发！';
                        var missionlist=data.mission;

                        for(var i=0;i<missionlist.length;i++){
                            var s=(missionlist[i].status=='1')?'完成':'进行中';
                            html+=' <li class="clearfix">'+
                            '<h2 style="padding:0;margin: 0 20px 0 0;font-size: 20px;color:#03a9f4" class="f-l">任务'+(i+1)+'：<span style="color:#797979;">'+missionlist[i].title+'</span></h2>'+
                            '<div class="f-l" style="font-size: 20px;margin-top:7px;">'+
                                    '<a href="javascript:;"  style="font-size:20px;margin-right:5px;"><i class="fa fa-edit mission_edit" ></i></a>'+
                                    '<span style="display:none;" class="mis_id">'+missionlist[i].id+'</span>'+
                                     '<a href="#" style="font-size:20px;" ><i class="fa fa-trash-o mission_delete"></i></a>'+
                            '</div>'+
                            '</li>'+
                            '<li class="clearfix">'+
                                    '<table class="table table-bordered f-l" style="border-spacing: 0;margin-right: 20px;width:48%">'+
                                    '<tr>'+
                                    '<th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">执行人</th>'+
                           ' <td width="75%">'+missionlist[i].playname+'</td>'+
                            '</tr>'+
                            '<tr>'+
                           ' <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务权重</th>'+
                            '<td><input  name="percent" style="border:none;width:75%" readonly value="'+missionlist[i].percent+'"/></td>'+
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
                            '<span>'+s+'</span>'+
                            '</td>'+
                            '</tr>'+
                            '</table>'+
                            '</li>';

                        }

                        $("#tar_fj ul").append(html);
                        $('#issubmit').html(issubmit);
                        if(target.issubmit=='1'){
                            $('#submit').attr('disabled',true);
                        }
                        var percents=$('#tar_fj input[name="percent"]');

                        var sum_per=0;
                        for(var i=0;i<percents.length;i++){
                            sum_per+=parseInt(percents[i].value);

                        }

                        var r_per=100-sum_per;
                        $('#r_per').html(r_per);
                        if(r_per==0){
                            $('#submit').attr('disabled',false);
                        }
                        if(target.issubmit=='1'){
                            $('#submit').attr('disabled',true);
                        }
                        editclick();
                    },error:function(){alert("获取数据失败");}});


                $("#tar_fj").css('display','block');
                return false;
                } )



            //编辑任务
           function editclick() {

                $(".mission_edit").click(function () {
//                    var p=parseInt($('#r_per').html());

                    var mid = $(this).parent().next().html();

                    $.ajax({
                        url: '${webRequest.baseUrl}/front/mshow',
                        type: 'post',
                        dataType: 'json',
                        data: {mid: mid},
                        success: function (data) {
                            var status=(data.mission.status=='1')?'已完成':'进行中';
                            var mission = data.mission;
                            var target = data.target;
                            $('#target_id_edit').val(target.id);
                            $('#mission_title_edit').val(mission.title);
                            $('#mission_content_edit').val(mission.content);
                            $('.zhxr').html(mission.playname);
                            $('#startdate_edit').val(mission.begintime);
                            $('#enddate_edit').val(mission.overtime);
                            $('#mission_percent_edit').val(mission.percent);
                            $('#mission_status_edit').find('option[value='+mission.status+']').attr('selected',true);
                            $('#mid').val(mission.id);
                            $('#mission_edit_detail').css('display', 'block');
                            p+=mission.percent;

                            $('#rp').html(p);
                            editclick();
                        },
                        error: function () {
                            alert("获取数据失败");
                        }
                    })

                })


                //提交任务更新
                $('#save_mission_edit').click(function(){

//                    var z= /^[0-9]*$/;
//                    if($('#mission_title_edit').val()==''){
//                        $('#mission_title_edit').css('border-color','red');
//                        return false;
//                    }else{
//                        $('#mission_title_edit').css('border-color','#d2d2d2');
//                    }
//                    if($('#mission_content_edit').val()==''){
//                        $('#mission_content_edit').css('border-color','red');
//                        return false;
//                    }else{
//                        $('#mission_content_edit').css('border-color','#d2d2d2');
//                    }
//                    if($('#playuid_edit').val()==''){
//                        $('#playuid_edit').css('border-color','red');
//                        return false;
//                    }else{
//                        $('#playuid_edit').css('border-color','#d2d2d2');
//                    }
//                    if($('.zhxr').html()==''){
//                        $('.zhxr').next().css('border','1px solid red');
//                        return false
//                    }else{
//                        $('.zhxr').next().css('border','none');
//                    }
//                    if($('#startdate_edit').val()==''){
//                        $('#startdate_edit').css('border-color','red');
//                        return false;
//                    }else{
//                        $('#startdate_edit').css('border-color','#d2d2d2');
//                    }
//                    if($('#enddate_edit').val()==''){
//                        $('#enddate_edit').css('border-color','red');
//                        return false;
//                    }else{
//                        $('#enddate_edit').css('border-color','#d2d2d2');
//                    }
//                    if($('#mission_percent_edit').val()==''){
//
//                        $('#mission_percent_edit').css('border','1px solid red');
//                        return false;
//                    }else if(!z.test($('#newmission_percent_edit').val())){
//                        $('#newmission_percent_edit').css('border','1px solid red');
//
//                        return false
//                    }else{
//                        $('#mission_percent_edit').css('border','none');
//                    }

                    var mid=$(this).prev().val();

                    var title=$('#mission_title_edit').val();
                    var content=$('#mission_content_edit').val();
                    var playbid=$('#playbid_edit').val();
                    var playuid=$('#playuid_edit').val();
                    var playname=$('.zhxr').html();

                    var begintime=$('#startdate_edit').val();
                    var overtime=$('#enddate_edit').val();
                    var percent=$('#mission_percent_edit').val();
                    var status=$('#mission_status_edit option:selected').val();

                    var html="";

                    $.ajax({
                        url:'${webRequest.baseUrl}/front/mupdate',
                        type: 'post',
                        dataType: 'json',
                        data: {mid: mid,title:title,content:content,playname:playname,begintime:begintime,overtime:overtime,percent:percent,status:status},
                        success: function (data) {
                             $('#tar_fj ul').empty();

                            var target=data.target;

                            var missionlist=data.mission;
                            var size= data.missionSize

                            for(var i=0;i<missionlist.length;i++){
                                var status=(missionlist[i].status=='1')?'已完成':'进行中';
                                html+=' <li class="clearfix">'+
                                        '<h2 style="padding:0;margin: 0 20px 0 0;font-size: 20px;color:#03a9f4" class="f-l">任务'+(i+1)+'：<span style="color:#797979;">'+missionlist[i].title+'</span></h2>'+
                                        '<div class="f-l on" style="font-size: 20px;margin-top:7px;">'+
                                        '<a href="javascript:;"  style="font-size:20px;margin-right:5px;"><i class="fa fa-edit mission_edit" ></i></a>'+
                                        '<span style="display:none;">'+missionlist[i].id+'</span>'+
                                        '<a href="#" style="font-size:20px;" ><i class="fa fa-trash-o mission_delete"></i></a>'+
                                        '</div>'+
                                        '</li>'+
                                        '<li class="clearfix">'+
                                        '<table class="table table-bordered f-l" style="border-spacing: 0;margin-right: 20px;width:48%">'+
                                        '<tr>'+
                                        '<th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">执行人</th>'+
                                        ' <td width="75%">'+missionlist[i].playname+'</td>'+
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
                                        '<span>'+status+'</span>'+
                                        '</td>'+
                                        '</tr>'+
                                        '</table>'+
                                        '</li>';

                            }
                            $("#tar_fj ul").append(html);
//                            var p=parseInt($('#rp').html());
//                            p-=parseInt(percent);
                            $('#r_per').html(data.r_per);
                            if($('#r_per').html()==0){
                                $('#submit').attr('disabled',false);
                            }else{
                                $('#submit').attr('disabled',true);
                            }
                            if(target.issubmit=='1'){
                                $('#submit').attr('disabled',true);
                            }
//
                            $('#mission_edit_detail').hide();
                            editclick();
                        },
                        error:function(){
                            alert("获取数据失败");
                        }
                    })

                })


                //删除任务
                $(".mission_delete").click(function () {

                    if (confirm('确定删除？')) {
                    var mid = $(this).parent().prev().html();
                    var This = $(this)
                    $.ajax({
                        url: '${webRequest.baseUrl}/front/mdelete',
                        type: 'post',
                        dataType: 'json',
                        data: {mid: mid},
                        success: function (data) {
                            if (data.msg == "删除任务成功！") {
                                alert("删除成功！");
//                                data.target.percent-=data.mission.percent;
                                var rm1 = This.parent().parent().parent();
                                var rm2 = This.parent().parent().parent().next();
                                rm1.remove();
                                rm2.remove();
                            }

                            $('#r_per').html(data.r_per);
                            if( $('#r_per').html()==0){
                                $('#submit').attr('disabled',false);
                            }else{
                                $('#submit').attr('disabled',true);
                            }

                        },
                        error: function () {
                            alert("获取数据失败");
                        }


                    })
                }else{
                        return false;
                    }

                })
            }


            //新建目标
            $("#newtarget").click(function(){
                $("#newtargetdetail").css("display","block");
            });


            //弹窗关闭按钮
            $('#mission_edit_detail .close').click(function(){
                $('.nr').val("");
                $('.con').empty();
                $("#mission_edit_detail").css('display','none');
            })
            $('#newmissiondetail .close').click(function(){
                $('.nr').val("");
                $('.con').empty();
                $("#newmissiondetail").css('display','none');
            })
            $('#tar_detail .close').click(function(){
                $("#tar_detail .rwfj").empty();
                $("#tar_detail").css("display","none");
            })
            $("#newtargetdetail .close").click(function(){
                $('.nr').val("");
                $('.con').empty();
                $("#newtargetdetail").css("display","none");


                $("#select_img").css("display","none");
            });
            $('#select_img .close').click(function(){
                location.reload();
            })
            $('#tar_fj .close').click(function(){
                $("#tar_fj").css('display','none');
                location.reload();
            })


            //日期时间选择
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


            //目标详情
            var all_tars=$(".tar_whole");

            $(".tar_whole").click(function () {
                var tar_mission='';
                var tid=$(this).find('input:first').val();
                    $.ajax({
                        url: '${webRequest.baseUrl}/front/tshow',
                        method: 'post',
                        dataType: 'json',
                        data:{target_id:tid},
                        success: function (data) {

                            $('#detail_title').html(data.target.title);
                            $('#detail_content').html(data.target.content);
                            $('#detail_fz').html(data.fzname )
                            $('#detail_btime').html ( data.target.begintime);
                            $('#detail_etime').html (data.target.etime);

                            var mission=data.mission;

                            for(var i=0;i<mission.length;i++){

                                var s=(mission[i].status=='1')?'完成':'进行中';
                                var hasvisited=(mission[i].hasvisited=='1')?'已阅读':'未读';
                                if(mission[i].hasvisited=='1'){
                                    hasvisited='已阅读';
                                }else if(mission[i].hasvisited=='0'){
                                    hasvisited='未读';
                                }else{
                                    hasvisited='接受';
                                }
                            tar_mission+='     <li class="clearfix">'+
                            ' <h2 class="clearfix" style="padding:0 20px 10px 0;margin: 0;font-size: 20px;color:#03a9f4">任务'+(i+1)+'：<span style="color:#797979;">'+mission[i].title+'</span><span style="font-size:20px;margin-left: 16px;">'+hasvisited+'</span><div class="discuss f-r comment1"><span class="id" style="display:none;">'+mission[i].id+'</span><span>反馈及评论</span></div></h2>'+

                            '<table class="table table-bordered f-l" style="border-spacing: 0;margin-right: 20px;width:48%">'+
                            '<tr>'+
                            ' <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">执行人</th>'+
                            '<td width="75%"><span>'+ mission[i].playname+'</span></td>'+
                            '</tr>'+
                            ' <tr>'+
                            ' <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务权重</th>'+
                            ' <td>'+
                            '<span>'+mission[i].percent+'</span>'+
                            ' </td>'+
                            ' </tr>'+
                            ' </table>'+
                            ' <table class="table table-bordered f-l" style="border-spacing: 0;width:49%;">'+
                            ' <tr>'+
                            '<th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;">起止日</th>'+
                            ' <td width="75%"><span>'+mission[i].begintime+'</span>—<span>'+mission[i].overtime+'</span></td>'+
                            '</tr>'+
                            ' <tr>'+
                            '<th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>'+
                            '<td>'+
                            ' <span>'+s+'</span>'+
                            '</td>'+
                            '</tr>'+
                            '</table>'+
                            '</li>';


                           }
                            $("#tar_detail .rwfj").append(tar_mission);
                            com();
                            }
                        ,error:function(){
                            alert("获取数据失败")
                        }
                    })
                            $("#tar_detail").css("display","block");
                })

            $('.menu').click(function(){
                $('.bumen').hover(function(){
                    $('#playbid').val($(this).find('span:first-child').html());
                })
                $('.user').click(function(){
                    $('#newmission_playname').val($(this).next().html());
                    $('#playname').val($(this).text());
                    $('.zhxr').html($(this).text());
                })
            })
            $('.menu1').click(function(){
                $('.bumen').hover(function(){
                    $('#playbid_edit').val($(this).find('span:first-child').html());
                })
                $('.user').click(function(){
                    $('#playuid_edit').val($(this).next().html());
                    $('#playname_edit').val($(this).text());
                    $('.zhxr').html($(this).text());
                })
            })

            //新建任务
            $("#newmission").click(function() {
                $('.nr').val('');
                $('.con').empty();
                $('#target_id').val($('#var_all').html());
                $("#newmissiondetail").css('display', 'block');
            })


            //新建任务提交
                $("#save_mission").click(function(){
                    var z= /^[0-9]*$/;
                    if($('#newmission_title').val()==''){
                        $('#newmission_title').css('border-color','red');
                        return false;
                    }else{
                        $('#newmission_title').css('border-color','#d2d2d2');
                    }
                    if($('#newmission_content').val()==''){
                        $('#newmission_content').css('border-color','red');
                        return false;
                    }else{
                        $('#newmission_content').css('border-color','#d2d2d2');
                    }
                    if($('.zhxr').html()==''){
                        $('.zhxr').next().css('border','1px solid red');
                        return false
                    }else{
                        $('.zhxr').next().css('border','none');
                    }
                    if($('#startdate_mission').val()==''){
                        $('#startdate_mission').css('border-color','red');
                        return false;
                    }else{
                        $('#startdate_mission').css('border-color','#d2d2d2');
                    }
                    if($('#enddate_mission').val()==''){
                        $('#enddate_mission').css('border-color','red');
                        return false;
                    }else{
                        $('#enddate_mission').css('border-color','#d2d2d2');
                    }
                    if($('#newmission_percent').val()==''){
                        $('#newmission_percent').css('border','1px solid red');
                        return false;
                    }else if(!z.test($('#newmission_percent').val())){
                        $('#newmission_percent').css('border','1px solid red');

                        return false
                    }else{
                        $('#newmission_percent').css('border','none');
                    }

                    $('#target_id').val($('#var_all').html());

                    var target_id=$('#target_id').val();
                    var title=$('#newmission_title').val();
                    var content=$('#newmission_content').val();
                    var playuid=$('#playuid').val();
                    var playbid=$('#playbid').val();
                    var playname=$('#playname').val();
                    var begintime=$('#startdate_mission').val();
                    var overtime=$('#enddate_mission').val();
                    var percent=$('#newmission_percent').val();
                    var status=$('#newmission_status').val();


                    $.ajax({
                        url:'${webRequest.baseUrl}/front/missionSave',
                        type:'post',
                        dataType:'json',
                        data:{target_id:target_id,title:title,content:content,playname:playname,playbid:playbid,playuid:playuid,begintime:begintime,overtime:overtime,percent:percent,status:status},
                        success:function(data){
                            var target=data.target;
                            var status=(data.mission.status=='1')?'已完成':'进行中';
                            var html=' <li class="clearfix">'+
                                    '<h2 style="padding:0;margin: 0 20px 0 0;font-size: 20px;color:#03a9f4" class="f-l">任务'+(data.target.mission.length)+'：<span style="color:#797979;">'+data.mission.title+'</span></h2>'+
                                    '<div class="f-l" style="font-size: 20px;margin-top:7px;">'+
                                    '<a href="#"  style="font-size:20px;margin-right:5px;"><i class="fa fa-edit mission_edit"></i></a>'+
                                    '<span style="display:none;">'+data.mission.id+'</span>'+
                                    '<a href="#" style="font-size:20px;"><i class="fa fa-trash-o mission_delete"></i></a>'+
                                    '</div>'+
                                    '</li>'+
                                    '<li class="clearfix">'+
                                    '<table class="table table-bordered f-l" style="border-spacing: 0;margin-right: 20px;width:48%">'+
                                    '<tr>'+
                                    '<th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">执行人</th>'+
                                    ' <td width="75%">'+data.mission.playname+'</td>'+
                                    '</tr>'+
                                    '<tr>'+
                                    ' <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务权重</th>'+
                                    '<td><input  name="fzuid" style="border:none;width:75%" value="'+data.mission.percent+'"%/></td>'+
                                    '</tr>'+
                                    '</table>'+
                                    '<table class="table table-bordered f-l" style="border-spacing: 0;width:48%;">'+
                                    ' <tr>'+
                                    '<th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;">起止日</th>'+
                                    ' <td width="75%"><span>'+data.mission. begintime+'</span>—<span>'+data.mission.overtime +'</span></td>'+

                                    ' </tr>'+
                                    ' <tr>'+
                                    ' <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>'+
                                    ' <td>'+
                                    '<span>'+status+'</span>'+
                                    '</td>'+
                                    '</tr>'+
                                    '</table>'+
                                    '</li>';

                            $("#tar_fj ul").append(html);

                            $('#r_per').html(data.r_per);
                            if($('#r_per').html()==0){
                                $('#submit').attr('disabled',false);
                            }
                            if(target.issubmit=='1'){
                                $('#submit').attr('disabled',true);
                            }
                            $("#newmissiondetail").css('display','none');
                            editclick();
                        },
                        error:function(){alert("获取数据失败")}
                    })

                });

            $('#submit').click(function(){

                var tid= $('#var_all').html();


                $.ajax({
                    url:'${webRequest.baseUrl}/front/issubmit',
                    type:'post',
                    dataType:'json',
                    data:{target_id:tid},
                    success:function(data){
                        alert("下发任务成功！");
                        location.reload();

                    },
                    error:function(){alert('获取数据失败！')}
                })
            })

            $('.select_img').click(function() {
                var tid=$(this).parent().prev().val();
                $('#all_var').html(tid);
                $.ajax({
                    url:'${webRequest.baseUrl}/front/showImg',
                    type:'post',
                    dataType:'json',
                    data:{target_id:tid},
                    success:function(data){
                        $('#img').attr('src','/guihuabao/static/img/target-img/'+data.img);
                    },
                    error:function(){
                        alert('获取数据失败！');
                    }}
                )
                $('#select_img').css('display', 'block');
                $('#select_img .ori img').click(function () {
                    var thisimg = $(this).attr('src');

                    $('#img').attr('src', thisimg);
                    $('#filename').html(thisimg);
                });


            });

            $('#upimg').click(function(){
                var target_id=$('#all_var').html();

                var imgs=$('#filename').html().split('/');
                var img=imgs[imgs.length-1];

                $.ajax({
                    url:'${webRequest.baseUrl}/front/selectImg',
                    type:'post',
                    dataType:'json',
                    data:{target_id:target_id,img:img},
                    success:function(data){
                        location.reload();

                    },
                    error:function(){alert('获取数据失败！')}
                })
            })

           $('#upload').click(function() {
               if($("#up_img").val()==""){
                   alert("请选择一个图片文件,再点击");
                   return;
               }
               $("#uploadForm").ajaxSubmit({
                   url: '${webRequest.baseUrl}/front/uploadImg',
                   type: 'POST',
                   dataType: 'json',
                   data: $('#uploadForm').serialize(),
                   beforeSubmit : function() {
                       alert("正在上传");
                   },
                   success: function (data) {
                       alert('成功上传！');

                       $('#filename').html(data.fileName);


                   },
                   error: function () {
                       alert('获取数据失败！');
                   }
               })
           })
            $('#saf').click(function(){
                if($('#tar_title').val()==''){
                    $('#tar_title').css('border-color','red');
                    return false;
                }else{
                    $('#tar_title').css('border-color','#d2d2d2');
                }
                if($('#tar_con').val()==''){
                    $('#tar_con').css('border-color','red');
                    return false;
                }else{
                    $('#tar_con').css('border-color','#d2d2d2');
                }

                if($('#startdate').val()==''){
                    $('#startdate').css('border-color','red');
                    return false;
                }else{
                    $('#startdate').css('border-color','#d2d2d2');
                }
                if($('#enddate').val()==''){
                    $('#enddate').css('border-color','red');
                    return false;
                }else{
                    $('#enddate').css('border-color','#d2d2d2');
                }
                var title=$('#tar_title').val();
                var content=$('#tar_con').val();
                var fzuid=$('#tar_fzuid').val();
                var begintime=$('#startdate').val();
                var etime=$('#enddate').val();
                $.ajax({
                    url:'${webRequest.baseUrl}/front/targetSaveAndSplit',
                    type:'post',
                    dataType:'json',
                    data:{title:title,contnet:content,fzuid:fzuid,begintime:begintime,etime:etime},
                    success:function(data){

                        $("#tar_fj").css('display','block');
                        $('#newtargetdetail').css('display','none');
                        $('#var_all').html(data.target.id);

                        $('#r_per').html(100);
                        $('#submit').attr('disabled',true);
                    },
                    error:function(){alert('获取数据失败！')}
                })
            })
            $('#save_target').click(function(){
                if($('#tar_title').val()==''){
                    $('#tar_title').css('border-color','red');
                    return false;
                }else{
                    $('#tar_title').css('border-color','#d2d2d2');
                }
                if($('#tar_con').val()==''){
                    $('#tar_con').css('border-color','red');
                    return false;
                }else{
                    $('#tar_con').css('border-color','#d2d2d2');
                }

                if($('#startdate').val()==''){
                    $('#startdate').css('border-color','red');
                    return false;
                }else{
                    $('#startdate').css('border-color','#d2d2d2');
                }
                if($('#enddate').val()==''){
                    $('#enddate').css('border-color','red');
                    return false;
                }else{
                    $('#enddate').css('border-color','#d2d2d2');
                }
            })





            //任务评论及反馈
            function com() {
                $('.comment1').click(function () {
                    var mid=$(this).find('span:first-child').html();
                    $('#all_var').html(mid);
                    $.ajax({
                        url:'${webRequest.baseUrl}/front/mcomment?mid='+mid,
                        dataType: "json",
                        type:'post',
                        success: function (data) {
                            // 去渲染界面
                            var html2="";

                            var fzuid=data.target.fzuid;

                            $('#bpuid').val(data.mission.playuid);
                            $('#bpuname').val(data.mission.playname);
                            $.each(data.replymission,function(i,val){
                                html2+='<div class="reply_box"><div class="name">'+val.puname+'&nbsp;回复&nbsp;'+val.bpuname+'</div>'
                                html2+='<p>'+val.content+'</p>'
                                html2+='<span>'+val.date+'</span><a href="javascript:;" class="reply" data-info="'+val.puid+','+val.puname+'">回复</a>'
                                html2+='<div class="shuru"><span>回复&nbsp;'+val.puname+'</span>'
                                html2+='<div class="rcontainer"></div>'
                                html2+='</div></div>'
                            })
                            $("#task .task_content").empty();
                            $("#reply_container").empty();

                            $("#reply_container").append(html2);
                            $('#task').css('display', 'block');
                            replyclick();

                        },
                        error:function() {

                            alert("信息读取失败！");

                        }

                    })
                });
                $('#task .close').click(function(){
                   $('#content1').val('');
                    $('#task').css('display','none');
                })
            }

            function replyclick() {

                $(".reply").on("click", function () {
                    var info = $(this).attr("data-info")
                    var arr = info.split(",")
                    $(".shuru .rcontainer").empty()
                    $(".shuru").hide()
                    var html2 = ""
                    html2+='<form id="form2">'
//                html2+='<input type="hidden" name="id" value="'+arr[0]+'" />'
                    html2+='<input type="hidden" name="bpuid" value="'+arr[0]+'" />'
                    html2+='<input type="hidden" name="bpuname" value="'+arr[1]+'" />'
                    html2+='<input type="hidden" name="puid" value="${session.user.id}" />'
                    html2+='<input type="hidden" name="puname" value="${session.user.name}" />'
                    html2+='<div class="mt10"><textarea name="content"></textarea></div>'
                    html2+='<a class="huifu fbtn btn-white mt10">回复</a><a class="quxiao fbtn btn-white mt10 ml20">取消</a>'
                    html2+='</form>'
                    $(this).next().find('.rcontainer').html(html2)
                    $(this).next().slideDown()
                    replysubmit();
                })

            }
            function replysubmit() {
                $(".quxiao").on("click", function () {
                    $(this).parent().parent().parent().slideUp();
                    $(".shuru .rcontainer").empty()
                })
                $(".huifu").click(function () {

                    var mid = $('#all_var').html();

                    var html2 = '';
                    $.ajax({
                        url: '${webRequest.baseUrl}/front/replyMissionSave?mid=' + mid + '',
                        dataType: "json",
                        type: "POST",
                        data: $("#form2").serialize(),
                        success: function (data) {
                            if (data.msg) {
                                var re = data.replymission;
                                alert("回复成功！");
                                html2 += '<div class="reply_box"><div class="name">' + re.puname + '&nbsp;回复&nbsp;' + re.bpuname + '</div>'
                                html2 += '<p>' + re.content + '</p>'
                                html2 += '<span>' + re.date + '</span><a href="javascript:;" class="reply" data-info="' + re.puid + ',' + re.puname + '">回复</a>'
                                html2 += '<div class="shuru"><span>回复&nbsp;' + re.puname + '</span>'
                                html2 += '<div class="rcontainer"></div>'
                                html2 += '</div></div>'
                                $("#reply_container").prepend(html2);
                                $('.shuru').slideUp()
                            } else {
                                alert("回复失败！")
                            }
                            replyclick();
                        }
                    })
                })
            }
            $("#submit1").click(function(){
                var mid=$('#all_var').html();
                var html2='';
                $.ajax({
                    url: '${webRequest.baseUrl}/front/replyMissionSave?mid='+mid+'',
                    dataType: "json",
                    type: "POST",
                    data: $("#form1").serialize(),
                    success: function(data) {
                        if(data.msg){
                            var re=data.replymission;
                            alert("回复成功！");
                            html2+='<div class="reply_box"><div class="name">'+re.puname+'&nbsp;回复&nbsp;'+re.bpuname+'</div>'
                            html2+='<p>'+re.content+'</p>'
                            html2+='<span>'+re.date+'</span><a href="javascript:;" class="reply" data-info="'+re.puid+','+re.puname+'">回复</a>'
                            html2+='<div class="shuru"><span>回复&nbsp;'+re.puname+'</span>'
                            html2+='<div class="rcontainer"></div>'
                            html2+='</div></div>'
                            $('#content1').val('');
                            $("#reply_container").prepend(html2);
                        }else{
                            alert("回复失败！")
                        }
                        replyclick();
                    }
                })
            })
            })


    </script>

</body>
</html>