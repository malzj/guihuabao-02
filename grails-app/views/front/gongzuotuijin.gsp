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
    <style>
    label{font-weight: normal;margin-top:7px;}
    input{width:75px;height:39px;border:none;text-align: center;cursor: pointer;}
    .line{margin:20px 20px 4px 20px;}
    ul.liebiao{display:inline-block;width:76px;margin:0px;font-size: 12px}
    dt{text-align: center;width:100%;border: 1px solid #dedede;border-bottom:none;height:40px;line-height: 40px;}
    dd{text-align: center;border:1px solid #dedede;border-bottom: none;height:40px;line-height: 40px;cursor: pointer;overflow: hidden;}

    li.liebiao{bottom: 0px;width:100%;}
        form{margin-bottom:0px;}
        .password input{text-align: left;}

    input:hover{background:#27bdff;color:#fff;}
    .form-control[readonly]{background:#fff;cursor:auto;}
    .passwordedit input{text-align: left;}
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
                    <div style="position: relative">
                        <div class="test-title">部门工作推进</div>
                        <button  id="nextyear" style="position: absolute;right:0px;top:74px;text-align:center;line-height:37px;width:86px;background:#27bdff;border:none;height:37px;border-radius: 3px;color:#fff;font-size:14px;">下一年</button>
                        <button  id="prevyear" style="position: absolute;right:106px;top:74px;text-align:center;line-height:37px;width:86px;background:#27bdff;border:none;height:37px;border-radius: 3px;color:#fff;font-size:14px;">上一年</button>
                        <g:form url="[controller:'front',action:'gongzuotuijin']" style="display:none;" id="nextform">
                            <input name="year" value="${year+1}">
                        </g:form>
                        <g:form url="[controller:'front',action:'gongzuotuijin']" style="display:none;" id="prevform">
                            <input name="year" value="${year-1}">
                        </g:form>
                    </div>
                    <p style="margin:10px 0 40px 0;"><span class="tk1"></span><span>提示：点击部门按钮查看部门工作任务。</span></p>
                    <div class="all-department1" style="border:none;background:#fff;padding:0;min-height:1px;position: relative;margin-bottom: 200px;font-size: 0;">
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month1list}" var="month1">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month1.sname}"/></dd>
                                        <input name="id" type="hidden" value="${month1.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>1月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month2list}" var="month2">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month2.sname}"/></dd>
                                        <input name="id" type="hidden" value="${month2.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>2月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month3list}" var="month3">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month3.sname}"/></dd>
                                        <input name="id" type="hidden" value="${month3.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>3月</dt>
                            </li>
                        </ul>

                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month4list}" var="month4">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month4.sname}"/></dd>
                                        <input name="id" type="hidden" value="${month4.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>4月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month5list}" var="month5">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month5.sname}"/></dd>
                                        <input name="id" type="hidden" value="${month5.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>5月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month6list}" var="month6">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month6.sname}"/></dd>
                                        <input name="id" type="hidden" value="${month6.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>6月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month7list}" var="month7">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month7.sname}"/></dd>
                                        <input name="id" type="hidden" value="${month7.id}"/>
                                    </g:form>
                                </g:each>


                                <dt>7月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month8list}" var="month8">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month8.sname}"/></dd>
                                        <input name="id" type="hidden" value="${month8.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>8月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month9list}" var="month9">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month9.sname}"/></dd>
                                        <input name="id" type="hidden" value="${month9.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>9月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month10list}" var="month10">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month10.sname}"/></dd>
                                        <input name="id" type="hidden" value="${month10.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>10月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month11list}" var="month11">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month11.sname}"/></dd>
                                        <input name="id" type="hidden" value="${month11.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>11月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month12list}" var="month12">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month12.sname}"/></dd>
                                        <input name="id" type="hidden" value="${month12.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>12月</dt>
                            </li>
                        </ul>
                        <div style="width:250px;margin:50px auto;">
                        <g:link action="bumenrenwuList" class="button" style="display:inline-block;text-align:center;line-height:37px;width:106px;background:#27bdff;border:none;height:37px;border-radius: 3px;color:#fff;font-size:14px;margin-right: 20px;">返回上一步</g:link>
                        <g:link action="programmeModule" class="button" style="display:inline-block;text-align:center;line-height:37px;width:106px;background:#27bdff;border:none;height:37px;border-radius: 3px;color:#fff;font-size:14px;">确定</g:link>
                        </div>
                    </div>


                </div>

            </div>
        </section></section>
