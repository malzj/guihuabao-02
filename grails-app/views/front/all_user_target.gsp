
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
    #select_img img{margin-right:40px;margin-bottom:40px;}
    #select_img a{cursor:pointer;}
    #select_img .upload{margin-left:20px;line-height:44px;}
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
                                    <g:link action="all_user_target" params="[selected: 1]">按目标到期时间</g:link>
                                </li>
                                <li>
                                    <g:link action="all_user_target" params="[selected: 2]">按目标创建时间</g:link>

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
                                        <a class="select_img" onclick="stop_Pro(event)"><img class="f-l" src="${resource(dir:'img/target-img',file:'1.png')}" title="更换图片"/></a>
                                        <div class="f-l" style="margin-left:10px;">

                                            <h2 style="font-size:20px;margin:4px;color:#40bdf5;">${targetInfo.title}</h2>
                                            负责人：<span>${com.guihuabao.CompanyUser.findByIdAndCid(targetInfo.fzuid,session.company.id).name}</span>
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
</div>
<!--目标详情 start-->
<div class="passwordedit" id="tar_detail" style="position:absolute;overflow: scroll;">
    <div class="m_box" style="width:804px;overflow: scroll;">
        <header class="panel-heading" style="padding:10px 28px;">
            <span>目标详情<i class="fa fa-print" style="margin:0 10px;color:#03a9f4;"></i><i class="fa fa-file-text" style="color:#03a9f4;"></i></span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>

        <ul id="all">

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
            <textarea name="content" rows="4" readonly style="width:100%;height:68px;resize: none;"  id="target_zj"></textarea>
        </ul>

    </div>
</div>
<!--目标详情 end-->

<!-- js placed at the end of the document so the pages load faster -->
<script src="${resource(dir: 'js', file: 'jquery.js')}"></script>
<script src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>



<script>
    $(document).ready(function() {

        //目标详情
        var all_tars = $(".tar_whole");

        $(".tar_whole").click(function () {

            var tar_mission = '';
            var tid = $(this).find('input:first').val();
            $.ajax({
                url: '${webRequest.baseUrl}/front/tshow',
                method: 'post',
                dataType: 'json',
                data: {target_id: tid},
                success: function (data) {

                    $('#detail_title').html(data.target.title);
                    $('#detail_content').html(data.target.content);
                    $('#detail_fz').html(data.fzname)
                    $('#detail_btime').html(data.target.begintime);
                    $('#detail_etime').html(data.target.etime);
                    $('#target_zj').html(data.target.targetzj);
                    var mission = data.mission;
                    var target=data.target;
                    for (var i = 0; i < mission.length; i++) {

                        var s = (mission[i].status == '1') ? '完成' : '进行中';
                        tar_mission += '     <li class="clearfix">' +
                                ' <h2 style="padding:0 20px 10px 0;margin: 0;font-size: 20px;color:#03a9f4">任务' + (i + 1) + '：<span style="color:#797979;">' + mission[i].title + '</span></h2>' +

                                '<table class="table table-bordered f-l" style="border-spacing: 0;margin-right: 20px;width:48%">' +
                                '<tr>' +
                                ' <th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal">执行人</th>' +
                                '<td width="75%"><span>' + mission[i].playname + '</span></td>' +
                                '</tr>' +
                                ' <tr>' +
                                ' <th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务权重</th>' +
                                ' <td>' +
                                '<span>' + mission[i].percent + '</span>' +
                                ' </td>' +
                                ' </tr>' +
                                ' </table>' +
                                ' <table class="table table-bordered f-l" style="border-spacing: 0;width:49%;">' +
                                ' <tr>' +
                                '<th style="text-align: center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;">起止日</th>' +
                                ' <td width="75%"><span>' + mission[i].begintime + '</span>—<span>' + mission[i].overtime + '</span></td>' +
                                '</tr>' +
                                ' <tr>' +
                                '<th style="text-align:center;width:25%;background:#f8f8f8;font-size:16px;font-weight: normal;" >任务状态</th>' +
                                '<td>' +
                                ' <span>' + s + '</span>' +
                                '</td>' +
                                '</tr>' +
                                '</table>' +
                                '</li>';

                    }
                    $("#tar_detail .rwfj").append(tar_mission);

                }, error: function () {
                    alert("获取数据失败5")
                }
            })
            $("#tar_detail").css("display", "block");
        })
        $('#tar_detail .close').click(function(){
            $("#tar_detail .rwfj").empty();
            $("#tar_detail").css("display","none");
        })
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
    })
</script>
</body>
</html>