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
    body{background:#fff;}
    .toolkit{border:none;border-bottom:1px dashed #e5e5e5;color:#000; }
    .form-control{background:#f2f2f3;border:1px solid #e5e5e5;}
    .datetimepicker table tr td span {width:30%;}
    </style>
</head>

<body>
<div class="tishi" style="border:1px solid #000;background-color: pink;text-align: center;width:300px;height:80px;margin:250px auto;line-height:80px;position: fixed;z-index: 10000;display:none;">${params.msg}</div>
<section id="container1" style="width:100%;overflow-x:hidden;">
<!--header start-->
<g:render template="header" />
<div style="height:110px;"></div>
<!--header end-->
<!--sidebar start-->
<div class="row">
    %{--<div class="col-xs-2" style="height:100%"></div>--}%
    %{--<g:render template="guihua_siderbar" />--}%
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content" class="col-xs-12" style="padding-left:0;">
        <section class="wrapper" style="width:90%;margin:0 auto;display:block;">
            <div class="col-tb">
                <div class="col-cell">
                    <div class="toolkit">
                        <div style="width:200px;margin:0 auto;text-align: center;font-size: 26px;color:#27bdff">规划目标表单</div>
                    </div>
                    <div style="margin-top:10px;color:#000;">注：此日期选择是您目标规划的时间区间，建议以两年为时间周期进行规划。</div>
                    <div class="content">
                        <div style="margin:60px auto;width:400px;" class="clearfix row">
                            <g:form url="[controller:'front',action:'guimoUpdate']" method="post" class="form-horizontal">
                                <label for="startdate" class="col-sm-3 control-label">开始时间：</label>
                                <div class="col-sm-9" style="position: relative;">
                                    <input id="startdate" class="form-control" name="begintime" value="${guimoInstance.begintime}"/><br/>
                                    <div style="position: absolute;top:10px;right:25px;z-index: 10000;"><i class="fa fa-calendar" ></i></div>
                                </div>
                                <label for="enddate" class="col-sm-3 control-label">开始时间：</label>
                                <div class="col-sm-9" style="position: relative;">
                                    <input id="enddate"  class="form-control" name="endtime" value="${guimoInstance.endtime}"/><br/>
                                    <div style="position: absolute;top:10px;right:25px;z-index: 10000;"><i class="fa fa-calendar" ></i></div>
                                </div>
                                <input type="hidden" name="id" value="${guimoInstance.id}"/>
                                <input type="hidden" name="sign" value="choose_date"/>
                                <label class="col-sm-3 control-label"></label>
                                <div class="col-sm-9" style="position: relative;">
                                    <button type="submit"  class="button" style="width:90px;background:#27bdff;border:none;height:40px;border-radius: 3px;color:#fff;">确定</button>

                                </div>

                            </g:form>

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


</section>
<!--评论及反馈 end-->
<!-- js placed at the end of the document so the pages load faster -->
<script src="${resource(dir: 'js', file: 'jquery.js')}"></script>
<script src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
%{--<script class="include" type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dcjqaccordion.2.7.js')}"></script>--}%
%{--<script src="${resource(dir: 'js', file: 'jquery.scrollTo.min.js')}"></script>--}%
%{--<script src="${resource(dir: 'js', file: 'jquery.nicescroll.js')}" type="text/javascript"></script>--}%
%{--<script src="${resource(dir: 'js', file: 'jquery.sparkline.js')}" type="text/javascript"></script>--}%
%{--<script src="${resource(dir: 'assets/jquery-easy-pie-chart/', file: 'jquery.easy-pie-chart.js')}"></script>--}%
%{--<script src="${resource(dir: 'js', file: 'owl.carousel.js')}" ></script>--}%
%{--<script src="${resource(dir: 'js', file: 'jquery.customSelect.min.js')}" ></script>--}%
%{--<script src="${resource(dir: 'js', file: 'respond.min.js')}" ></script>--}%
%{--<script src="${resource(dir: 'js', file: 'jquery.form.js')}" ></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'assets/fuelux/js', file: 'spinner.min.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-fileupload', file: 'bootstrap-fileupload.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-wysihtml5', file: 'wysihtml5-0.3.0.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-wysihtml5', file: 'bootstrap-wysihtml5.js')}"></script>--}%
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-datepicker/js', file: 'bootstrap-datepicker.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-datetimepicker/js', file: 'bootstrap-datetimepicker.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-datetimepicker/js', file: 'bootstrap-datetimepicker.zh-CN.js')}"></script>
%{--<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-daterangepicker', file: 'moment.min.js')}"></script>--}%
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-daterangepicker', file: 'daterangepicker.js')}"></script>
%{--<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-colorpicker/js', file: 'bootstrap-colorpicker.js')}"></script>--}%
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-timepicker/js', file: 'bootstrap-timepicker.js')}"></script>
%{--<script type="text/javascript" src="${resource(dir: 'assets/jquery-multi-select/js', file: 'jquery.multi-select.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'assets/jquery-multi-select/js', file: 'jquery.quicksearch.js')}"></script>--}%


<!--菜单js-->
%{--<script src="${resource(dir: 'js', file: 'advanced-form-components.js')}"></script>--}%
%{--<script src="${resource(dir: 'js', file: 'context.js')}"></script>--}%
%{--<!--right slidebar-->--}%
%{--<script src="${resource(dir: 'js', file: 'slidebars.min.js')}"></script>--}%

%{--<!--common script for all pages-->--}%
%{--<script src="${resource(dir: 'js', file: 'common-scripts.js')}"></script>--}%

%{--<!--script for this page-->--}%
%{--<script src="${resource(dir: 'js', file: 'sparkline-chart.js')}"></script>--}%
%{--<script src="${resource(dir: 'js', file: 'easy-pie-chart.js')}"></script>--}%
%{--<script src="${resource(dir: 'js', file: 'count.js')}"></script>--}%

%{--<!--上传图片预览 js-->--}%
%{--<script src="${resource(dir: 'js', file: 'uploadPreview.js')}"></script>--}%
<script type="text/javascript">
//    $(function () {
        $('#startdate').datetimepicker({
            language:'zh-CN',
            format: 'yyyy-mm',
            startView:3,
            minView:3,
            autoclose: 1,
            pickerPosition: "bottom-left",
            forceParse: 0,　　
    });
$('#enddate').datetimepicker({
    language:'zh-CN',
    format: 'yyyy-mm',
    startView:3,
    minView:3,
    autoclose: 1,
    pickerPosition: "bottom-left",
    forceParse: 0,　　
});
//    });
</script>



</body>
</html>