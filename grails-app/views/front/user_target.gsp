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

    <link href="${resource(dir: 'css', file: 'ownset.css')}" rel="stylesheet">
    <style>
        body{-webkit-text-size-adjust:none;}
        .btime,.etime{width:87px;height:25px;display:block;border:1px solid #d2d2d2;text-align:center;line-height:25px;}
        .btime{margin-right: 12px;}
        .tar_whole{border:1px solid #d2d2d2;width:250px;height:210px;margin:0 15px 15px 0;}
        .tar_title{padding:14px;border-bottom: 1px solid #d2d2d2}
        .tar_content{margin:20px 0;font-size:20px;line-height:56px;}
        .percent{clear: both;width:56px;height:56px;margin-left:10px;text-align:center;line-height:56px;border:3px solid #d2d2d2;border-radius: 50px;}
    </style>
</head>

<body>

<section id="container" >
    <!--header start-->
    <g:render template="header" />
    <!--header end-->
    <!--sidebar start-->
    <g:render template="siderbar" />
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <div class="col-tb">
                <div class="col-cell">
                    <div class="toolkit">
                        <span>我的目标</span>
                        <div class="shaixuan">
                            <a class="task-order">排序<i class="fa fa-caret-down"></i></a>
                            <ul>
                                <li>
                                    <a href="#">默认</a>
                                </li>
                                <li>
                                    <a href="#">按任务到期时间</a>
                                </li>
                                <li>
                                    <a href="#">按任务创建时间</a>
                                </li>
                                <li>
                                    <a href="#">按任务更新时间</a>
                                </li>
                            </ul>
                        </div>
                        <a href="#" id="newapply" class="f-r"><i class="fa fa-plus-circle"></i>新建目标</a>
                    </div>
                    <div class="content">
                        <div style="margin-top:20px;" class="clearfix">


                            <div class="tar_whole f-l">
                                <div class="tar_title clearfix" >
                                    <img class="f-l" src="${resource(dir:'img/target-img',file:'1.png')}" title="tar_img1"/>
                                    <div class="f-l" style="margin-left:10px;">
                                        <h2 style="font-size:20px;margin:4px;color:#40bdf5;">目标名称</h2>
                                        负责人：<span>艾瑞特</span>
                                    </div>
                                    <div style="font-size:20px;" class="f-r">

                                        <a href="#" style="margin-left: 10px;color:#40bdf5"><i class="fa fa-edit"></i></a>
                                        <a href="#" style="color:#40bdf5"><i class="fa fa-trash-o"></i></a>
                                    </div>
                                </div>

                                <div class="tar_content clearfix">
                                    <div class="f-l percent">0%</div>
                                    <div class="f-l"style="margin-left: 10px;">共<span>1</span>位同事参与</div>
                                </div>
                                <div class="clearfix" style="width:188px;margin:0 auto;">
                                    <span class="btime f-l">2015-04-25</span><span class="etime f-l">2015-04-30</span>
                                </div>

                            </div>

                            <div class="tar_whole f-l">
                                <div class="tar_title clearfix" >
                                    <img class="f-l" src="${resource(dir:'img/target-img',file:'1.png')}" title="tar_img1"/>
                                    <div class="f-l" style="margin-left:10px;">
                                        <h2 style="font-size:20px;margin:4px;color:#40bdf5;">目标名称</h2>
                                        负责人：<span>艾瑞特</span>
                                    </div>
                                    <div style="font-size:20px;" class="f-r">

                                        <a href="#" style="margin-left: 10px;color:#40bdf5"><i class="fa fa-edit"></i></a>
                                        <a href="#" style="color:#40bdf5"><i class="fa fa-trash-o"></i></a>
                                    </div>
                                </div>

                                <div class="tar_content clearfix">
                                    <div class="f-l percent">0%</div>
                                    <div class="f-l"style="margin-left: 10px;">共<span>1</span>位同事参与</div>
                                </div>
                                <div class="clearfix" style="width:188px;margin:0 auto;">
                                    <span class="btime f-l">2015-04-25</span><span class="etime f-l">2015-04-30</span>
                                </div>

                            </div>

                            <div class="tar_whole f-l">
                                <div class="tar_title clearfix" >
                                    <img class="f-l" src="${resource(dir:'img/target-img',file:'1.png')}" title="tar_img1"/>
                                    <div class="f-l" style="margin-left:10px;">
                                        <h2 style="font-size:20px;margin:4px;color:#40bdf5;">目标名称</h2>
                                        负责人：<span>艾瑞特</span>
                                    </div>
                                    <div style="font-size:20px;" class="f-r">

                                        <a href="#" style="margin-left: 10px;color:#40bdf5"><i class="fa fa-edit"></i></a>
                                        <a href="#" style="color:#40bdf5"><i class="fa fa-trash-o"></i></a>
                                    </div>
                                </div>

                                <div class="tar_content clearfix">
                                    <div class="f-l percent">0%</div>
                                    <div class="f-l"style="margin-left: 10px;">共<span>1</span>位同事参与</div>
                                </div>
                                <div class="clearfix" style="width:188px;margin:0 auto;">
                                    <span class="btime f-l">2015-04-25</span><span class="etime f-l">2015-04-30</span>
                                </div>

                            </div>

                            <div class="tar_whole f-l">
                                <div class="tar_title clearfix" >
                                    <img class="f-l" src="${resource(dir:'img/target-img',file:'1.png')}" title="tar_img1"/>
                                    <div class="f-l" style="margin-left:10px;">
                                        <h2 style="font-size:20px;margin:4px;color:#40bdf5;">目标名称</h2>
                                        负责人：<span>艾瑞特</span>
                                    </div>
                                    <div style="font-size:20px;" class="f-r">

                                        <a href="#" style="margin-left: 10px;color:#40bdf5"><i class="fa fa-edit"></i></a>
                                        <a href="#" style="color:#40bdf5"><i class="fa fa-trash-o"></i></a>
                                    </div>
                                </div>

                                <div class="tar_content clearfix">
                                    <div class="f-l percent">0%</div>
                                    <div class="f-l"style="margin-left: 10px;">共<span>1</span>位同事参与</div>
                                </div>
                                <div class="clearfix" style="width:188px;margin:0 auto;">
                                    <span class="btime f-l">2015-04-25</span><span class="etime f-l">2015-04-30</span>
                                </div>

                            </div>

                            <div class="tar_whole f-l">
                                <div class="tar_title clearfix" >
                                    <img class="f-l" src="${resource(dir:'img/target-img',file:'1.png')}" title="tar_img1"/>
                                    <div class="f-l" style="margin-left:10px;">
                                        <h2 style="font-size:20px;margin:4px;color:#40bdf5;">目标名称</h2>
                                        负责人：<span>艾瑞特</span>
                                    </div>
                                    <div style="font-size:20px;" class="f-r">

                                        <a href="#" style="margin-left: 10px;color:#40bdf5"><i class="fa fa-edit"></i></a>
                                        <a href="#" style="color:#40bdf5"><i class="fa fa-trash-o"></i></a>
                                    </div>
                                </div>

                                <div class="tar_content clearfix">
                                    <div class="f-l percent">0%</div>
                                    <div class="f-l"style="margin-left: 10px;">共<span>1</span>位同事参与</div>
                                </div>
                                <div class="clearfix" style="width:188px;margin:0 auto;">
                                    <span class="btime f-l">2015-04-25</span><span class="etime f-l">2015-04-30</span>
                                </div>

                            </div>



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
<!--新建弹层 start-->
<div class="passwordedit" id="newapplydetail">
    <div class="m_box" style="width:804px;">
        <header class="panel-heading" style="padding:10px 28px;">
            <span><i class="yh"></i>添加新目标</span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>

        <ul>
            <li class="clearfix">
                <div align="right" class="f-l" style="margin-right: 10px;"><img src="${resource(dir:'img/target-img',file:'1.png')}"></div>
                <div class="f-l">
                    <input type="text" name="title" placeholder="添加目标名称" style="width:682px;height:38px;border:1px solid #d2d2d2;margin-top: 5px;"/>
                </div>

            </li>
            <li>
                <textarea name="content" rows="4" placeholder="这里可以添加目标详情" style="width:100%;height:68px;resize: none;"></textarea>
            </li>
            <li>
            <table width="100%" class="table table-bordered" style="border-spacing: 0;">
                <tr>
                    <th style="text-align: center;width:15%;background:#f8f8f8">负责人</th>
                    <td width="85%"><input  name="fzuid" style="border:none;width:100%"/></td>

                </tr>
                <tr>
                    <th style="text-align:center;width:15%;background:#f8f8f8" >起止日</th>
                    <td>
                        <input type="text" name="btime" style="width:88px;height:28px;"/>-
                        <input type="text" name="etime" style="width:88px;height:28px;"/>
                    </td>

                </tr>
             </li>
        </ul>
    </div>
</div>
<!--新建弹层 end-->
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
        $(document).ready(function() {
            /*$(window).bind('resize load', function(){

                $(".wrapper_reset").css("zoom",$(window).width()/1920);
                $(".wrapper_reset").find().css("zoom",$(window).width()/1920);
                $(".wrapper_reset").find().css("-moz-transform","scale("+$(window).width()/1920+")");
                $(".wrapper_reset").find().css("-moz-transform-origin","top left");


            });*/
            $("#newapply").click(function(){
                $("#newapplydetail").css("display","block");
            });
            $(".close").click(function(){
                $("#newapplydetail").css("display","none");
            });
            $(".toolkit .task-order").click(function () {
                var ul = $(".toolkit .shaixuan ul");

                if (ul.css("display") == "none") {
                    ul.slideDown("fast");
                    $(".toolkit .task-order").css("border-bottom", "1px solid #fff");
                } else {
                    ul.slideUp("fast");
                    $(".toolkit .task-order").css("border-bottom", "none");
                }
        });

            /* $("#newapply").click(function(){
                $("#newapplydetail").css("display","block");
            });
            $(".close").click(function(){
                $("#newapplydetail").css("display","none");
            });

            $("#apply_tab tr").click(function(){
                $("#applydetails").css("display","block");
            })
            $(".close").click(function(){
                $("#applydetails").css("display","none");
            });*/

        })
    </script>
    %{--<script>--}%

    %{--//owl carousel--}%

    %{--$(document).ready(function() {--}%
    %{--$("#owl-demo").owlCarousel({--}%
    %{--navigation : true,--}%
    %{--slideSpeed : 300,--}%
    %{--paginationSpeed : 400,--}%
    %{--singleItem : true,--}%
    %{--autoPlay:true--}%

    %{--});--}%
    %{--});--}%

    %{--//custom select box--}%

    %{--$(function(){--}%
    %{--$('select.styled').customSelect();--}%
    %{--});--}%

    %{--</script>--}%

</body>
</html>