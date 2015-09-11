<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>规划宝-企业目标指挥中心</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0, minimal-ui">
    <meta name="apple-itunes-app" content="app-id=821470312">
    <meta name="renderer" content="webkit">
    <meta name="format-detection" content="telephone=no">
    <meta name="google-site-verification" content="_q2v0W-RqQOMxBr3X3JXBTBmwupe47Vu8mkb_ZDp6sk" />
    <meta name="searchtitle" content="团队云办公协作">
    <meta name="author" content="规划宝团队,http://www.guihuabao.cn">
    <meta name="copyright" content="本页版权归和许(科技)所有.All Rights Reserved">
    <meta name="title" content="OA">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <meta name="robots" content="index,follow">
    <meta name="application-name" content="guihuabao.cn">
    <link rel="shortcut icon" href="/favicon.ico">
    <link type="text/css" rel="stylesheet" href="${resource(dir: 'index/css/', file: 'base.css')}" />
    <link type="text/css" rel="stylesheet" href="${resource(dir: 'index/css/', file: 'common.css')}"  />
    <script src="${resource(dir: 'index/js/respond/', file: 'respond.min.js')}"></script>
    <link href="${resource(dir: 'index/js/respond/', file: 'respond-proxy.html')}" id="respond-proxy" rel="respond-proxy"/>
    <link href="${resource(dir: 'index/js/respond/', file: 'respond.proxy.gif')}" id="respond-redirect" rel="respond-redirect"/>
    <script src="${resource(dir: 'index/js/respond/', file: 'respond.proxy.js')}"></script>
    <!--[if IE 6]>
<script src="${resource(dir: 'index/js/', file: 'DD_belatedPNG.js')}"></script>
<script>
	document.execCommand("BackgroundImageCache", false, true);
    DD_belatedPNG.fix('.png');
</script>
<![endif]-->
    <!--[if lt IE 9]>
<script src="${resource(dir: 'index/js/', file: 'html5shiv.min.js')}"></script>
<![endif]-->
</head>
<body>
<input id="module" type="hidden" value="mobile">



<div class="site-head site-head-fixed">
    <div class="head-inner">
        <div class="eteams fl"><g:link controller="show" action="index" class="eteams-link"></g:link></div>
        <ul class="site-nav fl">
            <li class="nav-item">
                <g:link name="index" class="nav-link" controller="show" action="index">首页</g:link>
            </li>
            <li class="nav-item">
                <g:link name="product" class="nav-link" controller="show" action="function">功能</g:link>
            </li>
            <li class="nav-item">
                <g:link name="mobile" class="nav-link" controller="show" action="mobile">移动</g:link>
            </li>
            <li class="nav-item">
                <g:link name="cooperation" class="nav-link" controller="show" action="">帮助</g:link>
            </li>

        </ul>
        <div class="user-btns fr">
            <a class="btn-login" href="http://www.guihuabao.cn/guihuabao/front">登录</a>

        </div>
    </div>
</div>
<img class="banner" src='${resource(dir: 'index/img/', file: 'banner_1.png')}' />
<div class="all-container clearfix">
    <div class="menu f-l">
        <g:render template="leftnav" />
    </div>
    <div class="z-content f-r">
        <div class="contact clearfix">
            <div class="infos f-l">
                <h2>联系我们</h2>
                <p style="line-height:2.5em;">
                    和许（北京）科技有限公司<br />
                    商务合作：<br />
                    使用帮助：4000-555-959<br />
                    北京经济技术开发区荣华国际5号楼9层
                </p>
            </div>
            <div id="dituContent" class="c-map f-r">

            </div>
        </div>
        <div class="feedback">
            <h1>商务合作</h1>
            <p>请根据以下内容详细填写，我们会尽快安排专人与您联系。</p>
            <form>
                <table>
                    <tr>
                        <td><input type="text" name="companyname" placeholder="公司名称" /></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="name"  placeholder="姓名" /></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="telphone" placeholder="手机号" /></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="email" placeholder="邮箱" /></td>
                    </tr>
                    <tr>
                        <td><textarea name="content" placeholder="留言内容"></textarea></td>
                    </tr>
                    <tr>
                        <td><input type="submit" name="submit" value="提交" /></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>
