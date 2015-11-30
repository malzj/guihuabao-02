<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 15-6-16
  Time: 下午3:59
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
    <link href="${resource(dir: 'css', file: 'styleone.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'style-responsive.css')}" rel="stylesheet">

    <link href="${resource(dir: 'css', file: 'ownset.css')}" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'assets/bootstrap-datepicker/css', file: 'datepicker.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'assets/bootstrap-datetimepicker/css', file: 'datetimepicker.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'assets/bootstrap-daterangepicker', file: 'daterangepicker-bs3.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'assets/bootstrap-timepicker/compiled', file: 'timepicker.css')}" />
    <style>
        label{font-weight: normal;margin-top:7px;}
        input{width:270px !important;}
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
                <li class="stp">
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
                <li class="stp active">
                    <span>第五步</span>
                    <p>工作推进</p>
                </li>
            </ul>
        <div class="test-question reset">
            <div class="test-title">企业组织架构</div>
            <p style="margin-top:10px;"><span class="tk1"></span><span>提示：请根据需求选择虚线框内部门，点击按钮查看部门职能，拖拽按钮到下图框中以生成企业组织架构图。</span></p>
            <div class="all-department" style="border:none;background:#fff;padding:0;min-height:1px;">

                <ul class="clearfix">
                    <g:each in="${selectDepartmentList}" var="selectDepartmentInstance">
                        <li>
                            <span  class="click">${selectDepartmentInstance.name}</span>
                            <span style="display: none">${selectDepartmentInstance.id}</span>
                        </li>
                    </g:each>
                </ul>
            </div>


        </div>
            <g:form url="[controller:'front',action:'bumenrenwuAdd']" class="clearfix" id="form" style="width:370px;height:286px;margin:30px auto;border:1px solid #dedede;box-shadow: 0 0 3px #dedede;;border-top:4px solid #27bdff;background: #fff;padding:15px;display:none;">
                <div class="form-header clearfix" style="margin: 5px 0;">
                    <p style="font-size: 16px;font-weight:bold;float: left;"><i class="fa fa-save"></i><span style="margin-left: 10px;" id="renwuheader"></span>任务</p>
                    <span class="f-r close" style="margin-top: 3px;cursor: pointer"><i class="fa fa-times"></i></span>
                </div>
                <input id="sid" type="hidden" class="form-control" name="sid" value=""/>
                <input id="sname" type="hidden" class="form-control" name="sname" value=""/>
                <div class="clearfix">
                    <label for="title" class="f-l control-label">任务标题：</label>
                    <div class="f-l" style="position: relative;">
                        <input id="title" class="form-control con" name="title" value=""/><br/>

                    </div>
                </div>
                <div class="clearfix">
                    <label for="content" class="f-l control-label">任务内容：</label>
                    <div class="f-l" style="position: relative;">
                        <input id="content"  class="form-control con" name="content" value="" /><br/>

                    </div>
                </div>
                <div class="clearfix">
                    <label for="etime" class="f-l control-label">完成时间：</label>
                    <div class="f-l" style="position: relative;">
                        <input id="etime"  class="form-control con" name="etime" value="" title="结束时间不能小于开始时间，并且不能大于第二年年底"/><br/>

                    </div>
                </div>

                        <button type="submit" id="submit" class="button" style="width:78px;background:#27bdff;border:none;height:30px;border-radius: 3px;color:#fff;margin-left:66px;">确定</button>


            </g:form>
            <span style="display: none" id="sign">${sign}</span>
   </div>
        </section></section>
</section>

<!-- js placed at the end of the document so the pages load faster -->
<script src="${resource(dir: 'js', file: 'jquery.js')}"></script>
<script src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script class="include" type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dcjqaccordion.2.7.js')}"></script>
<script src="${resource(dir: 'js', file: 'jquery.scrollTo.min.js')}"></script>
<script src="${resource(dir: 'js', file: 'jquery.nicescroll.js')}" type="text/javascript"></script>
<script src="${resource(dir: 'js', file: 'jquery.sparkline.js')}" type="text/javascript"></script>
<script src="${resource(dir: 'assets/jquery-easy-pie-chart/', file: 'jquery.easy-pie-chart.js')}"></script>
<script src="${resource(dir: 'js', file: 'owl.carousel.js')}" ></script>
<script src="${resource(dir: 'js', file: 'jquery.customSelect.min.js')}" ></script>
<script src="${resource(dir: 'js', file: 'respond.min.js')}" ></script>

<!--right slidebar-->
<script src="${resource(dir: 'js', file: 'slidebars.min.js')}"></script>

<!--common script for all pages-->
<script src="${resource(dir: 'js', file: 'common-scripts.js')}"></script>

<!--script for this page-->
<script src="${resource(dir: 'js', file: 'sparkline-chart.js')}"></script>
<script src="${resource(dir: 'js', file: 'easy-pie-chart.js')}"></script>
<script src="${resource(dir: 'js', file: 'count.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-datepicker/js', file: 'bootstrap-datepicker.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-datetimepicker/js', file: 'bootstrap-datetimepicker.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-datetimepicker/js', file: 'bootstrap-datetimepicker.zh-CN.js')}"></script>
%{--<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-daterangepicker', file: 'moment.min.js')}"></script>--}%
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-daterangepicker', file: 'daterangepicker.js')}"></script>
%{--<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-colorpicker/js', file: 'bootstrap-colorpicker.js')}"></script>--}%
<script type="text/javascript" src="${resource(dir: 'assets/bootstrap-timepicker/js', file: 'bootstrap-timepicker.js')}"></script>
<script>
$(function(){
    var sign=$('#sign').html();


    if(sign!=''){
        var sid="${sid}";
        var sname="${sname}";
        $('#sid').val(sid);
        $('#sname').val(sname);
        $('#renwuheader').html(sname);
        $('#form').css('display','block');
    }
    $('.click').click(function() {
        var sname = $(this).html();
        var sid = $(this).next().html();
        $('#sid').val(sid)
        $('#sname').val(sname)
        $('#renwuheader').html(sname);
        $('#form').css('display','block');
    })
    $('.close').click(function(){
        $('.con').val('');
        $('#form').css('display','none')
    })
    $('#etime').datetimepicker({
        language:'zh-CN',
        format: 'yyyy-mm',
        startDate:new Date(),
        startView:3,
        minView:3,
        todayHighlight:true,
        autoclose: 1,
        pickerPosition: "bottom-left",
        forceParse: 0,　　


})
})

</script>
</body>
</html>