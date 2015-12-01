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
    body{background: #f1f2f7}
    th{font-weight: normal ;padding:5px 3px !important;}
    .toolkit{border:none;border-bottom:1px dashed #e5e5e5; }
    .content table{background:#e5e5e5;border:1px solid #fff;}
    .th1{background:#27bdff;color:#fff;}
    .th2{background:#c7eeff;color:#000;font-size: 14px;}
    .table-bordered>tbody>tr>td, .table-bordered>tbody>tr>th{border:1px solid #fff;}
    input{margin:0;padding:0;border:1px solid #e5e5e5;}
    .table-bordered>tbody>tr>td,.table>tbody>tr>td{padding:0;margin:0 !important;}
    .table tbody > tr > th.n,.table>tbody>tr>th.n{padding:0;margin:0 !important;}
    td.month{padding:10px !important;}
    textarea{padding:0 !important;}
    .th3{width:106px;font-size: 14px;}
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
    <li class="stp active">
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
                        <div class="toolkit" style="position: relative;">
                            <div style="width:200px;margin:0 auto;text-align: center;font-size: 26px;color:#27bdff">财务目标表单</div>
                            <g:link action="choose_date" style="display:block;position: absolute;right:0px;top:54px;text-align:center;padding:0;line-height:37px;width:86px;background:#27bdff;border:none;height:37px;border-radius: 3px;color:#fff;font-size:14px;">修改时间</g:link>
                        </div>
                        <div style="margin-top:10px;color:#000;">提示：此日期选择是您目标规划的时间区间，建议以两年为时间周期进行规划。</div>
                        <div class="content">
                        <div style="margin-top:20px;" class="clearfix">
                            <g:form url="[controller:'front',action:'caiwuUpdate']" method="post" class="form-horizontal" id="caiwu_targetup">
                                <table class="table table-bordered table1">
                                    <tr class="th1">
                                        <th class="th3"><input  disabled style="background:none;text-align: center;border:none;width:100%;" value="年份"></th>
                                        <th >当前</th>
                                        <th class="nf" colspan="12" >--</th>



                                    </tr>

                                    <tr>
                                        <th class="th2 th3">月份</th>
                                        <td class="th2 n"></td>
                                        <td class="th2 month">1月</td>
                                        <td class="th2 month">2月</td>
                                        <td class="th2 month">3月</td>
                                        <td class="th2 month">4月</td>
                                        <td class="th2 month">5月</td>
                                        <td class="th2 month">6月</td>
                                        <td class="th2 month">7月</td>
                                        <td class="th2 month">8月</td>
                                        <td class="th2 month">9月</td>
                                        <td class="th2 month">10月</td>
                                        <td class="th2 month">11月</td>
                                        <td class="th2 month">12月</td>

                                    </tr>
                                    <tr>
                                        <th class="th2 th3">营收（万元）</th>
                                        <th class="n"><input class="gmt con n" name="n1"/></th>
                                        <td><input class="gmt con y" name="y1"/></td>
                                        <td><input class="gmt con y" name="y2"/></td>
                                        <td><input class="gmt con y" name="y3"/></td>
                                        <td><input class="gmt con y" name="y4"/></td>
                                        <td><input class="gmt con y" name="y5"/></td>
                                        <td><input class="gmt con y" name="y6"/></td>
                                        <td><input class="gmt con y" name="y7"/></td>
                                        <td><input class="gmt con y" name="y8"/></td>
                                        <td><input class="gmt con y" name="y9"/></td>
                                        <td><input class="gmt con y" name="y10"/></td>
                                        <td><input class="gmt con y" name="y11"/></td>
                                        <td><input class="gmt con y" name="y12"/></td>

                                    </tr>
                                    <tr>
                                        <th class="th2 th3">毛利率（%）</th>
                                        <th  class="n"><input class="gmt con n" name="n2"/></th>
                                        <td><input class="gmt con m" name="m1"/></td>
                                        <td><input class="gmt con m" name="m2"/></td>
                                        <td><input class="gmt con m" name="m3"/></td>
                                        <td><input class="gmt con m" name="m4"/></td>
                                        <td><input class="gmt con m" name="m5"/></td>
                                        <td><input class="gmt con m" name="m6"/></td>
                                        <td><input class="gmt con m" name="m7"/></td>
                                        <td><input class="gmt con m" name="m8"/></td>
                                        <td><input class="gmt con m" name="m9"/></td>
                                        <td><input class="gmt con m" name="m10"/></td>
                                        <td><input class="gmt con m" name="m11"/></td>
                                        <td><input class="gmt con m" name="m12"/></td>

                                    </tr>
                                    <tr>
                                        <th class="th2 th3">净利润（万元）</th>
                                        <th class="n"><input class="gmt con n" name="n3"/></th>
                                        <td><input class="gmt con j" name="j1"/></td>
                                        <td><input class="gmt con j" name="j2"/></td>
                                        <td><input class="gmt con j" name="j3"/></td>
                                        <td><input class="gmt con j" name="j4"/></td>
                                        <td><input class="gmt con j" name="j5"/></td>
                                        <td><input class="gmt con j" name="j6"/></td>
                                        <td><input class="gmt con j" name="j7"/></td>
                                        <td><input class="gmt con j" name="j8"/></td>
                                        <td><input class="gmt con j" name="j9"/></td>
                                        <td><input class="gmt con j" name="j10"/></td>
                                        <td><input class="gmt con j" name="j11"/></td>
                                        <td><input class="gmt con j" name="j12"/></td>

                                    </tr>
                                    <tr>
                                        <th class="th2 th3">评效比（数值）</th>
                                        <th class="n"><input class="gmt con n" name="n4"/></th>
                                        <td><input class="gmt con p" name="p1"/></td>
                                        <td><input class="gmt con p" name="p2"/></td>
                                        <td><input class="gmt con p" name="p3"/></td>
                                        <td><input class="gmt con p" name="p4"/></td>
                                        <td><input class="gmt con p" name="p5"/></td>
                                        <td><input class="gmt con p" name="p6"/></td>
                                        <td><input class="gmt con p" name="p7"/></td>
                                        <td><input class="gmt con p" name="p8"/></td>
                                        <td><input class="gmt con p" name="p9"/></td>
                                        <td><input class="gmt con p" name="p10"/></td>
                                        <td><input class="gmt con p" name="p11"/></td>
                                        <td><input class="gmt con p" name="p12"/></td>

                                    </tr>
                                </table>
                                <table class="table table-bordered table2">
                                    <tr class="th1">
                                        <th class="th3"><input  disabled style="background:none;text-align: center;border:none;width:100%;" value="年份"></th>
                                        <th >当前</th>
                                        <th class="nf" colspan="12">--</th>



                                    </tr>

                                    <tr>
                                        <th class="th2 th3">月份</th>
                                        <td class="th2 "></td>
                                        <td class="th2 month">1月</td>
                                        <td class="th2 month">2月</td>
                                        <td class="th2 month">3月</td>
                                        <td class="th2 month">4月</td>
                                        <td class="th2 month">5月</td>
                                        <td class="th2 month">6月</td>
                                        <td class="th2 month">7月</td>
                                        <td class="th2 month">8月</td>
                                        <td class="th2 month">9月</td>
                                        <td class="th2 month">10月</td>
                                        <td class="th2 month">11月</td>
                                        <td class="th2 month">12月</td>

                                    </tr>
                                    <tr>
                                        <th class="th2 th3">营收（万元）</th>
                                        <th class="n"><input class="gmt con "/></th>
                                        <td><input class="gmt con y" name="y13"/></td>
                                        <td><input class="gmt con y" name="y14"/></td>
                                        <td><input class="gmt con y" name="y15"/></td>
                                        <td><input class="gmt con y" name="y16"/></td>
                                        <td><input class="gmt con y" name="y17"/></td>
                                        <td><input class="gmt con y" name="y18"/></td>
                                        <td><input class="gmt con y" name="y19"/></td>
                                        <td><input class="gmt con y" name="y20"/></td>
                                        <td><input class="gmt con y" name="y21"/></td>
                                        <td><input class="gmt con y" name="y22"/></td>
                                        <td><input class="gmt con y" name="y23"/></td>
                                        <td><input class="gmt con y" name="y24"/></td>

                                    </tr>
                                    <tr>
                                        <th class="th2 th3">毛利率（%）</th>
                                        <th class="n"><input class="gmt con "/></th>
                                        <td><input class="gmt con m" name="m13"/></td>
                                        <td><input class="gmt con m" name="m14"/></td>
                                        <td><input class="gmt con m" name="m15"/></td>
                                        <td><input class="gmt con m" name="m16"/></td>
                                        <td><input class="gmt con m" name="m17"/></td>
                                        <td><input class="gmt con m" name="m18"/></td>
                                        <td><input class="gmt con m" name="m19"/></td>
                                        <td><input class="gmt con m" name="m20"/></td>
                                        <td><input class="gmt con m" name="m21"/></td>
                                        <td><input class="gmt con m" name="m22"/></td>
                                        <td><input class="gmt con m" name="m23"/></td>
                                        <td><input class="gmt con m" name="m24"/></td>

                                    </tr>
                                    <tr>
                                        <th class="th2 th3">净利润（万元）</th>
                                        <th class="n"><input class="gmt con "/></th>
                                        <td><input class="gmt con j" name="j13"/></td>
                                        <td><input class="gmt con j" name="j14"/></td>
                                        <td><input class="gmt con j" name="j15"/></td>
                                        <td><input class="gmt con j" name="j16"/></td>
                                        <td><input class="gmt con j" name="j17"/></td>
                                        <td><input class="gmt con j" name="j18"/></td>
                                        <td><input class="gmt con j" name="j19"/></td>
                                        <td><input class="gmt con j" name="j20"/></td>
                                        <td><input class="gmt con j" name="j21"/></td>
                                        <td><input class="gmt con j" name="j22"/></td>
                                        <td><input class="gmt con j" name="j23"/></td>
                                        <td><input class="gmt con j" name="j24"/></td>

                                    </tr>
                                    <tr>
                                        <th class="th2 th3">评效比（数值）</th>
                                        <th class="n"><input class="gmt con " name="n4"/></th>
                                        <td><input class="gmt con p" name="p13"/></td>
                                        <td><input class="gmt con p" name="p14"/></td>
                                        <td><input class="gmt con p" name="p15"/></td>
                                        <td><input class="gmt con p" name="p16"/></td>
                                        <td><input class="gmt con p" name="p17"/></td>
                                        <td><input class="gmt con p" name="p18"/></td>
                                        <td><input class="gmt con p" name="p19"/></td>
                                        <td><input class="gmt con p" name="p20"/></td>
                                        <td><input class="gmt con p" name="p21"/></td>
                                        <td><input class="gmt con p" name="p22"/></td>
                                        <td><input class="gmt con p" name="p23"/></td>
                                        <td><input class="gmt con p" name="p24"/></td>

                                    </tr>
                                </table>
                                <input type="hidden" id="caiwuId" name="id" value="${caiwuInstance.id}"/>

                                </div>

                            </g:form>
                            <div class="clearfix" style="width:300px;margin:46px auto 140px;">
                                <g:form url="[controller:'front',action:'guimo_target']" method="post" id="guimo_target" class="form-horizontal f-l">
                                    <input type="hidden" id="caiwuId" name="id" value="${guimoId}"/>
                                    <input type="hidden" id="caiwuId" name="isupdate" value="0"/>
                                    <input class="button" type="submit" form="guimo_target" style="width:120px;background:#27bdff;border:none;height:40px;border-radius: 3px;color:#fff;" value="返回上一步" >
                                </g:form>
                                <input type="submit"  class="button f-l" style="width:120px;background:#27bdff;border:none;height:40px;border-radius: 3px;color:#fff;margin-left:20px;" value="确认提交" form="caiwu_targetup"/>
                            </div>


                        </div>
                        <span style="display:none;" id="begintime">${caiwuInstance.begintime}</span>
                        <span style="display: none;" id="endtime">${caiwuInstance.endtime}</span>
                        <span  id="version" style="display: none;">${isupdate}</span>
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
        $('input.con').attr('disabled','disabled');
        $('input.con1').attr('disabled','disabled');
        $('input.n').removeAttr("disabled").css('background','#d2d2d2').css('border','1px solid #d2d2d2').parent().css('background','#d2d2d2');

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
        var isupdate=$('#version').html();
        if(byear==eyear){
            $('th.nf').eq(0).html(byear + '年');
            $('table.table2').css('display','none');
        }else {
            $('th.nf').eq(0).html(byear + '年');
            $('th.nf').eq(1).html(eyear + '年');

        }
        var k=0;
        var j=1;
        var index=bmonth-1;
        var caiwuId=$('#caiwuId').val();
        $.ajax({
            url: '${webRequest.baseUrl}/front/caiwuAjax',
            method: 'post',
            dataType: 'json',
            data: {id:caiwuId},
            success: function (data) {

                for(var i=0;i<=smonth;i++) {

//                    k=bmonth+i;

//                    if(k<=12) {



                        $('input.j').eq(index).removeAttr("disabled").css('background','#d2d2d2').css('border','1px solid #d2d2d2').parent().css('background','#d2d2d2')
                        $('input.m').eq(index).removeAttr("disabled").css('background','#d2d2d2').css('border','1px solid #d2d2d2').parent().css('background','#d2d2d2')
                        $('input.p').eq(index).removeAttr("disabled").css('background','#d2d2d2').css('border','1px solid #d2d2d2').parent().css('background','#d2d2d2')
                        $('input.y').eq(index).removeAttr("disabled").css('background','#d2d2d2').css('border','1px solid #d2d2d2').parent().css('background','#d2d2d2')




                        index++;



                }
                for(var i=0;i<24;i++){
                    var p='p'+(i+1);
                    var m='m'+(i+1);
                    var y='y'+(i+1);
                    var j='j'+(i+1);
                    var p1=data.caiwuInstance[p];
                    var m1=data.caiwuInstance[m];
                    var y1=data.caiwuInstance[y];
                    var j1=data.caiwuInstance[j];
                    if(isupdate=='0'){
                        $('input.j').eq(i).val(j1)
                        $('input.m').eq(i).val(m1)
                        $('input.p').eq(i).val(p1)
                        $('input.y').eq(i).val(y1)
                    }else{
                        $('input.j').eq(i).val('')
                        $('input.m').eq(i).val('')
                        $('input.p').eq(i).val('')
                        $('input.y').eq(i).val('')

                    }
                }
                for(var i=0;i<8;i++){
                    var n='n'+(i+1);
                    var n1=data.caiwuInstance[n];
                    if(isupdate=='0') {
                        $('input.n').eq(i).val(n1)
                    }else{
                        $('input.n').eq(i).val('')
                    }
                }
            },
            error: function () {
                alert('获取数据失败');
            }
        });

        $('input').focus(function(){
            $(this).css('border','1px solid #27bdff')

        })
        $('input').blur(function(){
            $(this).css('border','1px solid #d2d2d2')
        })
    })

</script>
</body>
</html>