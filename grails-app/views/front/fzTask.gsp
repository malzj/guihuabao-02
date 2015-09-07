


<html>
<head>
    <title>规划宝后台管理系统</title>

    <!-- Bootstrap core CSS -->
    <link href="${resource(dir: 'css', file: 'bootstrap.min.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'bootstrap-reset.css')}" rel="stylesheet">
    <!--external css-->
    <link href="${resource(dir: 'assets/font-awesome/css', file: 'font-awesome.css')}" rel="stylesheet">

    <link rel="stylesheet" type="text/css" href="${resource(dir: 'assets/bootstrap-fileupload', file: 'bootstrap-fileupload.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'assets/bootstrap-wysihtml5', file: 'bootstrap-wysihtml5.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'assets/bootstrap-colorpicker/css', file: 'colorpicker.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'assets/bootstrap-daterangepicker', file: 'daterangepicker-bs3.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'assets/bootstrap-datetimepicker/css', file: 'datetimepicker.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'assets/bootstrap-datepicker/css', file: 'datepicker.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'assets/bootstrap-timepicker/compiled', file: 'timepicker.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'assets/jquery-multi-select/css', file: 'multi-select.css')}" />

    <!--right slidebar-->
    <link href="${resource(dir: 'css', file: 'slidebars.css')}" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="${resource(dir: 'css', file: 'style.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'style-responsive.css')}" rel="stylesheet">

    <link href="${resource(dir: 'css', file: 'context.standalone.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'ownset.css')}" rel="stylesheet">
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
    <g:render template="tasksiderbar" />
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content" class="col-xs-10" style="padding-left: 0;">
        <section class="wrapper">
            <div class="col-tb">
                <div class="col-cell">
                    <div class="toolkit">
                        <span>负责的任务</span>
                        <div class="shaixuan">
                            <a class="task-order">筛选<i class="fa fa-caret-down"></i></a>
                            <ul>
                                <li>
                                    <g:link action="fzTask">全部</g:link>
                                </li>
                                <li>
                                    <g:link action="fzTask" params="[selected: 1]">已完成</g:link>
                                </li>
                                <li>
                                    <g:link action="fzTask" params="[selected: 2]">未完成</g:link>
                                </li>
                                <li>
                                    <g:link action="fzTask" params="[selected: 3]">延期任务</g:link>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="e-list-group">
                        <ul class="e-list">
                            <g:if test="${fzTaskInstance}">
                                <g:each in="${fzTaskInstance}" status="i" var="fzAllTaskInfo">
                                    <li data-task-id="${fzAllTaskInfo.id}" data-task-version="${fzAllTaskInfo.version}" data-task-fzuid="${fzAllTaskInfo.fzuid}" data-task-fzname="${fzAllTaskInfo.fzname}"  onclick="stop_Pro(event)">
                                        <span class="mark <g:if test="${fzAllTaskInfo.playstatus=='1'}">mark-danger</g:if><g:if test="${fzAllTaskInfo.playstatus=='2'}">mark-warning</g:if><g:if test="${fzAllTaskInfo.playstatus=='3'}">mark-safe</g:if><g:if test="${fzAllTaskInfo.playstatus=='4'}">mark-nomarl</g:if>"><i></i></span>
                                        <span class="sn">${i+1}</span>
                                        <span class="title">${fzAllTaskInfo.title}</span>
                                        <span class="status">
                                            下属任务状态：
                                            <g:if test="${fzAllTaskInfo.lookstatus=="0"}">未查看</g:if>
                                            <g:elseif test="${fzAllTaskInfo.lookstatus=="1"}">已查看</g:elseif>
                                            <g:elseif test="${fzAllTaskInfo.lookstatus=="2"}">
                                                <g:if test="${fzAllTaskInfo.status=="0"}">未完成</g:if>
                                                <g:elseif test="${fzAllTaskInfo.status=="1"}">已完成</g:elseif>
                                            </g:elseif>
                                        </span>
                                        <div class="right">
                                            %{--<span class="hsfinish"><g:link action="taskUpdate" id="${fzAllTaskInfo.id}" params="[version: fzAllTaskInfo.version]"><i class="fa <g:if test="${fzAllTaskInfo.status=="1"}">fa-check-square-o</g:if><g:else>fa-square-o</g:else>"></i>标记完成</g:link></span>--}%
                                            %{--<g:if test="${fzAllTaskInfo.fzuid.toInteger()==session.user.id}"><span class="del"><g:link action="taskDelete"  id="${fzAllTaskInfo.id}"><i class="fa fa-trash-o"></i>删除任务</g:link></span></g:if>--}%

                                            <g:if test="${fzAllTaskInfo.fzuid.toInteger()==session.user.id}">
                                                <g:if test="${fzAllTaskInfo.lookstatus.toInteger()!=2}"><span class="edit"><a href="javascript:;" class="taskxg" onclick="stop_Pro(event)"><i class="fa fa-pencil"></i>修改任务</a></span>
                                                <span class="del"><a href="javascript:;" onclick="confirm('确定删除？');stop_Pro(event)" class="taskdelete" data-id="${fzAllTaskInfo.id}" data-version="${fzAllTaskInfo.version}"><i class="fa fa-trash-o"></i>删除任务</a></span>
                                                </g:if>
                                            </g:if>
                                            <span class="date f-r">${fzAllTaskInfo.overtime}</span>
                                        </div>
                                    </li>
                                </g:each>

                            </g:if>
                            <g:else>
                                <li><span class="mark"></span>没有任务！</li>
                            </g:else>
                        </ul>
                    </div>
                    <div class="pagination">
                        <g:paginate total="${fzTaskInstanceTotal}" params="[selected: selected]" />
                    </div>
                </div>
                <div class="col-cell bfb" style="width:340px;">
                    <div class="count">
                        <div class="bfb_hearder">
                            负责任务统计
                        </div>
                        <canvas style="width: 340px; height: 255px;" id="doughnut" height="255" width="340"></canvas>
                        <div class="bfb_fl"></div>
                    </div>
                </div>
            </div>
            <!--任务详情 start-->
            <div id="task" style="display: none">
                <div class="task_hearder">
                    <div class="task_hearder_title">
                        <span><i class="yh"></i>任务详情</span>
                        <div class="taskclose"><a href="javascript:;" class="fa fa-times"></a></div>
                    </div>
                    <a class="print_icon"></a>
                    <a class="copy_icon"></a>
                </div>
                <div class="task_content">
                </div>
                <g:hiddenField name="taskid" id="taskid" ></g:hiddenField>
                <g:hiddenField name="version" id="version" ></g:hiddenField>
                <button id="taskedi" class="rbtn btn-blue ml25 mt10" style="display: none;">修改任务</button>
                <div class="discuss clearfix">
                    <h4>反馈及评论</h4>
                    <form id="form1">
                        <g:hiddenField name="id" id="id"></g:hiddenField>
                        <g:hiddenField name="bpuid" id="bpuid"></g:hiddenField>
                        <g:hiddenField name="bpuname" id="bpuname"></g:hiddenField>
                        <g:hiddenField name="puid" id="puid" value="${session.user.id}"></g:hiddenField>
                        <g:hiddenField name="puname" id="puname" value="${session.user.name}"></g:hiddenField>
                        <div>
                            <textarea id="content" name="content"></textarea>
                        </div>
                        <a href="javascript:;" id="submit" class="rbtn btn-blue mt25">提交</a>
                    </form>
                </div>
                <div id="reply_container">
                </div>
            </div>
            <!--任务详情 end-->
            <!--弹层 start-->
            <div class="popup_box">
                <div class="m_box">
                    <header class="panel-heading">
                        <span>修改任务</span>
                        <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
                    </header>
                    <g:form id="taskcreate" name="taskcreate" url="[controller:'front',action:'taskInfoUpdate']">
                        <input type="hidden" id="taid" name="id" value="" />
                        <input type="hidden" id="tversion" name="version" value="" />
                        <div class="r-title">
                            <div class="r-title-con f-l">任务</div>
                            <div class="r-title-jinji f-l">
                                <i></i><span class="r-chd">紧急程度</span>
                                <input type="hidden" id="playstatus" name="playstatus" />
                                <ul class="r-jinji-down">
                                    <li><a data-playstatus="1"><i class="clock-red"></i>紧急且重要</a></li>
                                    <li><a data-playstatus="2"><i class="clock-yellow"></i>紧急不重要</a></li>
                                    <li><a data-playstatus="3"><i class="clock-green"></i>重要不紧急</a></li>
                                    <li><a data-playstatus="4"><i class="clock-blue"></i>不重要不紧急</a></li>
                                </ul>
                            </div>
                            <span id="taskcreate-playstatus" style="color: red;position: absolute;left:250px"></span>
                        </div>
                        <div class="control-group">
                            <input type="text" placeholder="一句话描述任务" class="size" name="title" /><span id="taskcreate-title" style="color: red"></span>
                        </div>
                        <div class="control-group">
                            <input type="text" placeholder="添加任务详情" class="size" name="content" /><span id="taskcreate-content" style="color: red"></span>
                        </div>
                        <div class="control-group">
                            <table>
                                <tr>
                                    <td>负责人</td>
                                    <td>
                                        ${session.user.name}
                                        <g:hiddenField name="fzuid" value="${session.user.id}" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>执行人</td>
                                    <td>
                                        <input type="hidden" id="playuid" name="playuid" value="" />
                                        <input type="hidden" id="playbid" name="playbid" value="" />
                                        <input type="hidden" id="playname" name="playname" value="" />
                                        <div id="zhxr">
                                            <a id="playman"></a>
                                            <span id="cnplayname"></span>
                                            <span id="taskcreate-playuid" style="color: red"></span>
                                        </div>

                                    </td>
                                </tr>
                                <tr>
                                    <td>起止日期</td>
                                    <td><input id="startdate" name="bigentime" value="" readonly="" type="text">-<input id="enddate" name="overtime" value="" readonly="" type="text"><span id="taskcreate-bigentime" style="color: red"></span><span class="taskcreate-overtime" style="color: red"></span></td>
                                </tr>
                            </table>
                        </div>
                        <div class="control-group">
                            <button type="submit" class="btn btn-info f-r">提交</button>
                        </div>
                    </g:form>
                </div>
            </div>
            <!--任务详情 start-->
        </section>
    </section>
    <!--main content end-->

