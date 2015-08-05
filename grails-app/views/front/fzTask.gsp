


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
    <!--header end-->
    <!--sidebar start-->
    <g:render template="tasksiderbar" />
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content">
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
                                    <li>
                                        <span class="mark <g:if test="${fzAllTaskInfo.playstatus=='1'}">mark-danger</g:if><g:if test="${fzAllTaskInfo.playstatus=='2'}">mark-warning</g:if><g:if test="${fzAllTaskInfo.playstatus=='3'}">mark-safe</g:if><g:if test="${fzAllTaskInfo.playstatus=='4'}">mark-nomarl</g:if>"><i></i></span>
                                        <span class="sn">${i+1}</span>
                                        <span class="title" data-task-id="${fzAllTaskInfo.id}">${fzAllTaskInfo.title}</span>
                                        <div class="right">
                                            %{--<span class="hsfinish"><g:link action="taskUpdate" id="${fzAllTaskInfo.id}" params="[version: fzAllTaskInfo.version]"><i class="fa <g:if test="${fzAllTaskInfo.status=="1"}">fa-check-square-o</g:if><g:else>fa-square-o</g:else>"></i>标记完成</g:link></span>--}%
                                            %{--<g:if test="${fzAllTaskInfo.fzuid.toInteger()==session.user.id}"><span class="del"><g:link action="taskDelete"  id="${fzAllTaskInfo.id}"><i class="fa fa-trash-o"></i>删除任务</g:link></span></g:if>--}%
                                            <span class="hsfinish"><a href="javascript:;" class="taskedit" data-id="${fzAllTaskInfo.id}" data-version="${fzAllTaskInfo.version}"><i class="fa <g:if test="${fzAllTaskInfo.status=="1"}">fa-check-square-o</g:if><g:else>fa-square-o</g:else>"></i>标记完成</a></span>
                                            <g:if test="${fzAllTaskInfo.fzuid.toInteger()==session.user.id}"><span class="del"><a href="javascript:;" class="taskdelete" data-id="${fzAllTaskInfo.id}" data-version="${fzAllTaskInfo.version}"><i class="fa fa-trash-o"></i>删除任务</a></span></g:if>
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
        $(".e-list-group .e-list .title").click(function(){
            var taskid = $(this).attr("data-task-id");
            $.ajax({
                url:'${webRequest.baseUrl}/front/taskShow?id='+taskid,
                dataType: "jsonp",
                jsonp: "callback",
                success: function (data) {
                    // 去渲染界面
                    if(data.msg){
                        var html="";
                        var playstatus
                        var status = (data.taskInfo.status)?"已完成":"未完成";
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
                        html+='<div class="task_line"><span>起始日：</span><span>'+data.taskInfo.overtime+'</span></div>';
                        html+='<div class="task_line"><span>紧急程度：</span><span class="font_blue">'+playstatus+'</span></div>';
                        html+='<div class="task_line"><span>任务状态：</span><span class="font_blue">'+status+'</span></div>';
                        $("#task .task_content").empty();
                        $("#task .task_content").append(html);
                        $("#task").slideLeftShow(400);
                    }else{
                        alert("信息读取失败！");
                    }
                }
            })
        });
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
        $(".taskclose").click(function(){
            $("#task").slideLeftHide(400);
            $("#task .task_content").empty();
        });
    })
</script>
</body>
</html>