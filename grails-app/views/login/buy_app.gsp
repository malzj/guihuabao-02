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
    <link href="${resource(dir: 'assets/jquery-easy-pie-chart', file: 'jquery.easy-pie-chart.css')}"
          rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'owl.carousel.css')}" rel="stylesheet">

    <!--right slidebar-->
    <link href="${resource(dir: 'css', file: 'slidebars.css')}" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="${resource(dir: 'css', file: 'styleone.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'style-responsive.css')}" rel="stylesheet">

    <link href="${resource(dir: 'css', file: 'ownset.css')}" rel="stylesheet">
    <style>
    .c0{background-color: #3494ed;}
    .c1{background-color: #ed7159;}
    .c2{background-color: #4ec6a2;}
    .c3{background-color: #b772c7;}
    .c4{background-color: #56bc4e;}
    </style>
</head>

<body>

<section id="container" >
    <!--header start-->
    <g:render template="header" />
    <!--header end-->
    <!--sidebar start-->
    <div class="row">
        <g:render template="buy_siderbar" />
        <!--sidebar end-->
        <!--main content start-->
        <section id="main-content" class="col-xs-10" style="padding-left: 0;">
            <section class="wrapper">
                <div class="middle_content clearfix">
                    %{--<div class="m_box ">--}%
                    <div style="width:69%;min-height:100%;border:1px solid #d2d2d2;background-color: #fff;margin-right: 1%;" class="f-l">
                        <header class="panel-heading">
                            <span>授权应用——您可以将以下的授权应用拖拽到右侧，以方便您在导航栏中快速使用该功能</span>
                        </header>
                        <ul id="ul1" class="app clearfix" style="text-align: center;width:100%;height:100%"  style="width:100%;height:100%">
                            <g:each in="${appsInstanceList}" status="i" var="app">
                                <li draggable="true" ondragstart="drag(event)" id="${i}" style=" border-radius:5px;border: 1px solid #d0d0d0;width:90px;height:90px;position: relative;" class="c${app.id%5}">
                                    <img style="line-height: 72px;margin-bottom: 20px;" src="${resource(dir:'uploadfile/appimg',file:''+app.appImg+'')}" width="48px" height="48px"/>
                                    <div style="width:100%;height:100%;position: absolute;top:0;"></div>
                                    <span style="display: none;">${app.id}</span>
                                %{--<span style="margin-bottom: 10px;">${app.name}</span>--}%
                                        <a style="display: block;" >${app.appName}</a>
                                </li>

                            </g:each>
                        </ul>
                    </div>
                    <div style="width:30%;min-height:100%;border:1px solid #d2d2d2;background-color: #fff;" class="f-r">
                        <header class="panel-heading" style="margin-bottom: 0px;">
                            <span>显示在导航栏的应用</span>
                        </header>
                        <ul id="ul2" class="app clearfix" style="text-align: center;width:100%;height:100%" ondrop="drop(event)" ondragover="allowDrop(event)" >
                            <g:each in="${buyappInstance}"  var="app">
                                <div style="width:100%;border-bottom: 1px solid #d2d2d2;" class="clearfix">
                                    <li   style="border-radius:5px;border: 1px solid #d0d0d0;width:90px;height:90px;margin-bottom: 40px;margin-top: 20px;" class="c${app.appId%5}">
                                        <img src="${resource(dir:'uploadfile/appimg',file:''+app.img+'')}" width="48px" height="48px" style="margin-bottom: 20px;"/>

                                        <span>${app.name}</span>

                                    </li>
                                    %{--<div class="flag up"><img src="${resource(dir:'images/',file:'up.png')}" title="向上"/><p>上移</p></div>--}%
                                    <span style="display: none">${app.id}</span>
                                    %{--<div class="flag down"><img src="${resource(dir:'images/',file:'down.png')}" title="向下"/><p>下移</p></div>--}%
                                    <div class="flag delete"><img src="${resource(dir:'images/',file:'delete.png')}" title="删除"/><p>删除</p></div>
                                </div>
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
//        var ul2=document.getElementById('ul2');
//        if(ev.target==ul2){
//        if($('#ul2').children().length==4){
//            alert('最多只能显示4个应用！');
//
//        }else {
            var data = ev.dataTransfer.getData("Text");
            var li = document.getElementById(data);
            var aid=li.getElementsByTagName('span')[0].innerHTML

            $.ajax( {
                url:'${webRequest.baseUrl}/login/buyappSave',
                method:'post',
                dataType:'json',
                async:'false',
                data:{aid:aid,buycid:${params.cid}},
                success:function(data){
                    console.log(data.result)
                    if(!data.result){
                        alert(data.msg);
                        return;

                    }else{

                        ev.target.appendChild(li);
                        location.reload();
                    }
                },
                error:function(){
                    alert('获取数据失败！');
                    return;
                }

            })



//        }


    }
    $(function(){
        %{--$('.up').click(function(){--}%
            %{--var aid=$(this).next().html()--}%
            %{--$.ajax( {--}%
                %{--url:'${webRequest.baseUrl}/front/upApp',--}%
                %{--method:'post',--}%
                %{--dataType:'json',--}%
                %{--async:'false',--}%
                %{--data:{aid:aid},--}%
                %{--success:function(data){--}%
                    %{--if(data.result){--}%

                        %{--location.reload();--}%
                    %{--}else{--}%
                        %{--alert(data.msg)--}%
                    %{--}--}%
                %{--},--}%
                %{--error:function(){--}%
                    %{--alert('获取数据失败！')--}%
                %{--}--}%
            %{--})--}%

        %{--})--}%
        %{--$('.down').click(function(){--}%
            %{--var aid=$(this).prev().html()--}%
            %{--$.ajax( {--}%
                %{--url:'${webRequest.baseUrl}/front/downApp',--}%
                %{--method:'post',--}%
                %{--dataType:'json',--}%
                %{--async:'false',--}%
                %{--data:{aid:aid},--}%
                %{--success:function(data){--}%
                    %{--if(data.result){--}%

                        %{--location.reload();--}%
                    %{--}else{--}%
                        %{--alert(data.msg)--}%
                    %{--}--}%
                %{--},--}%
                %{--error:function(){--}%
                    %{--alert('获取数据失败！')--}%
                %{--}--}%
            %{--})--}%

        %{--})--}%
        $('.delete').click(function(){
            var aid=$(this).prev().html()
            $.ajax( {
                url:'${webRequest.baseUrl}/login/buyappDelete',
                method:'post',
                dataType:'json',
                async:'false',
                data:{aid:aid},
                success:function(data){
                    if(data.result){
                        alert(data.msg);
                        location.reload();
                    }else{
                        alert(data.msg)
                    }
                },
                error:function(){
                    alert('获取数据失败！')
                }
            })

        })
    })

</script>
</body>
</html>