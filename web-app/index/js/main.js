/*! 2015 www.eteams.cn All Rights Reserved */
/*! lazyload.js */
(function(a,b){$window=a(b),a.fn.lazyload=function(c){function f(){var b=0;d.each(function(){var c=a(this);if(e.skip_invisible&&!c.is(":visible"))return;if(!a.abovethetop(this,e)&&!a.leftofbegin(this,e))if(!a.belowthefold(this,e)&&!a.rightoffold(this,e))c.trigger("appear");else if(++b>e.failure_limit)return!1})}var d=this,e={threshold:0,failure_limit:0,event:"scroll",effect:"show",container:b,data_attribute:"original",skip_invisible:!0,appear:null,load:null};return c&&(undefined!==c.failurelimit&&(c.failure_limit=c.failurelimit,delete c.failurelimit),undefined!==c.effectspeed&&(c.effect_speed=c.effectspeed,delete c.effectspeed),a.extend(e,c)),$container=e.container===undefined||e.container===b?$window:a(e.container),0===e.event.indexOf("scroll")&&$container.bind(e.event,function(a){return f()}),this.each(function(){var b=this,c=a(b);b.loaded=!1,c.one("appear",function(){if(!this.loaded){if(e.appear){var f=d.length;e.appear.call(b,f,e)}a("<img />").bind("load",function(){c.hide().attr("src",c.data(e.data_attribute))[e.effect](e.effect_speed),b.loaded=!0;var f=a.grep(d,function(a){return!a.loaded});d=a(f);if(e.load){var g=d.length;e.load.call(b,g,e)}}).attr("src",c.data(e.data_attribute))}}),0!==e.event.indexOf("scroll")&&c.bind(e.event,function(a){b.loaded||c.trigger("appear")})}),$window.bind("resize",function(a){f()}),f(),this},a.belowthefold=function(c,d){var e;return d.container===undefined||d.container===b?e=$window.height()+$window.scrollTop():e=$container.offset().top+$container.height(),e<=a(c).offset().top-d.threshold},a.rightoffold=function(c,d){var e;return d.container===undefined||d.container===b?e=$window.width()+$window.scrollLeft():e=$container.offset().left+$container.width(),e<=a(c).offset().left-d.threshold},a.abovethetop=function(c,d){var e;return d.container===undefined||d.container===b?e=$window.scrollTop():e=$container.offset().top,e>=a(c).offset().top+d.threshold+a(c).height()},a.leftofbegin=function(c,d){var e;return d.container===undefined||d.container===b?e=$window.scrollLeft():e=$container.offset().left,e>=a(c).offset().left+d.threshold+a(c).width()},a.inviewport=function(b,c){return!a.rightofscreen(b,c)&&!a.leftofscreen(b,c)&&!a.belowthefold(b,c)&&!a.abovethetop(b,c)},a.extend(a.expr[":"],{"below-the-fold":function(c){return a.belowthefold(c,{threshold:0,container:b})},"above-the-top":function(c){return!a.belowthefold(c,{threshold:0,container:b})},"right-of-screen":function(c){return a.rightoffold(c,{threshold:0,container:b})},"left-of-screen":function(c){return!a.rightoffold(c,{threshold:0,container:b})},"in-viewport":function(c){return!a.inviewport(c,{threshold:0,container:b})},"above-the-fold":function(c){return!a.belowthefold(c,{threshold:0,container:b})},"right-of-fold":function(c){return a.rightoffold(c,{threshold:0,container:b})},"left-of-fold":function(c){return!a.rightoffold(c,{threshold:0,container:b})}})})(jQuery,window),
/*! site */
//修复lazyload首屏图片加载失败问题
$(window).load(function(){
	setTimeout(function(){
		window.scrollTo(0, 1);
	}, 0);
});