</section>

<!-- js placed at the end of the document so the pages load faster -->
<script src="${resource(dir: 'js', file: 'jquery.js')}"></script>
<script src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script class="include" type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dcjqaccordion.2.7.js')}"></script>
<script src="${resource(dir: 'js', file: 'jquery.scrollTo.min.js')}"></script>
<script src="${resource(dir: 'js', file: 'jquery.nicescroll.js')}" type="text/javascript"></script>
<script src="${resource(dir: 'js', file: 'respond.min.js')}" ></script>

<!--this page plugins-->
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

<!--right slidebar-->
<script src="${resource(dir: 'js', file: 'slidebars.min.js')}"></script>

<!--common script for all pages-->
<script src="${resource(dir: 'js', file: 'common-scripts.js')}"></script>

<!--菜单js-->
<script src="${resource(dir: 'js', file: 'context.js')}"></script>

<!--this page  script only-->
<script src="${resource(dir: 'js', file: 'advanced-form-components.js')}"></script>

<!--百分比图-->
<script src="${resource(dir: 'assets/chart-master', file: 'Chart.js')}"></script>
<!--    <script src="js/all-chartjs.js"></script>-->
<!--详情滑动框-->
<script src="${resource(dir: 'js', file: 'slidelefthideshow.js')}"></script>

