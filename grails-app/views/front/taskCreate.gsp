


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
                        <span>我的任务</span>
                        <div class="shaixuan">
                            <a class="task-order">排序<i class="fa fa-caret-down"></i></a>
                            <ul>
                                <li>
                                    <g:link action="taskCreate" params="[selected: 1]">默认</g:link>
                                </li>
                                <li>
                                    <g:link action="taskCreate" params="[selected: 2]">按任务到期时间</g:link>
                                </li>
                                <li>
                                    <g:link action="taskCreate" params="[selected: 3]">按任务创建时间</g:link>
                                </li>
                                <li>
                                    <g:link action="taskCreate" params="[selected: 4]">按任务更新时间</g:link>
                                </li>
                            </ul>
                        </div>
                        <a href="#" id="addrenwu" class="f-r"><i class="fa fa-plus-circle"></i>新建任务</a>
                    </div>
                    <div class="e-list-group today">
                        <div class="e-list-head">
                            <a class="group-add f-r">+</a>
                            <a class="e-list-title"><strong>今天开始（${todayTaskInstance.size()}）</strong><i class="fa fa-angle-right"></i></a>
                        </div>
                        <ul class="e-list">
                        <g:if test="${todayTaskInstance}">
                            <g:each in="${todayTaskInstance}" status="i" var="taskInfo">
                                <li>
                                    <span class="mark <g:if test="${taskInfo.playstatus=='1'}">mark-danger</g:if><g:if test="${taskInfo.playstatus=='2'}">mark-warning</g:if><g:if test="${taskInfo.playstatus=='3'}">mark-safe</g:if><g:if test="${taskInfo.playstatus=='4'}">mark-nomarl</g:if>"><i></i></span>
                                    <span class="sn">${i+1}</span>
                                    <span class="title" data-task-id="${taskInfo.id}"  data-task-version="${taskInfo.version}">${taskInfo.title}</span>
                                    <div class="right">
                                        %{--<span class="hsfinish"><g:link action="taskUpdate" id="${taskInfo.id}" params="[version: taskInfo.version]"><i class="fa <g:if test="${taskInfo.status=="1"}">fa-check-square-o</g:if><g:else>fa-square-o</g:else>"></i>标记完成</g:link></span>--}%
                                        %{--<g:if test="${taskInfo.fzuid.toInteger()==session.user.id}"><span class="del"><g:link action="taskDelete"  id="${taskInfo.id}"><i class="fa fa-trash-o"></i>删除任务</g:link></span></g:if>--}%
                                        <span class="hsfinish"><a href="javascript:;" class="taskedit" data-id="${taskInfo.id}" data-version="${taskInfo.version}"><i class="fa <g:if test="${taskInfo.status=="1"}">fa-check-square-o</g:if><g:else>fa-square-o</g:else>"></i>标记完成</a></span>
                                        <g:if test="${taskInfo.fzuid.toInteger()==session.user.id}"><span class="del"><a href="javascript:;" class="taskdelete" data-id="${taskInfo.id}" data-version="${taskInfo.version}"><i class="fa fa-trash-o"></i>删除任务</a></span></g:if>
                                        <span class="date f-r">${taskInfo.overtime}</span>
                                    </div>
                                </li>
                            </g:each>
                        </g:if>
                        <g:else>
                            <li><span class="mark"></span>没有任务！</li>
                        </g:else>
                        </ul>
                    </div>
                    <div class="e-list-group tomorrow">
                        <div class="e-list-head">
                            <a class="group-add f-r">+</a>
                            <a class="e-list-title"><strong>明天开始（${tomorrowTaskInstance.size()}）</strong><i class="fa fa-angle-right"></i></a>
                        </div>
                        <ul class="e-list">
                        <g:if test="${tomorrowTaskInstance}">
                            <g:each in="${tomorrowTaskInstance}" status="i" var="tomorrowTaskInfo">
                                <li>
                                    <span class="mark <g:if test="${tomorrowTaskInfo.playstatus=='1'}">mark-danger</g:if><g:if test="${tomorrowTaskInfo.playstatus=='2'}">mark-warning</g:if><g:if test="${tomorrowTaskInfo.playstatus=='3'}">mark-safe</g:if><g:if test="${tomorrowTaskInfo.playstatus=='4'}">mark-nomarl</g:if>"><i></i></span>
                                    <span class="sn">${i+1}</span>
                                    <span class="title"  data-task-id="${tomorrowTaskInfo.id}"  data-task-version="${tomorrowTaskInfo.version}">${tomorrowTaskInfo.title}</span>
                                    <div class="right">
                                        %{--<span class="hsfinish"><g:link action="taskUpdate" id="${tomorrowTaskInfo.id}" params="[version: tomorrowTaskInfo.version]"><i class="fa <g:if test="${tomorrowTaskInfo.status=="1"}">fa-check-square-o</g:if><g:else>fa-square-o</g:else>"></i>标记完成</g:link></span>--}%
                                        %{--<g:if test="${tomorrowTaskInfo.fzuid.toInteger()==session.user.id}"><span class="del"><g:link action="taskDelete"  id="${tomorrowTaskInfo.id}"><i class="fa fa-trash-o"></i>删除任务</g:link></span></g:if>--}%
                                        <span class="hsfinish"><a href="javascript:;" class="taskedit" data-id="${tomorrowTaskInfo.id}" data-version="${tomorrowTaskInfo.version}"><i class="fa <g:if test="${tomorrowTaskInfo.status=="1"}">fa-check-square-o</g:if><g:else>fa-square-o</g:else>"></i>标记完成</a></span>
                                        <g:if test="${tomorrowTaskInfo.fzuid.toInteger()==session.user.id}"><span class="del"><a href="javascript:;" class="taskdelete" data-id="${tomorrowTaskInfo.id}" data-version="${tomorrowTaskInfo.version}"><i class="fa fa-trash-o"></i>删除任务</a></span></g:if>
                                        <span class="date f-r">${tomorrowTaskInfo.overtime}</span>
                                    </div>
                                </li>
                            </g:each>

                        </g:if>
                        <g:else>
                            <li><span class="mark"></span>没有任务！</li>
                        </g:else>
                        </ul>
                    </div>
                    <div class="e-list-group overdate">
                        <div class="e-list-head">
                            <a class="group-add f-r">+</a>
                            <a class="e-list-title"><strong>即将到期任务</strong><i class="fa fa-angle-right"></i></a>
                        </div>
                        <ul class="e-list">
                            <g:if test="${taskInstance}">
                                <g:each in="${taskInstance}" status="i" var="taskInfo">
                                    <li>
                                        <span class="mark <g:if test="${taskInfo.playstatus=='1'}">mark-danger</g:if><g:if test="${taskInfo.playstatus=='2'}">mark-warning</g:if><g:if test="${taskInfo.playstatus=='3'}">mark-safe</g:if><g:if test="${taskInfo.playstatus=='4'}">mark-nomarl</g:if>"><i></i></span>
                                        <span class="sn">${i+1}</span>
                                        <span class="title" data-task-id="${taskInfo.id}"  data-task-version="${taskInfo.version}">${taskInfo.title}</span>
                                        <div class="right">
                                            %{--<span class="hsfinish"><g:link action="taskUpdate" id="${taskInfo.id}" params="[version: taskInfo.version]"><i class="fa <g:if test="${taskInfo.status=="1"}">fa-check-square-o</g:if><g:else>fa-square-o</g:else>"></i>标记完成</g:link></span>--}%
                                            %{--<g:if test="${taskInfo.fzuid.toInteger()==session.user.id}"><span class="del"><g:link action="taskDelete"  id="${taskInfo.id}"><i class="fa fa-trash-o"></i>删除任务</g:link></span></g:if>--}%
                                            <span class="hsfinish"><a href="javascript:;" class="taskedit" data-id="${taskInfo.id}" data-version="${taskInfo.version}"><i class="fa <g:if test="${taskInfo.status=="1"}">fa-check-square-o</g:if><g:else>fa-square-o</g:else>"></i>标记完成</a></span>
                                            <g:if test="${taskInfo.fzuid.toInteger()==session.user.id}"><span class="del"><a href="javascript:;" class="taskdelete" data-id="${taskInfo.id}" data-version="${taskInfo.version}"><i class="fa fa-trash-o"></i>删除任务</a></span></g:if>
                                            <span class="date f-r">${taskInfo.overtime}</span>
                                        </div>
                                    </li>
                                </g:each>

                            </g:if>
                            <g:else>
                                <li><span class="mark"></span>没有任务！</li>
                            </g:else>
                        </ul>
                    </div>
                </div>
                <div class="col-cell bfb" style="width:340px;">
                    <div class="count">
                        <div class="bfb_hearder">
                            今日任务统计
                        </div>
                        <canvas style="width: 340px; height: 255px;" id="doughnut" height="255" width="340"></canvas>
                        <div class="bfb_fl"></div>
                    </div>
                </div>
            </div>
            <!--弹层 start-->
            <div class="popup_box">
                <div class="m_box">
                    <header class="panel-heading">
                        <span>新建任务</span>
                        <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
                    </header>
                    <g:form url="[controller:'front',action:'taskSave']">
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
                        </div>
                        <div class="control-group">
                            <input type="text" placeholder="一句话描述任务" class="size" name="title" />
                        </div>
                        <div class="control-group">
                            <input type="text" placeholder="添加任务详情" class="size" name="content" />
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
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>起止日期</td>
                                    <td><input id="startdate" name="bigentime" value="" readonly="" class="default-date-picker" type="text">-<input id="enddate" name="overtime" value="" readonly="" class="form_datetime" type="text"></td>
                                </tr>
                            </table>
                        </div>
                        <div class="control-group">
                            <button id="submit" type="submit" class="btn btn-info f-r">提交</button>
                        </div>
                    </g:form>
                </div>
            </div>
        </section>
</section>
</div>
            <!--弹层 end-->
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
                value: ${todayTaskInstance.size()},//未完成数
                color:"#87CEFA"
            },
            {
                value : ${todayFinishedTaskInstance.size()},//已完成数
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
        $(".popup_box .r-title-jinji").mouseenter(function(){
            $(this).addClass("active");
        }).mouseleave(function(){
            $(this).removeClass("active");
        })
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
            $(".popup_box .r-title-jinji span").html(playstatuscn);
            $(".popup_box .r-title-jinji").removeClass("active");
        });

        //详情滑动框
        $(".e-list-group .e-list .title").click(function(){
            var $this=$(this)
            var taskid =$this.attr("data-task-id");
            var taskversion = $this.attr("data-task-version");
            $.ajax({
                url:'${webRequest.baseUrl}/front/taskShow?id='+taskid+'&version='+taskversion,
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
                $(".dropdown-menu").hide();
                $("#cnplayname").html('${userInfo.name}');
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
    })
</script>
</body>
</html>