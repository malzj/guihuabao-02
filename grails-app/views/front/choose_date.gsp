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
    body{background: #f1f2f7}
    .toolkit{border:none;border-bottom:1px dashed #e5e5e5;color:#000; height:30px;}
    .form-control{background:#f2f2f3;border:1px solid #e5e5e5;}
    .datetimepicker table tr td span {width:30%;}
    </style>
</head>

<body>
<section id="container" >
<!--header start-->
<g:render template="header" />
<!--header end-->
<!--main content start-->
<section id="main-content" style="margin-left: 0px;">
    <section class="wrapper" style="margin-top: 94px;">
        <div class="testPaper">
            <ul class="steps clearfix">
                <li class="stp">
                    <span>第一步</span>
                    <p>现状评估</p>
                </li>
                <li class="arrow"></li>
                <li class="stp active">
                    <span>第二步</span>
                    <p>规模目标</p>
                </li>
                <li class="arrow"></li>
                <li class="stp">
                    <span>第三步</span>
                    <p>财务目标</p>
                </li>
                <li class="arrow"></li>
                <li class="stp">
                    <span>第四步</span>
                    <p>组织架构</p>
                </li>
                <li class="arrow"></li>
                <li class="stp">
                    <span>第五步</span>
                    <p>工作推进</p>
                </li>
            </ul>
            <div class="test-question reset">
        <section class="wrapper" style="width:100%;margin:0 auto;display:block;">
            <div class="col-tb">
                <div class="col-cell">
                    <div class="toolkit">
                        <div style="margin-top:10px;color:#000;">注：此日期选择是您目标规划的时间区间，建议以两年为时间周期进行规划。</div>
                    </div>

                    <div class="content">
                        <div style="margin:60px auto;width:400px;" class="clearfix row">
                            <g:form url="[controller:'front',action:'guimoUpdate']" method="post" class="form-horizontal">
                                <label for="startdate" class="col-sm-3 control-label">开始时间：</label>
                                <div class="col-sm-9" style="position: relative;">
                                    <input id="startdate" class="form-control" name="begintime" value="${guimoInstance.begintime}"/><br/>
                                    <div style="position: absolute;top:10px;right:25px;z-index: 10000;"><i class="fa fa-calendar" ></i></div>
                                </div>
                                <label for="enddate" class="col-sm-3 control-label">结束时间：</label>
                                <div class="col-sm-9" style="position: relative;">
                                    <input id="enddate"  class="form-control" name="endtime" value="${guimoInstance.endtime}" title="结束时间不能小于开始时间，并且不能大于第二年年底"/><br/>
                                    <div style="position: absolute;top:10px;right:25px;z-index: 10000;"><i class="fa fa-calendar" ></i></div>
                                </div>
                                <input type="hidden" name="id" value="${guimoInstance.id}"/>
                                <input type="hidden" name="sign" value="choose_date"/>
                                <input type="hidden" name="isupdate" value="${isupdate}"/>
                                <label class="col-sm-3 control-label"></label>
                                <div class="col-sm-9" style="position: relative;">
                                    <button type="submit" id="submit" class="button" style="width:90px;background:#27bdff;border:none;height:40px;border-radius: 3px;color:#fff;">确定</button>

                                </div>

                            </g:form>

                        </div>



                    </div>


                </div>
            </div>

        </section>
        <!--main content end-->
</div></div>
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
    $(function () {
        var bt=$('#startdate').val();
        $('#startdate1').html(bt);

        $('#startdate').datetimepicker({
            language:'zh-CN',
            format: 'yyyy-mm',
            startDate:new Date(),
            startView:3,
            minView:3,
            todayHighlight:true,
            autoclose: 1,
            pickerPosition: "bottom-left",
            forceParse: 0


    })
// .on('changeMonth',function(ev){
//        var byear=new Date(ev.date.valueOf()).getFullYear();
//        var bmonth=new Date(ev.date.valueOf()).getMonth()+1;
//        var b=byear+'-'+bmonth;
//        $('#startdate1').html(b);
//    });


    $('#enddate').datetimepicker({
        language: 'zh-CN',
        format: 'yyyy-mm',
        startView: 3,
        startDate: new Date(),

        minView: 3,
        autoclose: 1,
        pickerPosition: "bottom-left",
        forceParse: 0
    });


    $('#submit').click(function(){
        var btime=$('#startdate').val();
        var etime=$('#enddate').val();
        var bstr = btime.replace(/-/g,"/");
        var bdate = new Date(bstr);
        var byear=bdate.getFullYear();
        var emonth=byear+1+'-12';
        if(btime==''){
            $('#startdate').css('border-color','red');
            return false;
        }else{
            $('#startdate').css('border-color','#d8d8d8');
        }
        if(etime==''){
            $('#enddate').css('border-color','red');
            return false;
        }else{
            $('#enddate').css('border-color','#d8d8d8');
        }
        if(btime>etime||etime>emonth){
            $('#enddate').css('border-color','red');
            return false;
        }else{
            $('#enddate').css('border-color','#d8d8d8');
        }
    })

    });
//    $('#startdate').datetimepicker().on('changeMonth',function(ev){
//
//        var bmonth=new Date(ev.date.valueOf())+'';
//        var byear=new Date(ev.date.valueOf()).getFullYear();
//        var emonth=byear+1+'-12';
//        $('#enddate').datetimepicker({
//            language: 'zh-CN',
//            format: 'yyyy-mm',
//            startView: 3,
//            startDate:bmonth,
//            endDate: emonth,
//            minView: 3,
//            autoclose: 1,
//            pickerPosition: "bottom-left",
//            forceParse: 0,
//    　　
//    });
//    })

</script>



</body>
</html>