</section>
<div class="passwordedit"  ">
    <g:form url="[controller:'front',action:'bumenrenwuAdd']" class="clearfix" id="form" style="width:370px;min-height:286px;margin:200px auto;border:1px solid #dedede;box-shadow: 0 0 3px #dedede;;border-top:4px solid #27bdff;background: #fff;padding:15px;">
        <div class="form-header clearfix" style="margin: 5px 0;">
            <p style="font-size: 16px;font-weight:bold;float: left;"><i class="fa fa-save"></i><span style="margin-left: 10px;" id="renwuheader"></span>任务</p>
            <span class="f-r close" style="margin-top: 3px;cursor: pointer"><i class="fa fa-times"></i></span>
        </div>
        %{--<input id="sid" type="hidden" class="form-control" name="sid" value=""/>--}%
        %{--<input id="sname" type="hidden" class="form-control" name="sname" value=""/>--}%
        <div class="clearfix">
            <label for="show_title" class="f-l control-label">任务标题：</label>
            <div class="f-l" style="position: relative;">
                <input id="show_title" readonly class="form-control con" name="title" value=""/><br/>

            </div>
        </div>
        <div class="clearfix">
            <label for="show_content" class="f-l control-label">任务内容：</label>
            <div class="f-l" style="position: relative;">
                <input id="show_content" readonly class="form-control con" name="content" value="" /><br/>

            </div>
        </div>
        <div class="clearfix">
            <label for="show_etime" class="f-l control-label">完成时间：</label>
            <div class="f-l" style="position: relative;">
                <input id="show_etime" readonly class="form-control con" name="etime" value="" title="结束时间不能小于开始时间，并且不能大于第二年年底"/><br/>

            </div>
        </div>

        %{--<button type="submit" id="submit" class="button" style="width:78px;background:#27bdff;border:none;height:30px;border-radius: 3px;color:#fff;margin-left:66px;">确定</button>--}%
        <div class="clearfix" style="margin-top: 20px;">
            <p class="f-l">职能提示：</p><p class="f-l" id="responsibility" style="word-wrap:break-word;width:200px;font-size:14px;" >${responsibility}</p>

        </div>

    </g:form>
</div>
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

<script>
    $(function(){
        $('input').attr('readonly','readonly');
        $('.fa-times').click(function(){
            $('.passwordedit').css('display','none');
        })
        var list=$('ul.liebiao')
        for(var i=1;i<list.length;i++) {
            $('ul.liebiao').eq(i).css('margin-left', '-1px')
        }
        $('#nextyear').click(function(){
            $('#nextform').submit();
        });
        $('#prevyear').click(function(){
            $('#prevform').submit();
        });
        $('dd').click(function(){

            var id=$(this).next().val();
            $.ajax({
                url: '${webRequest.baseUrl}/front/bumentuijinAjax',
                method: 'post',
                dataType: 'json',
                data: {id:id},
                success: function (data) {
                    if(data.result){
                        $('#show_title').val(data.renwuInstance.title)
                        $('#show_content').val(data.renwuInstance.content)
                        $('#show_etime').val(data.renwuInstance.etime)
                        $('#responsibility').html(data.responsibility)
                        $('.passwordedit').css('display','block')
                    }
                },
                error:function(){
                    alert('获取数据失败！');
                }
            })

        });
    })

</script>
</body>
</html>