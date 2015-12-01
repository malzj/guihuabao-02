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
                <ul class="pro-mod-list clearfix">
                    <li>
                        <g:link action="testResultShow">
                        <div class="pro-step">
                            <span>Step1</span>
                            <p class="pro-edit" data-href="${webRequest.baseUrl}/front/testResultShow"><i class="fa fa-edit tar_edit" title="编辑"></i></p>
                        </div>
                        <div class="pro-img">
                            <img src="${resource(dir: 'img', file: 'pro_mod1.png')}" />
                        </div>
                        <div class="pro-name">
                            现状评估
                        </div>
                        </g:link>
                    </li>
                    <li>
                        <g:link action="">
                        <div class="pro-step">
                            <span>Step2</span>
                            <p class="pro-edit" data-href=""><i class="fa fa-edit tar_edit" title="编辑"></i></p>
                        </div>
                        <div class="pro-img">
                            <img src="${resource(dir: 'img', file: 'pro_mod2.png')}" />
                        </div>
                        <div class="pro-name">
                            规模目标
                        </div>
                        </g:link>
                    </li>
                    <li class="mr0">
                        <g:link action="">
                        <div class="pro-step">
                            <span>Step3</span>
                            <p class="pro-edit" data-href=""><i class="fa fa-edit tar_edit" title="编辑"></i></p>
                        </div>
                        <div class="pro-img">
                            <img src="${resource(dir: 'img', file: 'pro_mod3.png')}" />
                        </div>
                        <div class="pro-name">
                            财务目标
                        </div>
                        </g:link>
                    </li>
                    <li>
                        <g:link action="">
                        <div class="pro-step">
                            <span>Step4</span>
                            <p class="pro-edit" data-href=""><i class="fa fa-edit tar_edit" title="编辑"></i></p>
                        </div>
                        <div class="pro-img">
                            <img src="${resource(dir: 'img', file: 'pro_mod4.png')}" />
                        </div>
                        <div class="pro-name">
                            组织架构
                        </div>
                        </g:link>
                    </li>
                    <li>
                        <g:link action="">
                        <div class="pro-step">
                            <span>Step5</span>
                            <p class="pro-edit" data-href=""><i class="fa fa-edit tar_edit" title="编辑"></i></p>
                        </div>
                        <div class="pro-img">
                            <img src="${resource(dir: 'img', file: 'pro_mod5.png')}" />
                        </div>
                        <div class="pro-name">
                            工作推进
                        </div>
                        </g:link>
                    </li>
                </ul>
            </div>
        </section>

    </section>

    <!-- js placed at the end of the document so the pages load faster -->
    <script src="${resource(dir: 'js', file: 'jquery.js')}"></script>
    <script type="text/javascript">
        $(function(){
            $('.pro-mod-list li .pro-step .pro-edit').click(function(){
                var eidt_href=$(this).attr('data-href');
                window.location.href=eidt_href;
            })
        });
    </script>

</body>
</html>