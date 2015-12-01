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
        .toolkit{border:none;border-bottom:1px dashed #e5e5e5; }
        .content table{background:#e5e5e5;border:1px solid #fff;}
        .th1{background:#27bdff;color:#fff;}
        .th2{background:#c7eeff;color:#000;}
        .table-bordered>tbody>tr>td, .table-bordered>tbody>tr>th{border:1px solid #fff;}
        input{margin:0;padding:0;border:1px solid #e5e5e5;}
        .table-bordered>tbody>tr>td,.table>tbody>tr>td{padding:0;margin:0 !important;}
        .table tbody > tr > th.jdc,.table>tbody>tr>th.jdc{padding:0;margin:0 !important;}
        td.month{padding:10px !important;}
    </style>
</head>

<body>
%{--<div class="tishi" style="border:1px solid #000;background-color: pink;text-align: center;width:300px;height:80px;margin:250px auto;line-height:80px;position: fixed;z-index: 10000;display:none;">${params.msg}</div>--}%
%{--<section id="container1" style="width:100%;overflow-x:hidden;">--}%
    %{--<!--header start-->--}%
    %{--<g:render template="header" />--}%
    %{--<div style="height:110px;"></div>--}%
    %{--<!--header end-->--}%
    %{--<!--sidebar start-->--}%
    %{--<div class="row">--}%
        %{--<div class="col-xs-2" style="height:100%"></div>--}%
        %{--<g:render template="guihua_siderbar" />--}%
        %{--<!--sidebar end-->--}%
        %{--<!--main content start-->--}%
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
    <li class="stp ">
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
        %{--<section id="main-content" class="col-xs-12">--}%
            <section class="wrapper" style="width:100%;margin:0 auto;display:block;">
                <div class="col-tb">
                    <div class="col-cell">
                        <div class="toolkit" style="position: relative">
                            <div style="width:200px;margin:0 auto;text-align: center;font-size: 26px;color:#27bdff">规划目标表单</div>
                            <g:link action="choose_date" style="display:block;position: absolute;right:0px;top:54px;text-align:center;padding:0;line-height:37px;width:86px;background:#27bdff;border:none;height:37px;border-radius: 3px;color:#fff;font-size:14px;">修改时间</g:link>


                        </div>
                        <div style="margin-top:10px;color:#000;">提示：若修改时间，则规模目标和财务目标的内容将清空。</div>
                        <div class="content">
                            <div style="margin-top:20px;" class="clearfix">
                            <g:form url="[controller:'front',action:'guimoUpdate']" method="post" class="form-horizontal" id="caiwu_target">
                                <table class="table table-bordered table1">
                                    <tr class="th1">
                                        <th colspan="3">季度</th>
                                        <th colspan="3" class="jdb">--</th>
                                        <th colspan="3" class="jdb">--</th>
                                        <th colspan="3" class="jdb">--</th>
                                        <th colspan="3" class="jdb">--</th>
                                    </tr>
                                    <tr>
                                        <th colspan="3" class="th2">开店数量（家）</th>
                                        <th colspan="3" class="jdc"><input name="jd1" class="gmt"/></th>
                                        <th colspan="3" class="jdc"><input name="jd2" class="gmt"/></th>
                                        <th colspan="3" class="jdc"><input name="jd3" class="gmt"/></th>
                                        <th colspan="3" class="jdc"><input name="jd4" class="gmt"/></th>
                                    </tr>
                                    <tr>
                                        <th colspan="3" class="th2">月份</th>
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
                                        <th rowspan="2" colspan="2" class="th2"><textarea class="gmt1" disabled style="resize: none;overflow: hidden;">开店数量（家）</textarea></th>
                                        <th class="th2"><input class="gmt1" value="直营" disabled/></th>
                                        <td><input class="gmt con" name="m11"/></td>
                                        <td><input class="gmt con" name="m21"/></td>
                                        <td><input class="gmt con" name="m31"/></td>
                                        <td><input class="gmt con" name="m41"/></td>
                                        <td><input class="gmt con" name="m51"/></td>
                                        <td><input class="gmt con" name="m61"/></td>
                                        <td><input class="gmt con" name="m71"/></td>
                                        <td><input class="gmt con" name="m81"/></td>
                                        <td><input class="gmt con" name="m91"/></td>
                                        <td><input class="gmt con" name="m101"/></td>
                                        <td><input class="gmt con" name="m111"/></td>
                                        <td><input class="gmt con" name="m121"/></td>
                                    </tr>
                                    <tr>

                                        <th class="th2"><input name="jd1" class="gmt1" value="加盟" disabled/></th>
                                        <td><input class="gmt con1" name="m12"/></td>
                                        <td><input class="gmt con1" name="m22"/></td>
                                        <td><input class="gmt con1" name="m32"/></td>
                                        <td><input class="gmt con1" name="m42"/></td>
                                        <td><input class="gmt con1" name="m52"/></td>
                                        <td><input class="gmt con1" name="m62"/></td>
                                        <td><input class="gmt con1" name="m72"/></td>
                                        <td><input class="gmt con1" name="m82"/></td>
                                        <td><input class="gmt con1" name="m92"/></td>
                                        <td><input class="gmt con1" name="m102"/></td>
                                        <td><input class="gmt con1" name="m112"/></td>
                                        <td><input class="gmt con1" name="m122"/></td>
                                    </tr>
                                </table>
                                <table class="table table-bordered table2">
                                    <tr class="th1">
                                        <th colspan="3">季度</th>
                                        <th colspan="3" class="jde">--</th>
                                        <th colspan="3" class="jde">--</th>
                                        <th colspan="3" class="jde">--</th>
                                        <th colspan="3" class="jde">--</th>
                                    </tr>
                                    <tr>
                                        <th colspan="3" class="th2">开店数量（家）</th>
                                        <th colspan="3" class="jdc"><input name="jd5" class="gmt"/></th>
                                        <th colspan="3" class="jdc"><input name="jd6" class="gmt"/></th>
                                        <th colspan="3" class="jdc"><input name="jd7" class="gmt"/></th>
                                        <th colspan="3" class="jdc"><input name="jd8" class="gmt"/></th>
                                    </tr>
                                    <tr>
                                        <th colspan="3" class="th2">月份</th>
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
                                        <th rowspan="2" colspan="2" class="th2"><textarea class="gmt1" disabled style="resize: none;overflow: hidden;">开店数量（家）</textarea></th>
                                        <th class="th2"><input class="gmt1" value="直营" disabled/></th>
                                        <td><input class="gmt con" name="m131"/></td>
                                        <td><input class="gmt con" name="m141"/></td>
                                        <td><input class="gmt con" name="m151"/></td>
                                        <td><input class="gmt con" name="m161"/></td>
                                        <td><input class="gmt con" name="m171"/></td>
                                        <td><input class="gmt con" name="m181"/></td>
                                        <td><input class="gmt con" name="m191"/></td>
                                        <td><input class="gmt con" name="m201"/></td>
                                        <td><input class="gmt con" name="m211"/></td>
                                        <td><input class="gmt con" name="m221"/></td>
                                        <td><input class="gmt con" name="m231"/></td>
                                        <td><input class="gmt con" name="m241"/></td>
                                    </tr>
                                    <tr>

                                        <th class="th2"><input name="jd1" class="gmt1" value="加盟" disabled/></th>
                                        <td><input class="gmt con1" name="m132"/></td>
                                        <td><input class="gmt con1" name="m142"/></td>
                                        <td><input class="gmt con1" name="m152"/></td>
                                        <td><input class="gmt con1" name="m162"/></td>
                                        <td><input class="gmt con1" name="m172"/></td>
                                        <td><input class="gmt con1" name="m182"/></td>
                                        <td><input class="gmt con1" name="m192"/></td>
                                        <td><input class="gmt con1" name="m202"/></td>
                                        <td><input class="gmt con1" name="m212"/></td>
                                        <td><input class="gmt con1" name="m222"/></td>
                                        <td><input class="gmt con1" name="m232"/></td>
                                        <td><input class="gmt con1" name="m242"/></td>
                                    </tr>
                                </table>
                                <input type="hidden" id="guimoId" name="id" value="${guimoInstance.id}"/>
                                <input type="hidden" name="sign" value="new"/>
                                <input type="hidden" name="isupdate" value="${isupdate}"/>

                            </div>
                            </g:form>
                            <div class="clearfix" style="width:300px;margin:46px auto 140px;">
                                <g:form url="[controller:'front',action:'choose_date']" method="post" id="choose_date" class="form-horizontal f-l">
                                    <input type="hidden" name="isupdate" value="${isupdate}"/>
                                    <input class="button" type="submit" form="choose_date" style="width:120px;background:#fff;border:1px solid #d9d9d9;height:40px;border-radius: 3px;color:#000;" value="返回上一步" >
                                </g:form>
                                <input type="submit"  class="button f-l" style="width:120px;background:#27bdff;border:none;height:40px;border-radius: 3px;color:#fff;margin-left:20px;" value="确认提交" form="caiwu_target"/>
                            </div>


                            <span style="display:none;" id="begintime">${guimoInstance.begintime}</span>
                            <span style="display: none;" id="endtime">${guimoInstance.endtime}</span>
                            <span  id="isupdate" style="display: none;">${isupdate}</span>
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
     $('th.jdc input').attr('disabled','disabled');
     var isupdate=$('#isupdate').html();
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
     var sjd=Math.ceil(smonth/3)+1;
     var k=0;
     var j=1;
     var y=1;
     var index=bmonth-1;
     var jdindex=getjd(bmonth)-1;
     var guimoId=$('#guimoId').val();
     $.ajax({
         url: '${webRequest.baseUrl}/front/guimoAjax',
         method: 'post',
         dataType: 'json',
         data: {id:guimoId,begintime:begintime,endtime:endtime},
         success: function (data) {
             for(var i=0;i<sjd;i++){
                 $('th.jdc input').eq(jdindex).removeAttr('disabled').css('background','#d2d2d2').css('border','1px solid #d2d2d2').parent().css('background','#d2d2d2')
                 jdindex++;
             }
             for(var i=0;i<8;i++){
                 var j = 'jd' + (i + 1);
                 var j1 = data.guimoInstance[j];
                 $('th.jdc input').eq(i).val(j1);
             }
             for(var i=0;i<24;i++) {

                 k = bmonth + i;

                 var pro1 = 'm' + (i + 1) + '1';
                 var pro2 = 'm' + (i + 1) + '2';
                 var m1 = data.guimoInstance[pro1];
                 var m2 = data.guimoInstance[pro2];

//                     $('td.month').eq(index).html(k+'月');
//                     $('input.con').eq(index).attr("name",'m'+(i+1)+'1')
//                     $('input.con1').eq(index).attr("name",'m'+(i+1)+'2');
                     if(isupdate!='1') {
                         $('input.con').eq(i).val(m1);
                         $('input.con1').eq(i).val(m2);
                     }else{
                         $('input.con').val('');
                         $('input.con1').val('');
                         $('th.jdc input').val('');
                     }
             }
             for(var i=0;i<=smonth;i++) {
                 $('input.con').eq(index).removeAttr("disabled");
                 $('input.con1').eq(index).removeAttr("disabled");
                 $('input.con').eq(index).parent().css("background","#d2d2d2");
                 $('input.con1').eq(index).parent().css("background","#d2d2d2");
                 $('input.con').eq(index).css("border","1px solid #d2d2d2");
                 $('input.con1').eq(index).css("border","1px solid #d2d2d2");
                 $('input.con').eq(index).css("background","#d2d2d2");
                 $('input.con1').eq(index).css("background","#d2d2d2");
                     index++;

             }
         },
         error: function () {
            alert('获取数据失败');
         }
     });
     if(byear==eyear) {
         for (var i = 1; i <= 4; i++) {


             $('th.jdb').eq(i - 1).html(byear + '年第' + i + '季度');

            $('table.table2').css('display','none');
         }
     }else{
         for (var i = 1; i <= 4; i++) {


             $('th.jdb').eq(i - 1).html(byear + '年第' + i + '季度');

             $('th.jde').eq(i - 1).html(eyear + '年第' + i + '季度');
         }
     }

    $('input').focus(function(){
        $(this).css('border','1px solid #27bdff')

    })
     $('input').blur(function(){
         $(this).css('border','1px solid #d2d2d2')
     })
 })
    function getjd(month){
        var jd;
        switch (month){
            case 1:jd=1;break;
            case 2:jd=1;break;
            case 3:jd=1;break;
            case 4:jd=2;break;
            case 5:jd=2;break;
            case 6:jd=2;break;
            case 7:jd=3;break;
            case 8:jd=3;break;
            case 9:jd=3;break;
            case 10:jd=4;break;
            case 11:jd=4;break;
            case 12:jd=4;break;
        }
        return jd;
    }
//    function getmindex(month){
//        var index;
//        switch (month){
//            case 1:index=0;break;
//            case 2:index=1;break;
//            case 3:index=2;break;
//            case 4:index=0;break;
//            case 5:index=1;break;
//            case 6:index=2;break;
//            case 7:index=0;break;
//            case 8:index=1;break;
//            case 9:index=2;break;
//            case 10:index=0;break;
//            case 11:index=1;break;
//            case 12:index=2;break;
//        }
//        return index;
//    }
</script>



</body>
</html>