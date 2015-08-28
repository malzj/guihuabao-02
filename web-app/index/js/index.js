/*! 2015 eteams Home page
 * Copyright © 2001-2014 Weaver Network
 */
$(function(){
	// 滚屏
	$('#secParent').fullpage({
		navigation: true,
		verticalCentered: false,
		resize: false,
		afterRender: function(){
			/*$('.home .site-head').addClass('site-head-sec1');*/
			$('.hm-sec1').find('.caption').animate({
				opacity:1,
				top:0
			},500).end().find('.mod-register').animate({
				opacity:1,
				top:0
			},500,function(){
				$('.hm-sec1').find('.dline').animate({
					width:"166px",
					opacity:1
				});
			});
		},
		afterLoad: function(anchorLink, index){
			if(index == 1){
				/*$('.home .site-head').addClass('site-head-sec1');*/
				$('.home .backtop').hide();
			}
			if(index == 2){
				$('.hm-sec2').find('h2').animate({
					opacity:1,
					top:0
				},400,function(){
					$('.hm-sec2').find('.feature-list').animate({
						opacity:1,
						top:0
					}).end().find('.feature-more').animate({
						opacity:1
					})
				});
			}
			if(index == 3){
				var s3={};
				/*$('.home .site-head').addClass('site-head-sec3');*/
				$('.hm-sec3').find('.zs-introduct').animate({
					opacity:1,
					"margin-left":"0px"
				},300,function(){
					$('.hm-sec3').find('.pic1').animate({
						opacity:1,
						right:"130px"
					},300)
					.end().find('.pic2').animate({
						opacity:1,
						right:0
					},300,function(){
						$('.hm-sec3').find('.mOA-list').css({
							opacity:1
						});
						$('.hm-sec3').find('.list-item').eq(0).animate({
							left:0,
							opacity:1
						},300,function(){
							$('.hm-sec3').find('.list-item').eq(1).animate({
								left:0,
								opacity:1
							},300,function(){
								$('.hm-sec3').find('.list-item').eq(2).animate({
									left:0,
									opacity:1
								},300,function(){
									$('.hm-sec3').find('.mOA-list-more').animate({
										opacity:1,
										'margin-top':'20px'
									})
								})
							})
						})
					});
				});
				$('.hm-sec3').find('.list-item').on('mouseenter',function(){
					var cur = $(this);
					if(!cur.hasClass('list-item-focus')){
						clearTimeout(s3.t);
						//防止切换误操作
						s3.t=setTimeout(function(){
							var index = cur.index();
							cur.addClass('list-item-focus').siblings().removeClass('list-item-focus');
							$('.hm-sec3').find(".pic-item").eq(index).css({
								opacity:0,
								display:"block" 
							}).animate({opacity:1},1000).addClass('pic-item-active').siblings().css({
								display: 'none',
								opacity: 0
							}).removeClass("pic-item-active");
						},400);
					}
			    });
			}
			if(index == 4){
				$('.hm-sec4').find('h2').animate({
					opacity:1
				},400,function(){
					$('.hm-sec4').find('.hm-mod-js').animate({
						opacity:1,
						'margin-top':'0px'
					},400,function(){
						$('.hm-sec4').find('.hm-mod-wecan').animate({
							opacity:1									   
						},400)
					});
				})
			}
			if(index == 5){
				/*$('.home .site-head').addClass('site-head-sec5');*/
				$('.home #fp-nav').addClass('fp-nav-sec5');
				if(navigator.appVersion.substring(navigator.appVersion.indexOf('MSIE')+5,navigator.appVersion.indexOf('MSIE')+6)<10){
					$('.hm-sec5').find('.customer-wall').css({
						opacity:0
					}).animate({
						opacity:1
					});
				}
				$('.hm-sec5').find('h2').animate({
					opacity:1,
					"margin-top":"-22px"
				},400,function(){
					$('.hm-sec5').find('.customer-wall').addClass('customer-wall-active');
				});
			}
			//if(index == 6){
//				$('.home .site-head').addClass('site-head-sec6');
//				$('.hm-sec6').find('.hm-mod-blog').animate({
//					opacity:1,
//					"margin-left":"-510px"
//				},500,function(){
//					$('.hm-sec6').find('.sec-text').animate({
//						opacity:1,
//						"margin-left":"100px"
//					},500);
//				});
//				
//				$('body').data('last',true);
//			}
		},
		onLeave: function(index,nextIndex, direction){
			
			if(index == 1){
				setTimeout(function(){
					$('.home .site-head').removeClass('site-head-sec1');
				},300)
				$('.home .backtop').show();
			}
			if(index == 2){
				$('.hm-sec2').find('h2').animate({
					opacity:0,
					top:"40px"
				}).end().find('.feature-list').animate({
					opacity:0,
					top:"50px"
				}).end().find('.feature-more').animate({
					opacity:0,
					top:"25px"
				})
			}
			if(index == 3){
				setTimeout(function(){
					$('.home .site-head').removeClass('site-head-sec3');
				},300);
				$('.hm-sec3').find('.zs-introduct').animate({
					opacity:0,
					"margin-left":"-100px"
				}).end().find('.pic1').animate({
					opacity:0,
					right:"0"
				}).end().find('.pic2').animate({
					opacity:0,
					right:"130px"
				}).end().find('.mOA-list').animate({
					opacity:0
				},function(){
					$('.hm-sec3').find('.list-item').css({
						left:"-100px",
						opacity:0
					});
					$('.hm-sec3').find('.mOA-list').css({
						opacity:0
					});
					$('.hm-sec3 .mOA-list-more').css({
						opacity:0,
						'margin-top':'30px'
					});
				});
			}
			if(index == 4){
				$('.hm-sec4').find('h2').animate({
					opacity:0
				}).end().find('.hm-mod-js').animate({
					opacity:0,
					'margin-top':'10px'
				},400).end().find('.hm-mod-wecan').animate({
					opacity:0									   
				},400);
			}
			if(index == 5){
				setTimeout(function(){
					$('.home .site-head').removeClass('site-head-sec5');
					$('.home #fp-nav').removeClass('fp-nav-sec5');
				},600)
				
				$('.hm-sec5').find('h2').animate({
					opacity:0,
					"margin-top":"20px"
				},400).end().find('.customer-wall').removeClass('customer-wall-active');
				
				if(navigator.appVersion.substring(navigator.appVersion.indexOf('MSIE')+5,navigator.appVersion.indexOf('MSIE')+6)<10){
					$('.hm-sec5').find('.customer-wall').animate({
						opacity:0
					});
				}
			}
			//if(index == 6){
////				$('#secParent')[0].onmousewheel=null;
////				
////				$('body').data('last',false);
//				$('.hm-sec6').find('.hm-mod-blog').animate({
//					opacity:0,
//					"margin-left":"-560px"
//				},300).end().find('.sec-text').animate({
//					opacity:0,
//					"margin-left":"200px"
//				})
//				setTimeout(function(){
//					$('.home .site-head').removeClass('site-head-sec6');
//				},600);
//			}
		}
	});
	//推荐博客轮播
	$(".hm-mod-blog .blog-scr").myScroll({
		speed:40,
		rowHeight:30
	});
	
//	$('body').mousewheel(function(event, delta, deltaX, deltaY){
//		if($('body').data('last')){
//			if(delta < 0){
//				$('.hm-sec6 .site-footer').animate({
//					bottom:0
//				})
//			}else{
//				$('.hm-sec6 .site-footer').animate({
//					bottom:'-400px'
//				});
//				
//			}
//		}
//		$('body').data('last',false);
//	});
//	alert($(window).width());
});
