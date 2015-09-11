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
                <g:link name="cooperation" class="nav-link" controller="show" action="">支持</g:link>
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
        <ul>
            <li>
                <g:link controller="show" action="aboutus.html">关于我们</g:link>
            </li>
            <li>
                <g:link controller="show" action="contactus.html">联系我们</g:link>
            </li>
            <li>
                <g:link controller="show" action="privacy.html">隐私政策</g:link>
            </li>
            <li>
                <g:link controller="show" action="service.html">服务条款</g:link>
            </li>
        </ul>
    </div>
    <div class="z-content f-r">
        <p style="line-height: normal; margin-bottom:10px;">
            <strong><span style="font-size:30px;">关于我们</span></strong>
        </p>
        <p style="line-height: 2.5em;font-size:14px;">
            规划宝由和许（北京）科技有限公司运营开发，是一款围绕连锁企业“目标管理和流程管理”的企业目标指挥中心软件产品，通过云协作平台，最大化提升企业的运营管理效率，促使企业目标的完成。
        </p>
        <p style="line-height: 2.5em;font-size:14px;">
            和许（北京）科技有限公司是中国领先的、专业连锁信息化解决方案服务商，致力于通过现代IT和互联网技术为数千万连锁企业解决各类管理和发展难题。
        </p>
    </div>
</div>
<g:render template="footer" />
</body>
</html>
