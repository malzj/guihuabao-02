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
    input{width:270px !important;}
       .line{margin:20px 20px 4px 20px;}

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
                                    <g:form url="[controller:'front',action:'bumenSelect']" style="display:none;">
                                         <input name="id" value="${selectDepartmentInstance.id}">
                                    </g:form>
                                </li>
                            </g:each>
                        </ul>
                    </div>
                </div>
                <div style="overflow: hidden;">
                <ul class="renwu-list clearfix" style="position: relative;width: 1024px;">
                    <g:each in="${bumenrenwulist}" var="bumenrenwuInstance">
                        <li class="renwu clearfix f-l" style="width:316px;margin:20px 24px 0 0;border:1px solid #dedede;box-shadow: 0 0 3px #dedede;;border-top:4px solid #27bdff;background: #fff;">


                            <div class="form-header clearfix" style="font-size: 16px;padding:15px;background:#fafafa;border-bottom: 1px solid #eee;">
                                <p style="font-weight:bold;float: left;margin:0;"><i class="fa fa-save"></i><span style="margin-left: 10px;">${bumenrenwuInstance.sname}</span>任务</p>
                                <span class="f-r" style="margin-left: 16px;margin-top: 3px;cursor: pointer;">
                                    %{--<g:link action="bumenrenwuDelete" id="${bumenrenwuInstance.id}" style="display:block;width:14px;height:14px;"><i class="fa fa-trash-o"></i></g:link>--}%
                                    <i class="fa fa-trash-o"></i>
                                    <g:form url="[controller:'front',action:'bumenrenwuDelete']" style="display:none;">
                                        <input name="id" value="${bumenrenwuInstance.id}">
                                    </g:form>
                                </span>
                                <span class="f-r" style="margin-top: 3px;cursor: pointer;">
                                    <i class="fa fa-edit"></i>
                                    <g:form url="[controller:'front',action:'bumenrenwuEdit']" style="display:none;">
                                        <input name="id" value="${bumenrenwuInstance.id}">
                                    </g:form>
                                </span>
                            </div>
                            <div >
                                <div class="line clearfix">
                                    <p class="f-l">任务标题：</p><p class="f-l" style="word-wrap:break-word;width:200px;" >${bumenrenwuInstance.title}</p>
                                </div>
                                <div class="line clearfix">
                                    <p class="f-l">任务内容：</p><p class="f-l" style="word-wrap:break-word;width:200px;" >${bumenrenwuInstance.content}</p>

                                </div>
                                <div class="line clearfix" style="margin-bottom:24px;">
                                    <p class="f-l">执行时间：</p><p class="f-l" style="word-wrap:break-word;width:200px;" >${bumenrenwuInstance.etime}</p>

                                </div>

                            </div>
                        </li>
                    </g:each>
                    </ul>
                </div>
                <div style="width:100%;">
                <g:link action="gongzuotuijin" class="button" style="display:block;text-align:center;line-height:30px;width:78px;background:#27bdff;border:none;height:30px;margin:50px auto;border-radius: 3px;color:#fff;">确认完成</g:link>
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

<!----瀑布流-->
<script src="${resource(dir: 'js', file: 'masonry.pkgd.min.js')}"></script>

<script>
$(function(){
    $('.click').click(function(){
        $(this).next().next().submit();
    })
    $('.fa-edit').click(function(){
        $(this).next().submit();
    })
    $('.fa-trash-o').click(function(){

        if(!confirm('确定删除么？')){
            return false
        }else{
            $(this).next().submit();
        }


    });
//    瀑布流
    $('.renwu-list').masonry({
        // options
        itemSelector: '.renwu'
    });

})

</script>
</body>
</html>