$(document).ready(function(){
	//全局
	var global = {
		h:$(window).height(),
		st: $(window).scrollTop(),
		mod:$('input#module').val(),
		backTop:function(){
			if(global.mod=='index') return false;
			global.st > (global.h*0.5) ? $("#backtop").show() : $("#backtop").hide();
		}
	},ab={},mobile={},product={};
	
	//内页
	if(global.mod != 'index'){
		$('#backtop').on('click',function(){
			$("html,body").animate({"scrollTop":0},500);
			$('.site-head').show();
			if(global.mod == 'product'){
				$('.site-head').addClass('site-head-fixed');
				$('.feature-nav').css('top','80px').removeClass('feature-nav-alpha95');
			}
		});
		$('body').mousewheel(function(event, delta, deltaX, deltaY) {
			if(delta < 0){//向下滚动
				$('.site-head').removeClass('site-head-fixed');  
				$('.site-head').hide();
				$('.feature-nav').css('top','0');
			}else if(delta > 0){//向上滚动
				$('.site-head').addClass('site-head-fixed');
				$('.site-head').show();
				$('.feature-nav').css('top','80px');
			}
			if(global.mod == 'product'){
				var st = $(window).scrollTop(),
				cp = $('.mod-feature').offset().top;
				st>cp?$('.feature-nav').addClass('feature-nav-alpha95'):$('.feature-nav').removeClass('feature-nav-alpha95');
			}
		});
	}
	//首页
	if(global.mod == 'index'){
		$('#backtop').on('click',function(){
			$('#fp-nav ul li').eq(0).children('a').trigger('click');
		});
		$('.mod-register').find('.res-value').val('');
	    $('.mod-register').find('.holder').on('click',function(){
	    	$(this).hide().next('.res-value').trigger('focus');
	    })
	    $('.mod-register').find('.res-value').on('focusout',function(){
	    	if ($.trim($(this).val())=='') {
	            $(this).prev('.holder').show();
	        }
	    });
	    $('.mod-register').find('.res-value').on('focus',function(e){
	        $(e.target).parent().find(".holder").hide();
	    });
		
	}
	function blogNav(){
        var footerH = $('.page-blog').find('.site-footer').height(),
            categoryTop = global.st + 165,
            categoryH = $('.mod-blog .js_category').height(),
            blogCompare = $('body').height() - categoryTop - categoryH;
        
        if( blogCompare <= (footerH + 80) ){
            $('body').find('.mod-blog .js_category').addClass('hide');
        }else{
            $('body').find('.mod-blog .js_category').removeClass('hide');
        }
    }
    blogNav();
    global.backTop();
    $(window).scroll(function(){
        global.h = $(window).height();
        global.st = $(window).scrollTop();
        global.backTop();
        blogNav();
    });
    $(window).resize(function(){
        global.h = $(window).height();
        global.st = $(window).scrollTop();
        global.backTop();
        blogNav();
    });
    //博客归档默认位置
    $('.mod-blog .js_archive').css('margin-top',($('.mod-blog .js_category').height()+20) + 'px');
    //首页第一屏指针
    $('.home .arrow-begin').on('click',function(){
        $('#fp-nav ul li').eq(1).children('a').trigger('click');
    });
    //图片延迟加载
    $('.feature-row img').show().lazyload({ threshold : 10 , effect:"fadeIn" });
    
    //mobile标签页
    mobile.tabBg = $('.mod-mobile-tab ul li.tab-item-active').attr('sn')*33.3333+'%';
    $('.mod-mobile-tab .tab-item-over').css('left',mobile.tabBg);
    $('.mod-mobile-tab .tab-item').on('mouseenter',function(){
    	var c = $(this).index()*33.3333+'%';
    	var $handle = $('.mod-mobile-tab .tab-item-over');
		$('.mod-mobile-tab .tab-item-over').animate({
			left:c
		},200)
    });
    $('.mod-mobile-tab').on('mouseleave',function(){
    	var $handle = $('.mod-mobile-tab .tab-item-over');
		$('.mod-mobile-tab .tab-item-over').animate({
			left:mobile.tabBg
		},200)
    });
    //mobile翻转样式辅助
    $('.mod-mobile-focus .focus-item').hover(function(){
        $(this).children('.focus-wrap').addClass('hover');
    },function(){
    	$(this).children('.focus-wrap').removeClass('hover');
    })
    
    //选中导航栏
    $('.site-nav > li > a').each(function() {
        var o = $(this);
        var name = o.attr('name');
        if(global.mod == name){
            $('.nav-link-cur').removeClass('nav-link-cur');
            o.addClass('nav-link-cur');
        }
    });
    //about标签页
    $('.js_aboutNav li').on('click',function(){
        var a = $(this).index();
        $(this).addClass('nav-item-active').siblings().removeClass('nav-item-active');
        $('.mod-about .tab-pane').eq(a).css({
            display: 'block',
            opacity: 0
        })
        .animate({opacity:1}).siblings().css({
            display: 'none',
            opacity: 0
        });
    });
    //about标记地址
    ab.tab = location.search.match(new RegExp("[\?\&]a=([^\&]+)", "i"));
    if(ab.tab){
        if(ab.tab[1]==1){
            $('.js_ab1').trigger('click');
        }
        if(ab.tab[1]==2){
            $('.js_ab2').trigger('click');
        }
        if(ab.tab[1]==3){
            $('.js_ab3').trigger('click');
        }
        if(ab.tab[1]==4){
            $('.js_ab4').trigger('click');
        }
    }
    //搜索框
    $('.mod-sbox').find('.text').val('');
    $('.mod-sbox').find('.holder').on('click',function(){
    	$(this).hide().next('.text').trigger('focus');
    })
    $('.mod-sbox').find('.text').on('focusout',function(){
    	if ($.trim($(this).val())=='') {
            $(this).prev('.holder').show();
        }
    });
    $('.mod-sbox').find('.text').on('focus',function(e){
        $(e.target).parent().find(".holder").hide();
    });
    
    //表单
    $('.ui-form-item').find('.holder').on('click',function(){
        $(this).hide().next('.ui-input').trigger('focus');
    });
    $('.ui-form-item').find('.ui-input').on('focusout',function(){
        if ($.trim($(this).val())=='') {
            $(this).prev('.holder').show();
        };
    });
    $('.ui-form-item').find('.ui-input').on('focus',function(e){
       $(e.target).parent().find(".holder").hide();
    });
    //重置计算器
    if($('#price-calc')[0]!=null){
    	$('#price-calc')[0].reset();
    }
    //购买价格计算器
    var priceCalc={
        el:$('.mod-price-calc'),//计算器
        people:$('#result-num'),//人数
        space:$('#result-space'),//空间
        price:$('#result-price'),//价格
        index:1,//折扣
        //初始状态
        init:function(){  
            this.people.text('10');
            this.space.text('1');
            this.price.text('0');
            this.calc();
        },
        fmoney:function(s, n){//千分位格式化
        	n = n > 0 && n <= 20 ? n : 2;   
        	s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";   
        	var l = s.split(".")[0].split("").reverse(),   
        	r = s.split(".")[1];   
        	t = "";   
        	for(i = 0; i < l.length; i ++ ){   
        		t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");   
        	}  
        	return t.split("").reverse().join("") + "." + r;   
        },
        calc:function(){
            var a = this,flag = false,p,i,t;
            var that = this;
            this.el.find('.ui-input').on('keyup',function(event){
            	var e = event ? event :(window.event ? window.event : null);
            	if($(this).is('#buyNum')){
            		var n = $(this).val();
            		if((isNaN(n)||parseInt(n)!=n||n<=0)){
            			$('#price-calc .space-tip').html('请输入您想增购的存储空间，单位为G');
                        $('#numCheck').show().text('只能输入整数数字');
                        $(this).val('');
                    }else{
                    	if(n!=""&n!=0){
                    		$('#buyNum').val(Math.abs(parseInt(n)));
                    	}
                    	if(n<=10){
                    		$('#price-calc .space-tip').html('您当前拥有 <span class="red">'+((n*0.1).toFixed(1))+'</span>G空间，如需增购空间，请在此输入');
                    	}else{
                    		$('#price-calc .space-tip').html('您当前拥有 <span class="red">'+(n*2)+'</span>G空间，如需增购空间，请在此输入');
                    	}
                        $('#numCheck').hide().empty();
                    }
            	}else if($(this).is('#buySpace')){
            		var m = $(this).val();
            		if(isNaN(m)||parseInt(m)!=m||m<=0){
            			$('#spaceCheck').show().text('只能输入以10为倍数的正整数');
            			$(this).val('');
            		}else{
            			if(m%10!=0){
            				$('#spaceCheck').show().text('只能输入以10为倍数的正整数');
            			}
            			if(m!=""){
            				$('#buySpace').val(Math.abs(parseInt(m)));
            			}
            			$('#spaceCheck').hide().empty();
            		}
            	}
            	//绑定回车键触发blur
            	if(e.keyCode == 13){
                	$(this).trigger('blur');
                }
            });
            
            this.el.find('.ui-input').on('blur',function(){
                var b = $.trim($('#buyNum').val()),//购买人数
                    c = $.trim($('#buySpace').val()),//购买空间
                    i = a.index;//已选折扣
                if(isNaN(b)||b<=0&($(this).is('#buyNum'))){
            		$('#buyNum').val('');
                	b = "";
                }
                if(c%10!=0||c<=0&($(this).is('#buySpace'))){
                    $('#spaceCheck').show().text('只能输入以10为倍数的正整数');
                    $('#buySpace').prev('.holder').show();
                    //输入错误回到默认值
                    $('#buySpace').val("");
                    c = "";
                }
                if(b <= 10 ){
                	if(b == ''){
                    	a.people.text(0);
                    }else{
                    	a.people.text(b);
                    }
                    if(c==""){
                    	a.space.text((b*0.1).toFixed(1));
                        a.price.text(0);
                        //取折扣计算基数
                        p=0;
                    }else{
                    	c=Math.abs(parseInt(c));
                        a.space.text(c);
                        if(i == 1){
                            a.price.text(that.fmoney(c*10,2));
                        }
                        if(i == 2){
                        	a.price.text(that.fmoney(c*10*i*0.85,2));
                        }
                        if(i == 3){
                        	a.price.text(that.fmoney(c*10*i*0.75,2));
                        }
                        //取折扣计算基数
                        p = c*10;
                    }
                }
                if(b > 10 ){
                    a.people.text(b);
                    if(c==""){
                        a.space.text(b*2);
                        a.price.text(b*365);
                        if(i == 1){
                            a.price.text(that.fmoney(b*365,2));
                        }
                        if(i == 2){
                            a.price.text(that.fmoney(b*365*i*0.85,2));
                        }
                        if(i == 3){
                            a.price.text(that.fmoney(b*365*i*0.75,2));
                        }
                        p = b*365;
                    }else{
                    	c=Math.abs(parseInt(c));
                        a.space.text(c+b*2);
                        if(i == 1){
                            a.price.text(that.fmoney((b*365+c*10),2));
                        }
                        if(i == 2){
                            a.price.text(that.fmoney((b*365+c*10)*i*0.85,2));
                        }
                        if(i == 3){
                        	a.price.text(that.fmoney((b*365+c*10)*i*0.75,2));
                        }
                        //取折扣计算基数
                        p = b*365+c*10;
                    }
                }
                flag = true;
                t = a.index;//已选折扣
                console.log(t);
            })
            this.el.find('#discount li').on('click',function(){
                var b = $.trim($('#buyNum').val()),
                    c = $.trim($('#buySpace').val());
                $(this).addClass('active').siblings().removeClass('active');
                a.index = $(this).index() + 1;
                i = a.index;//当前点选折扣
                console.log(i);
                //如果未输入值
                if(b=='' & c==''){
                	a.people.text(0);
                	a.space.text(0);
                	a.price.text(0);
                	return
                };
                //如果上步已计算过当前折扣取消此次点击计算
                if(flag&i==t){
                	return flag = false;
                }
                flag = false;
                if(i == 1){
                	a.price.text(that.fmoney(p*i,2));
                }
                if(i == 2){
                	a.price.text(that.fmoney(p*i*0.85,2));
                }
                if(i == 3){
                	a.price.text(that.fmoney(p*i*0.75,2));
                }
            });
        }
    };
    priceCalc.init(); 

    //头部注册
    $('#top-signup').on('click',function(){
        $('#immediate-signup').trigger('click');
    });

    //马上体验-注册
    $('#immediate-signup').on('click',function(){
        $('#footer-signup-form').submit();
    });
});

//百度统计
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F41555f1291b274a5e1d99199f20e9eab' type='text/javascript'%3E%3C/script%3E"));


