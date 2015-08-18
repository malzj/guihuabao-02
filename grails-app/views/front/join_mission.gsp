


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
    <style>
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
        <section id="main-content" class="col-xs-9" style="padding-left: 0;">
            <section class="wrapper">
                <div class="col-tb">
                    <div class="col-cell">
                        <div class="toolkit">
                            <span>参与的任务</span>
                            <div class="shaixuan">
                                <a class="task-order">排序<i class="fa fa-caret-down"></i></a>
                                <ul>

                                        <g:link action="join_mission" params="[selected: 1]">按任务到期时间</g:link>
                                    </li>
                                    <li>
                                        <g:link action="join_mission" params="[selected: 2]">按任务创建时间</g:link>
                                    </li>

                                </ul>
                            </div>
                        </div>
                        <div class="e-list-group">
                            <ul class="e-list">
                                <g:if test="${missionInstance}">
                                    <g:each in="${missionInstance}" status="i" var="missionInfo">
                                        <g:if test="${missionInfo.issubmit=='1'}">
                                        <li class="m_all">
                                            <span style="display:none">${missionInfo.id}</span>
                                            <span class="sn">${i+1}</span>
                                            <span class="title" data-task-id="${missionInfo.id}">${missionInfo.title}</span>
                                            <span class="status"><g:if test="${missionInfo.status=="1"}">已完成</g:if><g:else>未完成</g:else></span>
                                            <div class="right">
                                                %{--<span class="hsfinish"><g:link action="taskUpdate" id="${missionInfo.id}" params="[version: missionInfo.version]"><i class="fa <g:if test="${missionInfo.status=="1"}">fa-check-square-o</g:if><g:else>fa-square-o</g:else>"></i>标记完成</g:link></span>--}%
                                                %{--<g:if test="${missionInfo.fzuid.toInteger()==session.user.id}"><span class="del"><g:link action="taskDelete"  id="${missionInfo.id}"><i class="fa fa-trash-o"></i>删除任务</g:link></span></g:if>--}%

                                                %{--<g:if test="${missionInfo.fzuid.toInteger()==session.user.id}"><span class="del"><a href="javascript:;" class="taskdelete" data-id="${missionInfo.id}" data-version="${missionInfo.version}"><i class="fa fa-trash-o"></i>删除任务</a></span></g:if>--}%
                                                <span class="date f-r">${missionInfo.overtime}</span>
                                            </div>
                                        </li>
                                        </g:if>
                                    </g:each>

                                </g:if>
                                <g:else>
                                    <li><span class="mark"></span>没有任务！</li>
                                </g:else>
                            </ul>
                            <span style="display:none" id="var_all"></span>
                        </div>
                        <div class="pagination">
                            <g:paginate total="${missionInstanceTotal}" params="[selected: selected]" />
                        </div>
                    </div>

                </div>
                <!--任务详情 start-->
                <div id="task" style="display: none ;z-index:1000;">
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
                    %{--<g:hiddenField name="taskid" id="taskid" ></g:hiddenField>--}%
                    %{--<g:hiddenField name="version" id="version" ></g:hiddenField>--}%
                    <button id="taskaccept" class="rbtn btn-blue ml25 mt10">接受</button>
                    <div class="discuss clearfix">
                        <h4>反馈及评论</h4>
                        <form id="form1" method="post">
                            %{--<g:hiddenField name="id" id="id"></g:hiddenField>--}%
                            <g:hiddenField name="bpuid" id="bpuid"></g:hiddenField>
                            <g:hiddenField name="bpuname" id="bpuname"></g:hiddenField>
                            <g:hiddenField name="puid" id="puid" value="${session.user.id}"></g:hiddenField>
                            <g:hiddenField name="puname" id="puname" value="${session.user.name}"></g:hiddenField>
                            <div>
                                <textarea id="content1" name="content"></textarea>
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

<!--百分比图-->
<script src="${resource(dir: 'assets/chart-master', file: 'Chart.js')}"></script>
<!--    <script src="js/all-chartjs.js"></script>-->
<!--详情滑动框-->
<script src="${resource(dir: 'js', file: 'slidelefthideshow.js')}"></script>

<script type="text/javascript">
    %{--var Script = function () {--}%
        %{--var doughnutData = [--}%
            %{--{--}%
                %{--value: ${infos.yq},//延期任务--}%
                %{--color:"#FF7F50"--}%
            %{--},--}%
            %{--{--}%
                %{--value: ${infos.unfinished},//未完成数--}%
                %{--color:"#87CEFA"--}%
            %{--},--}%
            %{--{--}%
                %{--value : ${infos.finished},//已完成数--}%
                %{--color : "#32CD32"--}%
            %{--}--}%
        %{--];--}%
        %{--new Chart(document.getElementById("doughnut").getContext("2d")).Doughnut(doughnutData);--}%
    %{--}();--}%

    $(function(){
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
        $(".m_all").click(function(){
            var mid = $(this).find('span:first').html();
            $('#var_all').html(mid);
            $.ajax({
                url:'${webRequest.baseUrl}/front/mhasvisited?mid='+mid,
                dataType: "json",
                type:'post',
                success: function (data) {
                    // 去渲染界面

                        var html="";
                        var html2="";
                        var status = (data.mission.status=='1')?"已完成":"进行中";
                        var fzuid=data.target.fzuid;
                        html+='<div class="task_line"><span class="title">'+data.mission.title+'</span></div>';
                        html+='<div class="task_line"><span class="content">'+data.mission.content+'</span></div>';
                        html+='<div class="task_line"><span>指派人：</span><span class="font_blue">'+data.fzname+'</span></div>';
                        html+='<div class="task_line"><span>执行人：</span><span class="font_blue">'+data.mission.playname+'</span></div>';
                        html+='<div class="task_line"><span>起始日：</span><span>'+data.mission.begintime+'</span></div>';
                        html+='<div class="task_line"><span>终止日：</span><span>'+data.mission.overtime+'</span></div>';
                        html+='<div class="task_line"><span>任务状态：</span><span class="font_blue">'+status+'</span></div>';
                        $('#bpuid').val(data.target.fzuid);
                        $('#bpuname').val(data.fzname);
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
                    $("#task .task_content").append(html);
                    $("#reply_container").append(html2);
                    replyclick();
                        $("#task").slideLeftShow(400);
                    },
                error:function() {

                        alert("信息读取失败！");

                }

            })
        });
        $('#taskaccept').click(function(){
            var mid=$('#var_all').html();

            $.ajax({
                url:'${webRequest.baseUrl}/front/maccept?mid='+mid,
                dataType: "json",
                type:'post',
                success: function (data) {
                    alert('接受任务成功！');

                },
                error:function(){alert('获取信息失败1！');}
            });
        })
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

                var mid = $('#var_all').html();
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

        $("#submit").click(function(){
            var mid=$('#var_all').html();
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
        $(".taskclose").click(function(){
            $("#task").slideLeftHide(400);
            $("#task .task_content").empty();
        });
    })
</script>
</body>
</html>