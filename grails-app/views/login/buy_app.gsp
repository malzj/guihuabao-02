<%--
  Created by IntelliJ IDEA.
  User: karl
  Date: 2015/9/16
  Time: 9:45
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
</head>

<body>

<section id="container" >
    <!--header start-->
    <g:render template="header" />
    <!--header end-->
    <!--sidebar start-->
    <g:render template="buy_siderbar" />
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper mt80">
            <div class="middle_content clearfix">
                    %{--<div class="m_box ">--}%
                    <div style="width:49%;height:100%;border:1px solid #d2d2d2;background-color: #fff;" class="f-l">
                        <header class="panel-heading">
                            <span>所有应用</span>
                        </header>
                        <ul id="ul1" class="xsreport clearfix" style="text-align: center;width:100%;height:100%" ondrop="drop(event)" ondragover="allowDrop(event)" style="width:100%;height:100%">
                            <g:each in="${appsInstanceList}" status="i" var="app">
                                <li draggable="true" ondragstart="drag(event)" id="${i}" style="border-radius: 50px; border: 1px solid #d0d0d0;width:90px;height:90px;line-height: 90px;">${app.appName}</li>
                            </g:each>
                        </ul>
                    </div>
                    <div style="width:49%;height:100%;border:1px solid #d2d2d2;background-color: #fff;" class="f-r">
                        <header class="panel-heading">
                            <span>已购买应用</span>
                        </header>
                        <ul id="ul2" class="xsreport clearfix" style="text-align: center;width:100%;height:100%" ondrop="drop(event)" ondragover="allowDrop(event)" >
                            <g:each in="${buyappInstance}" status="i" var="app">
                                <li draggable="true" ondragstart="drag(event)" id="${i}" style="border-radius: 50px; border: 1px solid #d0d0d0;width:90px;height:90px;line-height: 90px;">${app.name}</li>
                            </g:each>
                        </ul>
                    </div>
                    %{--</div>--}%
                </div>
            </section>
            <!--main content end-->

        </section>
    </div>
</section>
<!-- js placed at the end of the document so the pages load faster -->
<script src="${resource(dir: 'js', file: 'jquery.js')}"></script>
<script src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script type="text/javascript">
    function allowDrop(ev)
    {
        var ev=ev||window.event;
        ev.preventDefault();
    }

    function drag(ev)
    {
        var ev=ev||window.event;
        ev.dataTransfer.setData("Text",ev.target.id);

    }

    function drop(ev)
    {

        var ev=ev||window.event;
        ev.preventDefault();
        var data=ev.dataTransfer.getData("Text");
        var li=document.getElementById(data);
        ev.target.appendChild(li);

    }
</script>
</body>
</html>