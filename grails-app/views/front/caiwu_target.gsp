<%--
  Created by IntelliJ IDEA.
  User: karl
  Date: 2015/7/28
  Time: 10:13
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html style="overflow-x:hidden;overflow-y:auto!important;">
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

    .gmt{width:100%;height:100%;background:#e5e5e5;border:none;text-align: center;}
    .gmt1{width:100%;height:100%;background:#c7eeff;border:none;text-align: center;}
    th,td{text-align:center;}
    body{background:#fff;}
    .toolkit{border:none;border-bottom:1px dashed #e5e5e5; }
    .content table{background:#e5e5e5;border:1px solid #fff;}
    .th1{background:#27bdff;color:#fff;}
    .th2{background:#c7eeff;color:#000;}
    .table-bordered>tbody>tr>td, .table-bordered>tbody>tr>th{border:1px solid #fff;}
    input{margin:0;padding:0;border:1px solid #e5e5e5;}
    .table-bordered>tbody>tr>td,.table>tbody>tr>td{padding:0;margin:0 !important;}
    .table tbody > tr > th.jdc,.table>tbody>tr>th.jdc{padding:0;margin:0 !important;}
    td.month{padding:10px !important;}
    textarea{padding:0 !important;}
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
        <section id="main-content" class="col-xs-12">
            <section class="wrapper" style="width:90%;margin:0 auto;display:block;">
                <div class="col-tb">
                    <div class="col-cell">
                        <div class="toolkit">
                            <div style="width:200px;margin:0 auto;text-align: center;font-size: 26px;color:#27bdff">规划目标表单</div>
                        </div>
                        <div style="margin-top:10px;color:#000;">提示：此日期选择是您目标规划的时间区间，建议以两年为时间周期进行规划。</div>
                        <div class="content">
                        <div style="margin-top:20px;" class="clearfix">
                            <g:form url="[controller:'front',action:'caiwu_targetup']" method="post" class="form-horizontal" id="caiwu_targetup">
                                <table class="table table-bordered table1">
                                    <tr class="th1">
                                        <th><input  disabled style="background:none;text-align: center;border:none;width:100%;" value="年份"></th>
                                        <th >当前</th>
                                        <th class="nf">--</th>
                                        <th class="nf">--</th>


                                    </tr>

                                    <tr>
                                        <th class="th2">月份</th>
                                        <td class="th2"></td>
                                        <td class="th2 month">--</td>
                                        <td class="th2 month">--</td>
                                        <td class="th2 month">--</td>
                                        <td class="th2 month">--</td>
                                        <td class="th2 month">--</td>
                                        <td class="th2 month">--</td>
                                        <td class="th2 month">--</td>
                                        <td class="th2 month">--</td>
                                        <td class="th2 month">--</td>
                                        <td class="th2 month">--</td>
                                        <td class="th2 month">--</td>
                                        <td class="th2 month">--</td>
                                    </tr>
                                    <tr>
                                        <th class="th2">营收（万元）</th>
                                        <th><input class="gmt con"/></th>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                    </tr>
                                    <tr>
                                        <th class="th2">毛利率（%）</th>
                                        <th><input class="gmt con"/></th>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                    </tr>
                                    <tr>
                                        <th class="th2">净利润（万元）</th>
                                        <th><input class="gmt con"/></th>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                    </tr>
                                    <tr>
                                        <th class="th2">评效比（数值）</th>
                                        <th><input class="gmt con"/></th>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                        <td><input class="gmt con"/></td>
                                    </tr>
                                </table>
                                <input type="hidden" id="caiwuId" name="id" value="${caiwuInstance.id}"/>

                                </div>

                            </g:form>
                            <div class="clearfix" style="width:300px;margin:0 auto;">
                                <g:form url="[controller:'front',action:'guimo_target']" method="post" id="choose_date" class="form-horizontal f-l">
                                    <input class="button" type="submit" form="choose_date" style="width:120px;background:#27bdff;border:none;height:40px;border-radius: 3px;color:#fff;" value="返回上一步" >
                                </g:form>
                                <input type="submit"  class="button f-l" style="width:120px;background:#27bdff;border:none;height:40px;border-radius: 3px;color:#fff;margin-left:20px;" value="确认提交" form="caiwu_targetup"/>
                            </div>


                        </div>
                        <span style="display:none;" id="begintime">${caiwuInstance.begintime}</span>
                        <span style="display: none;" id="endtime">${caiwuInstance.endtime}</span>

                    </div>
                </div>

            </section>
            <!--main content end-->

        </section>


</section>
<!--评论及反馈 end-->
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
<script src="${resource(dir: 'js', file: 'jquery.form.js')}" ></script>
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


<!--菜单js-->
<script src="${resource(dir: 'js', file: 'advanced-form-components.js')}"></script>
<script src="${resource(dir: 'js', file: 'context.js')}"></script>
<!--right slidebar-->
<script src="${resource(dir: 'js', file: 'slidebars.min.js')}"></script>

<!--common script for all pages-->
<script src="${resource(dir: 'js', file: 'common-scripts.js')}"></script>

<!--script for this page-->
<script src="${resource(dir: 'js', file: 'sparkline-chart.js')}"></script>
<script src="${resource(dir: 'js', file: 'easy-pie-chart.js')}"></script>
<script src="${resource(dir: 'js', file: 'count.js')}"></script>

<!--上传图片预览 js-->
<script src="${resource(dir: 'js', file: 'uploadPreview.js')}"></script>
<script type="text/javascript">
    $(function(){

//        $('input.con').attr('disabled','disabled');
//        $('input.con1').attr('disabled','disabled');
        var begintime=$('#begintime').html();
        var endtime=$('#endtime').html();
        var bstr = begintime.replace(/-/g,"/");
        var estr = endtime.replace(/-/g,"/");
        var bdate = new Date(bstr);
        var edate=new Date(estr);

        var byear=bdate.getFullYear();
        var eyear=edate.getFullYear();

        var bmonth=bdate.getMonth()+1;
        var emonth=edate.getMonth()+1;
        var smonth=(eyear-byear)*12+(emonth-bmonth);
        if(byear==eyear){
            $('th.nf').eq(0).attr('colspan',smonth).html(byear);
            $('th.nf').eq(1).remove();
        }else{
            $('th.nf').eq(0).attr('colspan',12-bmonth+1).html(byear);
            $('th.nf').eq(1).attr('colspan',emonth).html(eyear);
        }

        var k=0;
        var j=1;
//        var y=1;
        var index=0;
//        var jdindex=getjd(bmonth);
        var caiwuId=$('#caiwuId').val();
        $.ajax({
            url: '${webRequest.baseUrl}/front/caiwuAjax',
            method: 'post',
            dataType: 'json',
            data: {id:caiwuId},
            success: function (data) {

                for(var i=0;i<=smonth;i++) {

                    k=bmonth+i;

                    if(k<=12) {

//                        var pro1='m'+(i+1)+'1';
//                        var pro2='m'+(i+1)+'2';
//                        var m1=data.guimoInstance[pro1];
//                        var m2=data.guimoInstance[pro2];

                        $('td.month').eq(index).html(k+'月');
//                        $('input.con').eq(index).attr("name",'m'+(i+1)+'1')
//                        $('input.con').eq(index).val(m1);
//                        $('input.con1').eq(index).val(m2);
//                        $('input.con1').eq(index).attr("name",'m'+(i+1)+'2');
//                        $('input.con').eq(index).removeAttr("disabled");
//                        $('input.con1').eq(index).removeAttr("disabled");
                        index++;
                    }else{
                        $('td.month').eq(index).html(j+'月');
//                        $('input.con').eq(index).attr("name",'m'+(i+1)+'1').val();
//                        $('input.con1').eq(index).attr("name",'m'+(i+1)+'2');
//                        $('input.con').eq(index).val(m1);
//                        $('input.con1').eq(index).val(m2);
//                        $('input.con').eq(index).removeAttr("disabled");
//                        $('input.con1').eq(index).removeAttr("disabled");
                        j++;
                        index++;
                    }


                }
            },
            error: function () {
                alert('获取数据失败');
            }
        });
//        for(var i=0;i<sjd;i++){
//            var a=jdindex+i;
//            if(a<=4){
//                $('th.jd').eq(i).html(byear+'年第'+a+'季度');
//            }else{
//                $('th.jd').eq(i).html(eyear+'年第'+y+'季度');
//                y++;
//            }
//
//        }

        $('input').focus(function(){
            $(this).css('border','1px solid #27bdff')

        })
        $('input').blur(function(){
            $(this).css('border','1px solid #e5e5e5')
        })
    })

</script>
</body>
</html>