


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
                        <span>我的任务</span>
                        <div class="shaixuan">
                            <a class="task-order">排序<i class="fa fa-caret-down"></i></a>
                        </div>
                        <a href="#" id="addrenwu" class="f-r"><i class="fa fa-plus-circle"></i>新建任务</a>
                    </div>
                    <div class="e-list-group today">
                        <div class="e-list-head">
                            <a class="group-add f-r">+</a>
                            <a class="e-list-title"><strong>今天开始（2）</strong><i class="fa fa-angle-right"></i></a>
                        </div>
                        <ul class="e-list">
                        <g:each in="${taskInstance}" status="i" var="taskInfo">
                            <li>
                                <span class="mark <g:if test="${taskInfo.playstatus=='1'}">mark-danger</g:if><g:if test="${taskInfo.playstatus=='2'}">mark-warning</g:if><g:if test="${taskInfo.playstatus=='3'}">mark-safe</g:if><g:if test="${taskInfo.playstatus=='4'}">mark-nomarl</g:if>"><i></i></span>
                                <span class="sn">${i+1}</span>
                                <span class="title">${taskInfo.title}</span>
                                <div class="right">
                                    <span class="hsfinish"><g:link action="taskUpdate" id="${taskInfo.id}" params="[version: taskInfo.version]"><i class="fa <g:if test="${taskInfo.status=="1"}">fa-check-square-o</g:if><g:else>fa-square-o</g:else>"></i>标记完成</g:link></span>
                                    <span class="del"><g:link action="taskDelete"  id="${taskInfo.id}"><i class="fa fa-trash-o"></i>删除任务</g:link></span>
                                    <span class="date f-r">${taskInfo.overtime}</span>
                                </div>
                            </li>
                        </g:each>
                        </ul>
                    </div>
                    <div class="e-list-group tomorrow">
                        <div class="e-list-head">
                            <a class="group-add f-r">+</a>
                            <a class="e-list-title"><strong>明天开始</strong><i class="fa fa-angle-right"></i></a>
                        </div>
                        <ul class="e-list">
                            <li>1234</li>
                            <li>2345</li>
                        </ul>
                    </div>
                    <div class="e-list-group overdate">
                        <div class="e-list-head">
                            <a class="group-add f-r">+</a>
                            <a class="e-list-title"><strong>即将到期任务</strong><i class="fa fa-angle-right"></i></a>
                        </div>
                        <ul class="e-list">
                            <li>
                                <span class="mark mark-nomarl"><i></i></span>
                                <span class="sn">1</span>
                                <span class="title">任务标题</span>
                                <div class="right">
                                    <span class="hsfinish"><i class="fa fa-square-o"></i>标记完成</span>
                                    <span class="del"><i class="fa fa-trash-o"></i>删除任务</span>
                                    <span class="date f-r">2015-7-16</span>
                                </div>
                            </li>
                            <li>2345</li>
                        </ul>
                    </div>
                </div>
                <div class="col-cell" style="width:340px;">

                </div>
            </div>
            <!--弹层 start-->
            <div class="popup_box">
                <div class="m_box">
                    <header class="panel-heading">
                        <span><i class="yh"></i>新建任务</span>
                        <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
                    </header>
                    <g:form url="[controller:'front',action:'taskSave']">
                        <div class="r-title">
                            <div class="r-title-con f-l">任务</div>
                            <div class="r-title-jinji f-l">
                                <i class="clock-b"></i><span class="r-chd">紧急程度</span>
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
                                        <div class="zhxr">
                                            <a id="playman">选择</a>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>起止日期</td>
                                    <td><input id="startdate" name="bigentime" value="" readonly="" class="form_datetime" type="text">-<input id="enddate" name="overtime" value="" readonly="" class="form_datetime" type="text"></td>
                                </tr>
                            </table>
                        </div>
                        <div class="control-group">
                            <button id="submit" type="submit" class="btn btn-info f-r">提交</button>
                        </div>
                    </g:form>
                </div>
            </div>
            <!--弹层 end-->
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
                    $("#playbid").val(${bumenInfo.id});
                    $(this).hide();
                    $(".zhxr").html("${userInfo.name}");
                }}
                </g:each>
            ]},
            </g:each>
            </g:if>
            <g:else>
                <g:each in="${com.guihuabao.CompanyUser.findAllByCidAndBid(session.company.id,session.user.bid)}" var="userInfo">
                {text: '${userInfo.name}', href: '#', action: function(e){
                    $("#playuid").val(${userInfo.id});
                    $("#playbid").val(${session.user.bid});
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