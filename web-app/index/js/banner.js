window.onload=function(){
	mv.app.toBanner();
};

var mv={};

mv.tools={};
mv.tools.getByClass=function(oParent,sClass){
	var children=oParent.getElementsByTagName("*");
	var arr=[];
	for(var i=0;i<=children.length-1;i++){
		if(children[i].className==sClass){
			arr.push(children[i]);
		}
	}
	return arr;
	
};
mv.tools.getStyle=function(obj,attr){
	if(obj.currentStyle){
		return obj.currentStyle[attr];
	}else{
		return getComputedStyle(obj,false)[attr];
	}	
};

mv.ui={};
mv.ui.textChange=function(obj,str){
	obj.onfocus=function(){
		if(obj.value==str){
			this.value='';
		}
	}
	obj.onblur=function(){
		if(obj.value==''){
			this.value=str;
		}
	}
};

mv.ui.fadeIn=function(obj1){
	var value=0;	
	clearInterval(obj1.timer);
	obj1.timer=setInterval(function(){
		var iSpeed=5;
		if(value==100){
//			clearInterval(obj1.timer);
		}else{
			value+=iSpeed;
			obj1.style.opacity=value/100;
			obj1.style.filter='alpha(opacity='+value+')';
		}
	},30);
};
mv.ui.fadeOut=function(obj1){
	if(mv.tools.getStyle(obj1,'opacity')==0){
		return false;
	}
	var value=100;	
	clearInterval(obj1.timer);
	obj1.timer=setInterval(function(){
		var ispeed=-5;
		if(value==0){
			clearInterval(obj1.timer);
		}else{
			value+=ispeed;
			obj1.style.opacity=value/100;
			obj1.style.filter='alpha(opacity='+value+')';
		}
	},30);
};
mv.ui.toMoveLeft=function(obj,old,now){
	clearInterval(obj.timer);
	obj.timer=setInterval(run,30);
	function run(){
		var iSpeed=(now-old)/10;
		iSpeed>0 ? Math.ceil(iSpeed):Math.floor(iSpeed);
//JS中的Math.ceil函数的用法Math.ceil(x) -- 返回大于等于数字参数的最小整数(取整函数)，对数字进行上舍入
//Math.floor(x)--返回小于等于数字参数的最大整数，对数字进行下舍入
		if(now==old){
			clearInterval(obj.timer)
		}else{
			old+=iSpeed;
			obj.style.left=old+'px';
		}
	};
};

mv.app={};
mv.app.toBanner=function(){
	var banner=document.getElementById("ad");
	var ali=banner.getElementsByTagName("li");
	var iNow=0;
	var timer=setInterval(auto,3000);
	var prevBg=mv.tools.getByClass(banner,"prev_bg")[0];
	var nextBg=mv.tools.getByClass(banner,"next_bg")[0];
	var prev=mv.tools.getByClass(banner,"prev")[0];
	var next=mv.tools.getByClass(banner,"next")[0];
	function auto(){
		if(iNow==ali.length-1){
			iNow=0;
		}else{
			iNow++;			
		}
		for(i=0;i<=ali.length-1;i++){
			mv.ui.fadeOut(ali[i]);
		}
		mv.ui.fadeIn(ali[iNow]);
	}
	function autoprev(){
		if(iNow==0){
			iNow=ali.length-1;
		}else{
			iNow--;			
		}
		for(i=0;i<=ali.length-1;i++){
			mv.ui.fadeOut(ali[i]);
		}
		mv.ui.fadeIn(ali[iNow]);
	}
	prevBg.onmouseover=prev.onmouseover=function(){
		prev.style.display='block';
		clearInterval(timer);
	};
	nextBg.onmouseover=next.onmouseover=function(){
		next.style.display='block';
		clearInterval(timer);
	};	
	prevBg.onmouseout=prev.onmouseout=function(){
		prev.style.display='none';
		timer=setInterval(auto,3000);
	};
	nextBg.onmouseout=next.onmouseout=function(){
		next.style.display='none';
		timer=setInterval(auto,3000);
	};
	prev.onclick=function(){
		autoprev();
	};
	next.onclick=function(){
		auto();
	};	
};	
mv.app.toScroll=function(){
	var aScroll=document.getElementById("scroll");
	var aUl=aScroll.getElementsByTagName("ul")[0];
	var aLi=aUl.getElementsByTagName("li");
	var oPrev=mv.tools.getByClass(aScroll,"prev")[0];
	var oNext=mv.tools.getByClass(aScroll,"next")[0];
	aUl.innerHTML+=aUl.innerHTML;
	aUl.style.width=aUl.offsetWidth*2+'px';
	var iNow=0;
	oPrev.onclick=function(){
		if(iNow==aLi.length/2){
			iNow=0;
		}
		mv.ui.toMoveLeft(aUl,-iNow*(aLi[0].offsetWidth),-(iNow+1)*aLi[0].offsetWidth);
		
		iNow++;
		
	};
	oNext.onclick=function(){
		if(iNow==0){
			iNow=aLi.length/2;
			aUl.style.left = -aUl.offsetWidth/2 + 'px';
		}
		mv.ui.toMoveLeft(aUl,-iNow*(aLi[0].offsetWidth),-(iNow-1)*aLi[0].offsetWidth);
		
		iNow--;
	};	
};