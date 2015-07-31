


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
    <aside>
        <div id="sidebar"  class="nav-collapse ">
            <div class="sidebar_object">
                <i class="fa fa-calendar-o"></i>
                公司公告
            </div>
        </div>
    </aside>
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <div class="col-tb">
                <div class="col-cell">
                    <div class="toolkit">
                        <span>公司公告</span>
                    </div>
                    <div class="e-list-group">
                        <ul class="e-list fzalltasklist">
                            <g:if test="${companyNoticeInstanceList}">
                                <g:each in="${companyNoticeInstanceList}" status="i" var="companyNoticeInfo">
                                    <li>
                                        <span class="mark"></span>
                                        <span class="sn">${i+1}</span>
                                        <span class="title" data-task-id="${companyNoticeInfo.id}">${companyNoticeInfo.title}</span>
                                        <div class="right">
                                            <span class="date f-r">${companyNoticeInfo.dateCreate.format("yyyy-MM-dd")}</span>
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
                        <g:paginate total="${companyNoticeInstanceTotal}" />
                    </div>
                </div>
                <div class="col-cell bfb" style="width:340px;">
                </div>
            </div>
            <!--任务详情 start-->
            <div id="task" style="display: none">
                <div class="task_hearder">
                    <div class="task_hearder_title">
                        <span><i class="yh"></i>公告详情</span>
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
                url:'${webRequest.baseUrl}/front/companyNoticeAjaxShow?id='+taskid,
                dataType: "jsonp",
                jsonp: "callback",
                success: function (data) {
                    // 去渲染界面
                    if(data.msg){
                        var html="";
                        html+='<div class="task_line"><span class="title">'+data.companyNoticeInstance.title+'</span></div>';
                        html+='<div class="task_line"><span>'+data.companyNoticeInstance.content+'</span></div>';
                        $("#task .task_content").empty();
                        $("#task .task_content").append(html);
                        $("#task").slideLeftShow(400);
                    }else{
                        alert("信息读取失败！");
                    }
                }
            })
        });
        $(".taskclose").click(function(){
            $("#task").slideLeftHide(400);
            $("#task .task_content").empty();
        });

        //筛选
        $(".toolkit .shaixuan .finished").bind("click",function(){
            $(this).parent().parent(). slideUp("fast");
            $(".toolkit .task-order").css("border-bottom","none");
            $(".e-list-group .finishedlist").siblings().hide();
            $(".e-list-group .finishedlist").show();
        });
        $(".toolkit .shaixuan .unfinished").bind("click",function(){
            $(this).parent().parent(). slideUp("fast");
            $(".toolkit .task-order").css("border-bottom","none");
            $(".e-list-group .unfinishedlist").siblings().hide();
            $(".e-list-group .unfinishedlist").show();
        });
    })
</script>
</body>
</html>