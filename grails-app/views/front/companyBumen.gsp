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
    <link href="${resource(dir: 'css', file: 'style.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'style-responsive.css')}" rel="stylesheet">

    <link href="${resource(dir: 'css', file: 'jquery.jOrgChart.css')}" rel="stylesheet">

    <link href="${resource(dir: 'css', file: 'ownset.css')}" rel="stylesheet">
    <style type="text/css">
    #chart table{margin: 0 auto;}
    .bumenmember{min-width:126px;background-color:#434a54; border-radius: 3px;-moz-border-radius: 3px;}
    .bumenmember.left .arrow{border-bottom: 8px solid transparent;border-top: 8px solid transparent;border-right:8px solid #434a54;display: block;height: 0;left: -7px;position: absolute;top: 13px;width: 0;}
    .bumenmember.right .arrow{border-bottom: 8px solid transparent;border-top: 8px solid transparent;border-left:8px solid #434a54;display: block;height: 0;right: -7px;position: absolute;top: 13px;width: 0;}
    .bumenmember ul{ margin-bottom: 0px !important;}
    .bumenmember li{height:35px; line-height:35px; color:#FFF; font-size:14px; padding:0 16px; border-top:1px solid #3d434d;}
    .bumenmember li.nbt{border-top:none !important;}
    </style>
    <style type="text/css">
    .layer{width:50%;height:50%;padding-bottom: 20px;background-color: #FFF;border-radius: 4px;position:absolute;top:24%;left:24%;z-index:1004;font-family: 'Microsoft YaHei','Open Sans', sans-serif;}
    .layer .panel-heading{height:45px; overflow: hidden;border-bottom:1px #d2d2d2 solid;background-color:#fff;margin-bottom:30px;}
    .layer .panel-heading span{font-size:16px;color:#666;}
    .layer .panel-heading span{margin:0 0 0 12px; padding-top:9px;}
    .layer .panel-heading span .yh{display:inline-block; height:21px; width:30px; background:url("../img/yh.png") no-repeat;}
    .layer .panel-heading .btn{ margin-left:10px; padding:2px 12px; }
    .layer .lay-content{padding: 0 25px 10px;}
    #over{width:100%;height:100%;opacity:0.8;filter:alpha(opacity=80);position:absolute;top:0;left:0;z-index:1003;background: #000;}
    </style>
</head>

<body>
<section id="container" >
    <!--header start-->
    <g:render template="header" />
    <div style="height:110px;"></div>
    <!--header end-->
    <!--sidebar start-->
    <div class="row">
        <div class="col-xs-2" style="height:100%"></div>
        <g:if test="${session.user.rid}">
            <g:render template="siderbar" />
        </g:if>
        <g:else>
            <g:render template="structuresiderbar" />
        </g:else>
        <!--sidebar end-->
        <!--main content start-->
        <section id="main-content" class="col-xs-10" style="padding-left: 0;">
            <section style="min-width:100%;display: inline-block;padding: 15px 0;">
                <div class="xstask">
                   <span>公司架构图</span>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div id="chart" style="background-color: #fff;height: 100%;border: 1px solid #d2d2d2;padding-top: 30px;"></div>
                    </div>
                </div>
            </section>
        </section>
    </div>


    <!--main content end-->

</section>
%{--<script src="${resource(dir: 'js', file: 'jquery.js')}"></script>--}%
<script src="${resource(dir: 'js', file: 'jquery.min.js')}"></script>
<script src="${resource(dir: 'js', file: 'jquery-ui.min.js')}"></script>
<script src="${resource(dir: 'js', file: 'jquery.jOrgChart.js')}"></script>
<script src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<script class="include" type="text/javascript" src="${resource(dir: 'js', file: 'jquery.dcjqaccordion.2.7.js')}"></script>
<script src="${resource(dir: 'js', file: 'jquery.scrollTo.min.js')}"></script>
<script src="${resource(dir: 'js', file: 'jquery.nicescroll.js')}" type="text/javascript"></script>




<script>
    jQuery(document).ready(function() {
        function bumenfor(bumenInfo){
            var html = '';
            html+='<li><div class="member" data-id="'+bumenInfo.id+'" data-cid="'+bumenInfo.cid+'">'+bumenInfo.name+'</div>';
            if(bumenInfo.subordinate) {
                html += '<ul>';
                for (var info in bumenInfo.subordinate) {
                    html+=bumenfor(bumenInfo.subordinate[info]);
                }
                html += '</ul>';
            }
            html+='</li>';
            return html;
        }
        function printStructure(bumenList){
            var html1='';
            var i=1;
            for(var info in bumenList){
                html1+='<ul id="org'+i+'" style="display:none;">';
                html1+=bumenfor(bumenList[info]);
                html1+='</ul><div id="chart'+i+'" class="orgChart"></div>';
                i++
            }
            return html1;
        }
        $.ajax({
            url:'${webRequest.baseUrl}/front/companyStructure',
            dataType: "jsonp",
            jsonp: "callback",
            success: function(data){
                if(data.bumenList){
                    var html2=printStructure(data.bumenList);
                    $('#chart').append(html2);
                }else{
                    alert("加载失败!")
                }
            },
            complete: function(){
                $("#org1").jOrgChart({
                    chartElement : '#chart1',
                    dragAndDrop  : false
                });
            }
        });
        var event = {

                        mouseover:function(){

                            var thisElement=$(this);
                            var id=$(this).attr('data-id');
                            var cid=$(this).attr('data-cid');
                            var etop=$(this).offset().top;
                            var eleft=$(this).offset().left;
                            var ewidth=$(this).outerWidth();
                            var ehight=$(this).outerHeight();
                            var winWidth=$(document).width();
                            var winHeight=$(document).height();

                            var listLeft;
                            var witchSide;
                            if(winWidth<(eleft+ewidth+150)){
                                listLeft=eleft-150;
                                witchSide='right';
                            }else{
                                listLeft=eleft+ewidth+20;
                                witchSide='left';
                            }
                            $.ajax({
                                url:'${webRequest.baseUrl}/front/bumenMemberList',
                                dataType: "jsonp",
                                jsonp: "callback",
                                async:false,
                                data:{id:id,cid:cid},
                                success: function(data) {

                                    var html3 = '<div class="bumenmember '+witchSide+'"style="position: absolute;top:'+etop+';left:'+listLeft+'"><div class="arrow"></div><ul>';
                                    if (data.result) {
                                        var i=1;
                                        var style;
                                        for (var info in data.bumenMemberList) {
                                            if(i==1){
                                                style=' class="nbt"';
                                            }else{
                                                style='';
                                            }
                                            html3 += '<li'+style+'>' + data.bumenMemberList[info].name +'-'+data.bumenMemberList[info].position+ '</li>';
                                            i++;
                                        }
                                    } else {

                                        html3 += '<li class="nbt">无成员</li>';
                                    }
                                    html3 += '</ul></div>';
                                    $('html').append(html3);
                                }
                            });
                        },

                        mouseout:function(){
                            $('.bumenmember').remove();
                        },
                        click:function(){
                            var id=$(this).attr('data-id');
                            var cid=$(this).attr('data-cid');
                            var winWidth=$(document).width();
                            var winHeight=$(document).height();
                            $.ajax({
                                url: '${webRequest.baseUrl}/front/bumenInfo',
                                dataType: "jsonp",
                                jsonp: "callback",
                                async: false,
                                data: {id: id, cid: cid},
                                success: function(data){
                                    var html4='<div class="layer"><header id="title" class="panel-heading"><span>'+data.bumenInfo.name+'职责描述</span>';
                                    html4+='<div class="close"><a href="javascript:;" class="fa fa-times"></a></div>';
                                    if(data.bumenInfo.responsibility){
                                        html4+='</header><div class="lay-content">'+data.bumenInfo.responsibility+'</div></div><div id="over"></div>'
                                    }else{
                                        html4+='</header><div class="lay-content">无</div></div><div id="over"></div>'
                                    }

                                    $('html').append(html4);
                                }
                            });
                        }

        }
        $(document).on(event,'.member');
        var x_max = $(window).width();
        var y_max = $(window).height();
        var div_width = $(".layer").width() + 2;//20是边框
        var div_height = $(".layer").height() + 2;
        var _x_max = x_max - div_width;//最大水平位置
        var _y_max = y_max - div_height;//最大垂直位置
        $(document).on("mousedown","#title",function(title){//title代表鼠标按下事件
            var point_x = title.pageX;//鼠标横坐标,有资料说pageX和pageY是FF独有,不过经过测试chrome和IE8是可以支持的,其余的浏览器没有装,没测
            var point_y = title.pageY;//鼠标纵坐标
            var title_x = $(this).offset().left;//标题横坐标
            var title_y = $(this).offset().top;//标题纵坐标
            $(document).bind("mousemove",function(move){
                $(this).css("cursor","move");
                var _point_x = move.pageX;//鼠标移动后的横坐标
                var _point_y = move.pageY;//鼠标移动后的纵坐标
                var _x = _point_x - point_x;//移动的水平距离
                var _y = _point_y - point_y;//移动的纵向距离
                // console.debug('水平位移: ' + _x + '垂直位移: ' + _y);
                var __x = _x + title_x;//窗口移动后的位置
                var __y = _y + title_y;//窗口移动后的位置
                __x > _x_max ? __x = _x_max : __x = __x;//水平位置最大为651像素
                __y > _y_max ?__y = _y_max : __y = __y;//垂直位置最大为300像素
                __x < 0 ? __x = 0 : __x = __x;//水平位置最小为0像素
                __y < 0 ?__y = 0 : __y = __y;//垂直位置最小为0像素
//                console.debug('标题X:' + title_x + '标题Y:' + title_y);
                $(".layer").css({"left":__x,"top":__y});
            });//绑定鼠标移动事件,这里绑定的是标题,但是如果移动到区域外的话会导致事件不触发
            $(document).mouseup(function(){
                $(this).unbind("mousemove");//鼠标抬起,释放绑定,防止松开鼠标后,指针移动窗口跟着移动
            });
        });
        $(document).on('click','#over,.close',function(){
            $('#over,.layer').remove();
        });
    });
</script>
<!--common script for all pages-->
<script src="${resource(dir: 'js', file: 'common-scripts.js')}"></script>
</body>
</html>