


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
                            <span>未读的评论</span>

                        </div>
                        <div class="e-list-group" id="task" style="position:static;width:100%">
                            <ul >
                                <g:if test="${replymissionlist}">
                                    <g:each in="${replymissionlist}" status="i" var="val">
                                        <li >
                                            <div class="reply_box"><div class="name">${val.puname}&nbsp;回复&nbsp;${val.bpuname}</div>
                                            <p>${val.content}</p>
                                            <span>${val.date}</span><a href="javascript:;" class="reply" data-info="${val.puid},${val.puname}">回复</a><span style="display:none;">${val.missionId}</span>
                                            <div class="shuru"><span>回复&nbsp;${val.puname}</span>
                                            <div class="rcontainer"></div>
                                            </div></div>

                                        </li>
                                    </g:each>

                                </g:if>
                                <g:else>
                                    <li>没有评论！</li>
                                </g:else>
                            </ul>
                            <span style="display:none" id="var_all"></span>
                        </div>
                        <div class="pagination">
                            <g:paginate total="${replymissionTotal}" params="[selected: selected]" />
                        </div>
                    </div>

                </div>

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

        replyclick();

        function replyclick() {

            $(".reply").on("click", function () {
                var mid=$(this).next().html();
                alert(mid);
                var info = $(this).attr("data-info")
                var arr = info.split(",")
                $(".shuru .rcontainer").empty()
                $(".shuru").hide()
                var html2 = ""
                html2+='<form id="form2">'
                html2+='<input type="hidden" name="bpuid" value="'+arr[0]+'" />'
                html2+='<input type="hidden" name="bpuname" value="'+arr[1]+'" />'
                html2+='<input type="hidden" name="puid" value="${session.user.id}" />'
                html2+='<input type="hidden" name="puname" value="${session.user.name}" />'
                html2+='<div class="mt10"><textarea name="content"></textarea></div>'
                html2+='<a class="huifu fbtn btn-white mt10">回复</a><span style="display:none;">'+mid+'</span><a class="quxiao fbtn btn-white mt10 ml20">取消</a>'
                html2+='</form>'
                $(this).next().next().find('.rcontainer').html(html2);
                $(this).next().next().slideDown()
                replysubmit();
            })

        }

        function replysubmit() {
            $(".quxiao").on("click", function () {
                $(this).parent().parent().parent().slideUp();
                $(".shuru .rcontainer").empty()
            })
            $(".huifu").click(function () {

                var mid = $(this).next().html();
                alert(mid);
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


    })
</script>
</body>
</html>