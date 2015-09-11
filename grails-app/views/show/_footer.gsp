<div id="footer">
    <div id="footer-content" class="clearfix">
        <dl class="fl">
            <dt>产品</dt>
            <dd><g:link controller="show" action="function">功能特性</g:link></dd>
            <dd><g:link controller="show" action="safe">数据安全</g:link></dd>
            <dd><g:link controller="show" action="mobile">移动版本</g:link></dd>
        </dl>
        <dl class="fl">
            <dt>他说</dt>
            <dd><g:link controller="show" action="everyonesay">用户说</g:link></dd>
            <dd><g:link controller="show" action="everyonesay">媒体说</g:link></dd>
            <dd><g:link controller="show" action="everyonesay">行业说</g:link></dd>
        </dl>
        <dl class="fl">
            <dt>支持</dt>
            <dd>帮助中心</dd>
            <dd>在线反馈</dd>
        </dl>
        <dl class="fl">
            <dt>更多</dt>
            <dd><g:link controller="show" action="aboutus">关于我们</g:link></dd>
            <dd><g:link controller="show" action="contactus">联系我们</g:link></dd>
            <dd><g:link controller="show" action="privacy">隐私政策</g:link></dd>
            <dd><g:link controller="show" action="service">服务条款</g:link></dd>
        </dl>
        <div class="erweimas fl">
            <h2>下载规划宝移动端</h2>
            <div class="erweima fl">
                <img src="${resource(dir: 'index/img/', file: 'erweima.png')}" alt="二维码"/>
                <p>iphone客户端下载</p>
            </div>
            <div class="erweima fl">
                <img src="${resource(dir: 'index/img/', file: 'erweima.png')}" alt="二维码"/>
                <p>Android客户端下载</p>
            </div>
        </div>
    </div>
</div>
<div id="bottom">
    <p>Copyright © 2012 IZP Technologies Co.,Ltd. All Rights Reserved.京ICP备13047936号-3&nbsp;京公网安备</p>
    <ul class="clearfix">
        <li><img src="${resource(dir: 'index/img/', file: 'icon1.png')}" alt="icon"/></li>
        <li><img src="${resource(dir: 'index/img/', file: 'icon2.png')}" alt="icon"/></li>
        <li><img src="${resource(dir: 'index/img/', file: 'icon3.png')}" alt="icon"/></li>
        <li><img src="${resource(dir: 'index/img/', file: 'icon4.png')}" alt="icon"/></li>
    </ul>
</div>
<style type="text/css">
*{border:0;margin:0;padding:0;}
body{font-family:'Microsoft Yahei','微软雅黑',Arial,'Hiragino Sans GB','宋体';font-size:14px;	}
ul{list-style:none;}
/* slides */
.slides{position:fixed;right:8px;top:55%;}
.slides .slideul>li{position:relative;display:block;width:56px;height:56px;margin-bottom:10px;overflow:visible;}
.slides .slideul>li.kefu{width:66px;padding-left:10px;margin-left:-10px;}
.slides .slideul>li ul.kefulist{position:absolute;left:-86px;top:-30px;padding-right:10px;display:none;}
.slides .slideul>li ul.kefulist li{margin-bottom:10px;}
.slides .slideul>li ul.kefulist li a{display:block;width:90px;height:30px;line-height:30px;background:#09c2ff;color:#fff;text-align:center;text-decoration:none;}
.slides .slideul>li ul.kefulist li a:hover{text-decoration:none;}
</style>
<!--客服侧边栏-->
<div class="slides">
    <ul class="slideul">
        <li class="kefu">
            <img src="${resource(dir: 'index/img/', file: 'side.png')}" alt="">
            <ul class="kefulist">
                <li><a href="http://wpa.qq.com/msgrd?v=3&uin=1114774100&Site=qq&Menu=yes" target="_blank">在线客服一</a></li>
                <li><a href="http://wpa.qq.com/msgrd?v=3&uin=848215697&Site=qq&Menu=yes" target="_blank">在线客服二</a></li>
                <li><a href="http://wpa.qq.com/msgrd?v=3&uin=1114774100&Site=qq&Menu=yes" target="_blank">在线客服三</a></li>
            </ul>
        </li>
    </ul>
</div>
<script type="text/javascript" src="${resource(dir: 'index/js/', file: 'jquery-1.9.1.min.js')}"></script>
<script type="text/javascript">
    $(function(){
        //Sldie
        $(".slides .kefu").mouseenter(function(){
            $(this).find(".kefulist").fadeIn();
        });
        $(".slides .kefu").mouseleave(function(){
            $(this).find(".kefulist").fadeOut();
        });
    });
</script>