<g:render template="footer" />
<!--引用百度地图 北京公司总部-->
<style type="text/css">
#dituContent img { max-width:500px; }
#dituContent1 img { max-width:500px; }
.iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
.iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}</style><script type="text/javascript" src="http://api.map.baidu.com/api?key=&amp;v=1.1&amp;services=true"></script><script type="text/javascript">//创建和初始化地图函数：
function initMap(){
    createMap();//创建地图
    setMapEvent();//设置地图事件
    addMapControl();//向地图添加控件
    addMarker();//向地图中添加marker
}

//创建地图函数：
function createMap(){
    var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
    var point = new BMap.Point(116.521426,39.793933);//定义一个中心点坐标
    map.centerAndZoom(point,18);//设定地图的中心点和坐标并将地图显示在地图容器中
    window.map = map;//将map变量存储在全局
}

//地图事件设置函数：
function setMapEvent(){
    map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
    map.enableScrollWheelZoom();//启用地图滚轮放大缩小
    map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
    map.enableKeyboard();//启用键盘上下左右键移动地图
}

//地图控件添加函数：
function addMapControl(){
//向地图中添加缩放控件
    var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
    map.addControl(ctrl_nav);
//向地图中添加比例尺控件
    var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
    map.addControl(ctrl_sca);
}

//标注点数组
var markerArr = [{title:"和许（北京）投资管理有限公司",content:"总机：4000-555-959 <br/>电话：+86（10）59478779<br/>邮件： kefu@aicgo.com<br/>网址： www.aicgo.com",point:"116.521628|39.794003",isOpen:0,icon:{w:23,h:25,l:46,t:21,x:9,lb:12}}
];
//创建marker
function addMarker(){
    for(var i=0;i<markerArr.length;i++){
        var json = markerArr[i];
        var p0 = json.point.split("|")[0];
        var p1 = json.point.split("|")[1];
        var point = new BMap.Point(p0,p1);
        var iconImg = createIcon(json.icon);
        var marker = new BMap.Marker(point,{icon:iconImg});
        var iw = createInfoWindow(i);
        var label = new BMap.Label(json.title,{"offset":new BMap.Size(json.icon.lb-json.icon.x+10,-20)});
        marker.setLabel(label);
        map.addOverlay(marker);
        label.setStyle({
            borderColor:"#808080",
            color:"#333",
            cursor:"pointer"
        });

        (function(){
            var index = i;
            var _iw = createInfoWindow(i);
            var _marker = marker;
            _marker.addEventListener("click",function(){
                this.openInfoWindow(_iw);
            });
            _iw.addEventListener("open",function(){
                _marker.getLabel().hide();
            })
            _iw.addEventListener("close",function(){
                _marker.getLabel().show();
            })
            label.addEventListener("click",function(){
                _marker.openInfoWindow(_iw);
            })
            if(!!json.isOpen){
                label.hide();
                _marker.openInfoWindow(_iw);
            }
        })()
    }
}
//创建InfoWindow

function createInfoWindow(i){
    var json = markerArr[i];
    var iw = new BMap.InfoWindow("<b class='iw_poi_title' title='" + json.title + "'>" + json.title + "</b><div class='iw_poi_content'>"+json.content+"</div>");
    return iw;
}
//创建一个Icon
function createIcon(json){
    var icon = new BMap.Icon("http://app.baidu.com/map/images/us_mk_icon.png", new BMap.Size(json.w,json.h),{imageOffset:new BMap.Size(-json.l,-json.t),infoWindowOffset:new BMap.Size(json.lb+5,1),offset:new BMap.Size(json.x,json.h)})
    return icon;
}

initMap();//创建和初始化地图
</script>
</body>
</html>
