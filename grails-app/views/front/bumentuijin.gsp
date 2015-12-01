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
    dd{text-align: center;border:1px solid #dedede;border-bottom: none;height:40px;line-height: 40px;cursor: pointer;overflow:hidden;}
    input:hover{background:#27bdff;color:#fff;}
    li.liebiao{bottom: 0px;width:100%;}
    form{margin-bottom:0px;}
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
                    <div style="position: relative;margin-bottom: 20px;" >
                        <div class="test-title">${sname}工作推进</div>
                        <button  id="nextyear" style="position: absolute;right:40px;top:0;text-align:center;line-height:37px;width:86px;background:#27bdff;border:none;height:37px;border-radius: 3px;color:#fff;font-size:14px;">下一年</button>
                        <button  id="prevyear" style="position: absolute;right:146px;top:0;text-align:center;line-height:37px;width:86px;background:#27bdff;border:none;height:37px;border-radius: 3px;color:#fff;font-size:14px;">上一年</button>
                        <g:form url="[controller:'front',action:'bumentuijin']" style="display:none;" id="nextform">
                            <input name="year" value="${year+1}">
                            <input name="sid" value="${sid}">
                            <input name="sname" value="${sname}">
                        </g:form>
                        <g:form url="[controller:'front',action:'bumentuijin']" style="display:none;" id="prevform">
                            <input name="year" value="${year-1}">
                            <input name="sid" value="${sid}">
                            <input name="sname" value="${sname}">
                        </g:form>
                    </div>
                    %{--<p style="margin-top:10px;"><span class="tk1"></span><span>提示：点击部门按钮查看部门工作任务。</span></p>--}%
                    <div class="all-department1" style="border:none;background:#fff;padding:0;min-height:1px;position: relative;margin-bottom: 200px;font-size: 0;">
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month1list}" var="month1">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month1.title}"/></dd>
                                        <input name="sid" type="hidden" value="${month1.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>1月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month2list}" var="month2">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month2.title}"/></dd>
                                        <input name="sid" type="hidden" value="${month2.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>2月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month3list}" var="month3">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month3.title}"/></dd>
                                        <input name="sid" type="hidden" value="${month3.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>3月</dt>
                            </li>
                        </ul>

                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month4list}" var="month4">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month4.title}"/></dd>
                                        <input name="sid" type="hidden" value="${month4.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>4月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month5list}" var="month5">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month5.title}"/></dd>
                                        <input name="sid" type="hidden" value="${month5.id}"/>
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
                                        <input name="sid" type="hidden" value="${month6.sid}"/>
                                    </g:form>
                                </g:each>
                                <dt>6月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month7list}" var="month7">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month7.title}"/></dd>
                                        <input name="sid" type="hidden" value="${month7.id}"/>
                                    </g:form>
                                </g:each>


                                <dt>7月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month8list}" var="month8">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month8.title}"/></dd>
                                        <input name="sid" type="hidden" value="${month8.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>8月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month9list}" var="month9">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month9.title}"/></dd>
                                        <input name="sid" type="hidden" value="${month9.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>9月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month10list}" var="month10">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month10.title}"/></dd>
                                        <input name="sid" type="hidden" value="${month10.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>10月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month11list}" var="month11">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month11.title}"/></dd>
                                        <input name="sid" type="hidden" value="${month11.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>11月</dt>
                            </li>
                        </ul>
                        <ul class="liebiao">
                            <li class="liebiao">
                                <g:each in="${month12list}" var="month12">
                                    <g:form url="[controller:'front',action:'bumentuijin']" style="margin-bottom:0 !important;">
                                        <dd><input name="sname" value="${month12.title}"/></dd>
                                        <input name="sid" type="hidden" value="${month12.id}"/>
                                    </g:form>
                                </g:each>
                                <dt>12月</dt>
                            </li>
                        </ul>
                        <g:link action="gongzuotuijin" class="button" style="display:block;text-align:center;line-height:37px;width:106px;background:#27bdff;border:none;height:37px;margin:50px auto;border-radius: 3px;color:#fff;font-size:14px;">返回上一步</g:link>
                    </div>


                </div>

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

<script>
    $(function(){
        $('input').attr('disabled','disabled')
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
//        $('dd').click(function(){
//            $(this).parent().submit();
//        });
    })

</script>
</body>
</html>