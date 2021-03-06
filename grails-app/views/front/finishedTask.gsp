


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
                        <span>已完成任务</span>
                    </div>
                    <div class="e-list-group tomorrow">
                        <ul class="e-list">
                            <g:each in="${finishedTaskInstance}" status="i" var="finishedTaskInfo">
                                <li data-task-id="${finishedTaskInfo.id}" data-task-version="${finishedTaskInfo.version}" data-task-fzuid="${finishedTaskInfo.fzuid}" data-task-fzname="${finishedTaskInfo.fzname}">
                                    <span class="mark <g:if test="${finishedTaskInfo.playstatus=='1'}">mark-danger</g:if><g:if test="${finishedTaskInfo.playstatus=='2'}">mark-warning</g:if><g:if test="${finishedTaskInfo.playstatus=='3'}">mark-safe</g:if><g:if test="${finishedTaskInfo.playstatus=='4'}">mark-nomarl</g:if>"><i></i></span>
                                    <span class="sn">${i+1}</span>
                                    <span class="title">${finishedTaskInfo.title}</span>
                                    <div class="right">
                                        <span class="del"><a href="javascript:;" class="taskdelete" onclick="confirm('确定删除？');stop_Pro(event)" data-id="${finishedTaskInfo.id}"><i class="fa fa-trash-o"></i>删除任务</a></span>
                                        <span class="date f-r">${finishedTaskInfo.overtime}</span>
                                    </div>
                                </li>
                            </g:each>
                        </ul>
                    </div>
                </div>
                %{--<div class="col-cell" style="width:340px;">--}%

                %{--</div>--}%
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

<!--详情滑动框-->
<script src="${resource(dir: 'js', file: 'slidelefthideshow.js')}"></script>
<script type="text/javascript">
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
        $(".taskclose").click(function(){
            $("#task").slideLeftHide(400);
            $("#task .task_content").empty();
        });
    })
</script>
</body>
</html>