<script type="text/javascript">
    var Script = function () {
        var doughnutData = [
            {
                value: ${infos.yq},//延期任务
                color:"#FF7F50"
            },
            {
                value: ${infos.unfinished},//未完成数
                color:"#87CEFA"
            },
            {
                value : ${infos.finished},//已完成数
                color : "#32CD32"
            }
        ];
        new Chart(document.getElementById("doughnut").getContext("2d")).Doughnut(doughnutData);
    }();
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
    $(function(){
        $("#addrenwu").click(function(){
            $(".popup_box").css("display","block");
        });
        $(".close").click(function(){
            $(".popup_box").css("display","none");
        });
        $(".popup_box .r-jinji-down a").click(function(){
            var playstatus=$(this).attr("data-playstatus");
            $("#playstatus").val(playstatus);
        })
        $(".toolkit .task-order").click(function () {
            var ul = $(".toolkit .shaixuan ul");

            if (ul.css("display") == "none") {
                ul.slideDown("fast");
                $(".toolkit .task-order").css("border-bottom","1px solid #fff");
            } else {
                ul.slideUp("fast");
                $(".toolkit .task-order").css("border-bottom","none");
            }
        });

        //详情滑动框
        $(".e-list-group .e-list li").click(function(){
            var taskid = $(this).attr("data-task-id");
            var version = $(this).attr("data-task-version");
            var fzuid = $(this).attr("data-task-fzuid");
            var fzname = $(this).attr("data-task-fzname");
            $("#taskid").val(taskid);
            $("#version").val(version);
            $("#id").val(taskid);
            $("#bpuid").val(fzuid);
            $("#bpuname").val(fzname);
            $("#taskedi").hide();
            $.ajax({
                url:'${webRequest.baseUrl}/front/taskShow?id='+taskid+'&version='+version,
                dataType: "jsonp",
                jsonp: "callback",
                success: function (data) {
                    // 去渲染界面
                    if(data.msg){
                        var html="";
                        var html2="";
                        var playstatus
                        var status = (data.taskInfo.status=="1")?"已完成":"未完成";
                        if(data.taskInfo.playstatus==1){
                            playstatus="紧急且重要";
                        }else if(data.taskInfo.playstatus==2){
                            playstatus=" 紧急不重要";
                        }else if(data.taskInfo.playstatus==3){
                            playstatus=" 重要不紧急";
                        }else if(data.taskInfo.playstatus==4){
                            playstatus=" 不重要不紧急";
                        }
                        html+='<div class="task_line"><span class="title">'+data.taskInfo.title+'</span></div>';
                        html+='<div class="task_line"><span class="content">'+data.taskInfo.content+'</span></div>';
                        html+='<div class="task_line"><span>指派人：</span><span class="font_blue">'+data.taskInfo.fzname+'</span></div>';
                        html+='<div class="task_line"><span>执行人：</span><span class="font_blue">'+data.taskInfo.playname+'</span></div>';
                        html+='<div class="task_line"><span>起始日：</span><span>'+data.taskInfo.bigentime+'</span></div>';
                        html+='<div class="task_line"><span>结束日：</span><span>'+data.taskInfo.overtime+'</span></div>';
                        html+='<div class="task_line"><span>紧急程度：</span><span class="font_blue">'+playstatus+'</span></div>';
                        html+='<div class="task_line"><span>任务状态：</span><span class="font_blue">'+status+'</span></div>';

                        $.each(data.replyTask,function(i,val){
                            html2+='<div class="reply_box"><div class="name">'+val.puname+'&nbsp;回复&nbsp;'+val.bpuname+'</div>'
                            html2+='<p>'+val.content+'</p>'
                            html2+='<span>'+val.date+'</span><a href="javascript:;" class="reply" data-info="'+taskid+','+val.puid+','+val.puname+'">回复</a>'
                            html2+='<div class="shuru"><span>回复&nbsp;'+val.puname+'</span>'
                            html2+='<div class="rcontainer"></div>'
                            html2+='</div></div>'
                        })
                        if(data.taskInfo.lookstatus != 2){
                            $("#taskedi").show();
                        }
                        $("#task .task_content").empty();
                        $("#reply_container").empty();
                        $("#task .task_content").append(html);
                        $("#reply_container").append(html2);
                        replyclick();

                        $("#task").slideLeftShow(400);
                    }else{
                        alert("信息读取失败！");
                    }
                }
            })
        });

        function replyclick() {

            $(".reply").on("click", function () {
                var info = $(this).attr("data-info")
                var arr = info.split(",")
                $(".shuru .rcontainer").empty()
                $(".shuru").hide()
                var html2 = ""
                html2+='<form id="form2">'
                html2+='<input type="hidden" name="id" value="'+arr[0]+'" />'
                html2+='<input type="hidden" name="bpuid" value="'+arr[1]+'" />'
                html2+='<input type="hidden" name="bpuname" value="'+arr[2]+'" />'
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

        function replysubmit(){
            $(".quxiao").on("click",function(){
                $(this).parent().parent().parent().slideUp();
                $(".shuru .rcontainer").empty()
            })
            $(".huifu").click(function(){
                $.ajax({
                    url: '${webRequest.baseUrl}/front/replyTaskSave',
                    dataType: "jsonp",
                    jsonp: "callback",
                    type: "POST",
                    data: $("#form2").serialize(),
                    success: function(data) {
                        if(data.msg){
                            alert("回复成功！")
                        }else{
                            alert("回复失败！")
                        }
                    }
                })
            })
        }

        $("#submit").click(function(){
            $.ajax({
                url: '${webRequest.baseUrl}/front/replyTaskSave',
                dataType: "jsonp",
                jsonp: "callback",
                type: "POST",
                data: $("#form1").serialize(),
                success: function(data) {
                    if(data.msg){
                        alert("回复成功！")
                    }else{
                        alert("回复失败！")
                    }
                }
            })
        })
        $(".taskedit").click(function(){
            var id=$(this).attr("data-id");
            var version=$(this).attr("data-version");
            $.ajax({
                url:'${webRequest.baseUrl}/front/taskUpdate?id='+id+'&version='+version,
                dataType: "jsonp",
                jsonp: "callback",
                success: function(data){
                    if(data.msg){
                        alert("标记成功!")
                        window.location.reload()
                    }else{
                        alert("标记失败!")
                    }
                }
            })
        })

        $(".taskdelete").click(function(){
            var id=$(this).attr("data-id");
            var version=$(this).attr("data-version");
            $.ajax({
                url:'${webRequest.baseUrl}/front/taskDelete?id='+id,
                dataType: "jsonp",
                jsonp: "callback",
                success: function(data){
                    if(data.msg){
                        alert("删除成功!")
                        window.location.reload()
                    }else{
                        alert("删除失败!")
                    }
                }
            })
        })
        //任务修改
        $(".taskxg").click(function(){
            var taskid = $(this).parent().parent().parent().attr("data-task-id");
            var version = $(this).parent().parent().parent().attr("data-task-version");
            $.ajax({
                url:'${webRequest.baseUrl}/front/taskShow?id='+taskid+'&version='+version,
                dataType: "jsonp",
                jsonp: "callback",
                success: function (data) {
                    // 去渲染界面
                    if(data.msg){
                        var playstatus
                        var pstatus
                        var status = (data.taskInfo.status=="1")?"已完成":"未完成";
                        if(data.taskInfo.playstatus==1){
                            playstatus="紧急且重要";
                            pstatus="clock-red"
                        }else if(data.taskInfo.playstatus==2){
                            playstatus=" 紧急不重要";
                            pstatus="clock-yellow"
                        }else if(data.taskInfo.playstatus==3){
                            playstatus=" 重要不紧急";
                            pstatus="clock-green"
                        }else if(data.taskInfo.playstatus==4){
                            playstatus=" 不重要不紧急";
                            pstatus="clock-blue"
                        }
                        $(".popup_box .r-title-jinji>i").addClass(pstatus);
                        $(".popup_box .r-title-jinji .r-chd").html(playstatus);
                        $("input[name=title]").val(data.taskInfo.title);
                        $("input[name=content]").val(data.taskInfo.content);
                        $("#taid").val(taskid);
                        $("#tversion").val(version);
                        $("#playstatus").val(data.taskInfo.playstatus);
                        $("#playuid").val(data.taskInfo.playuid);
                        $("#playbid").val(data.taskInfo.playbid);
                        $("#playname").val(data.taskInfo.playname);
                        $("#startdate").val(data.taskInfo.bigentime);
                        $("#enddate").val(data.taskInfo.overtime+" "+data.taskInfo.overhour);
                        $("#cnplayname").html(data.taskInfo.playname);

                    }else{
                        alert("信息读取失败！");
                    }
                }
            })
            $(".popup_box").css("display","block");
        });
        $("#taskedi").click(function(){
            var taskid = $("#taskid").val();
            var version = $("#version").val();
            $.ajax({
                url:'${webRequest.baseUrl}/front/taskShow?id='+taskid+'&version='+version,
                dataType: "jsonp",
                jsonp: "callback",
                success: function (data) {
                    // 去渲染界面
                    if(data.msg){
                        var playstatus
                        var pstatus
                        var status = (data.taskInfo.status=="1")?"已完成":"未完成";
                        if(data.taskInfo.playstatus==1){
                            playstatus="紧急且重要";
                            pstatus="clock-red"
                        }else if(data.taskInfo.playstatus==2){
                            playstatus=" 紧急不重要";
                            pstatus="clock-yellow"
                        }else if(data.taskInfo.playstatus==3){
                            playstatus=" 重要不紧急";
                            pstatus="clock-green"
                        }else if(data.taskInfo.playstatus==4){
                            playstatus=" 不重要不紧急";
                            pstatus="clock-blue"
                        }
                        $(".popup_box .r-title-jinji>i").addClass(pstatus);
                        $(".popup_box .r-title-jinji .r-chd").html(playstatus);
                        $("input[name=title]").val(data.taskInfo.title);
                        $("input[name=content]").val(data.taskInfo.content);
                        $("#taid").val(taskid);
                        $("#tversion").val(version);
                        $("#playstatus").val(data.taskInfo.playstatus);
                        $("#playuid").val(data.taskInfo.playuid);
                        $("#playbid").val(data.taskInfo.playbid);
                        $("#playname").val(data.taskInfo.playname);
                        $("#startdate").val(data.taskInfo.bigentime);
                        $("#enddate").val(data.taskInfo.overtime+" "+data.taskInfo.overhour);
                        $("#cnplayname").html(data.taskInfo.playname);

                    }else{
                        alert("信息读取失败！");
                    }
                }
            })
            $(".popup_box").css("display","block");
        });

        $(".popup_box .r-jinji-down a").click(function(){
            var playstatus=$(this).attr("data-playstatus");
            var playstatuscn=$(this).html();
            var status
            $("#playstatus").val(playstatus);
            if(playstatus==1){
                status="clock-red"
            }else if(playstatus==2){
                status="clock-yellow"
            }else if(playstatus==3){
                status="clock-green"
            }else if(playstatus==4){
                status="clock-blue"
            }
            $(".popup_box .r-title-jinji>i").removeClass();
            $(".popup_box .r-title-jinji>i").addClass(status);
            $(".popup_box .r-title-jinji .r-chd").html(playstatuscn);
            $(".popup_box .r-title-jinji").removeClass("active");
        });

        $(".close").click(function(){
            $(".popup_box").css("display","none");
        });
        context.init({preventDoubleContext: false});
        <g:if test="${session.user.pid==1}">
        context.attach('#playman', [
            {header: '部门'},
            <g:each in="${bumenInstance}" var="bumenInfo">
            {text: '${bumenInfo.name}', subMenu: [
                {header: '员工'},
                <g:each in="${com.guihuabao.CompanyUser.findAllByCidAndBid(session.company.id,bumenInfo.id)}" var="userInfo">
                {text: '${userInfo.name}', href: '#', action: function(e){
                    $("#playuid").val(${userInfo.id});
                    $("#playbid").val(${userInfo.bid});
                    $("#playname").val("${userInfo.name}");
                    $(".dropdown-menu").hide();
                    $("#cnplayname").html('${userInfo.name}');
                }},
                </g:each>
            ]},
            </g:each>
        ]);
        </g:if>
        <g:elseif test="${session.user.pid==2}">
        context.attach('#playman', [
            {header: '员工'},
            <g:each in="${com.guihuabao.CompanyUser.findAllByCidAndBid(session.company.id,session.user.bid)}" var="userInfo">
            {text: '${userInfo.name}', href: '#', action: function(e){
                $("#playuid").val(${userInfo.id});
                $("#playbid").val(${userInfo.bid});
                $("#playname").val("${userInfo.name}");
                $(this).hide();
                $("#cnplayname").html("${userInfo.name}");
            }},
            </g:each>
        ]);
        </g:elseif>
        <g:else>
        $("#playuid").val(${session.user.id});
        $("#playbid").val(${session.user.bid});
        $("#playname").val("${session.user.name}");
        $("#cnplayname").html("${session.user.name}");
        </g:else>
        $(".popup_box .r-title-jinji").mouseenter(function(){
            $(this).addClass("active");
        }).mouseleave(function(){
            $(this).removeClass("active");
        })
        $(".taskclose").click(function(){
            $("#task").slideLeftHide(400);
            $("#task .task_content").empty();
        });
    })
</script>
</body>
</html>