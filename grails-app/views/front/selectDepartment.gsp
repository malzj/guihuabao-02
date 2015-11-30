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
    <link href="${resource(dir: 'css', file: 'styleone.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'style-responsive.css')}" rel="stylesheet">

    <link href="${resource(dir: 'css', file: 'ownset.css')}" rel="stylesheet">
</head>

<body>

<section id="container" >
    <!--header start-->
    <g:render template="header" />
    <!--header end-->
    <!--main content start-->
    <section id="main-content" style="margin-left: 0px;">
        <section class="wrapper" style="margin-top: 94px;">
            <div class="testPaper">
                <ul class="steps clearfix">
                    <li class="stp">
                        <span>第一步</span>
                        <p>现状评估</p>
                    </li>
                    <li class="arrow"></li>
                    <li class="stp">
                        <span>第二步</span>
                        <p>规模目标</p>
                    </li>
                    <li class="arrow"></li>
                    <li class="stp">
                        <span>第三步</span>
                        <p>财务目标</p>
                    </li>
                    <li class="arrow"></li>
                    <li class="stp active">
                        <span>第四步</span>
                        <p>组织架构</p>
                    </li>
                    <li class="arrow"></li>
                    <li class="stp">
                        <span>第五步</span>
                        <p>工作推进</p>
                    </li>
                </ul>
                <div class="test-question reset">
                    <div class="test-title">企业组织架构</div>
                    <div class="all-department">
                        <p><span class="tk"></span><span>提示：请根据需求选择虚线框内部门，点击按钮查看部门职能，拖拽按钮到下图框中以生成企业组织架构图。</span></p>
                        <ul class="clearfix">
                            <g:each in="${frameworkDepartmentList}" var="frameworkInstance">
                            <li><span id="${frameworkInstance.id}" data-departmentId="${frameworkInstance.id}" draggable="true" ondragstart="drag(event)">${frameworkInstance.name}</span></li>
                            </g:each>
                        </ul>
                    </div>
                    <g:form url="[controller:'front',action:'selectDepartmentSave']">
                    <div class="fra-department" ondrop="drop(event)" ondragover="allowDrop(event)">
                        <p><span class="tk"></span><span>提示：右击按钮进行部门编辑与删除。</span></p>
                        <figure class="org-chart cf">
                            <div class="board ">
                                <ul class="columnOne column">
                                    <li>
                                        <span>
                                            股东大会
                                        </span>
                                    </li>
                                </ul>
                                <ul class="columnTwo column">
                                    <li>
                                        <span>
                                            战略委员会
                                        </span>
                                    </li>
                                    <li>
                                        <span>
                                            股东大会
                                        </span>
                                    </li>
                                </ul>
                                <ul class="columnOne column">
                                    <li>
                                        <span>
                                            董事会
                                        </span>
                                    </li>
                                </ul>
                                <ul class="columnOne column" style="margin-top:32px;">
                                    <li>
                                        <span>
                                            总经理
                                        </span>
                                    </li>
                                </ul>
                            </div>
                            <ul id="departments" class="departments finally-solve">
                                <li class="department one reset">
                                    <span>
                                        <input type="text" name="name" value="部门" disabled="disabled"/>
                                    </span>
                                </li>
                            </ul>
                        </figure>
                    </div>
                    <div style="text-align: center;margin:30px 0 63px; ">
                        <button class="btn btn-info" style="padding-left: 22px;padding-right: 22px;background-color: #03a9f4;">在线生成</button>
                    </div>
                </div>
                </g:form>
            </div>
        </section>
    </section>

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
        var count=$('#departments').children().length;
        if(count==10){
            alert('建议部门少于十个！');
            return false;
        }else {
            var nb=$('#departments').children('.one').length;
            var data = ev.dataTransfer.getData("Text");
            var span = document.getElementById(data);
            var par=span.parentNode
            par.parentNode.removeChild(par);
            var newEl=document.createElement('li');
            if(nb){
                newEl.className='department reset';
                $('#departments').children('.department.reset').remove();
                count=0;
            }else{
                $('#departments .department').removeClass('reset');
                newEl.className='department';
            }
            newEl.setAttribute('data-departmentId',data);
            var idInput=document.createElement("input");
            idInput.name='departmentId';
            idInput.type='hidden';
            idInput.value=data;
            var numInput=document.createElement("input");
            numInput.name='num';
            numInput.type='hidden';
            numInput.value=count+1;
            var textInput=document.createElement("input");
            textInput.name='name';
            textInput.value=span.innerHTML;
            textInput.className="edit-input";
            textInput.setAttribute("readonly","readonly");
            var departSpan=document.createElement("span");
            departSpan.appendChild(textInput);
            newEl.appendChild(departSpan);
            newEl.appendChild(idInput);
            newEl.appendChild(numInput);
            var departments=document.getElementById('departments');
            departments.appendChild(newEl);
        }
    }
    $(function(){
        var event = {
            mousedown:function(e){
                if(e.which==3){
                    var id=$(this).attr('data-departmentId');
                    alert(id);

                }else if(e.which==1){
                    var id=$(this).attr('data-departmentId');
                    var winWidth=$(document).width();
                    var winHeight=$(document).height();
                    $.ajax({
                        url: '${webRequest.baseUrl}/front/ajaxDepartment',
                        dataType: "jsonp",
                        jsonp: "callback",
                        async: false,
                        data: {id: id},
                        success: function(data){
                            if(data.result) {
                                var html4 = '<div class="layer"><header id="title" class="panel-heading"><span>' + data.frameworkDepartmentInstance.name + '职责描述</span>';
                                html4 += '<div class="close"><a href="javascript:;" class="fa fa-times"></a></div>';
                                if (data.frameworkDepartmentInstance.responsibility) {
                                    html4 += '</header><div class="lay-content">' + data.frameworkDepartmentInstance.responsibility + '</div></div><div id="over"></div>'
                                } else {
                                    html4 += '</header><div class="lay-content">无</div></div><div id="over"></div>'
                                }

                                $('html').append(html4);
                            }
                        }
                    });
                }
            }
        }
        $(document).on('click','.all-department li span',function(){
            var id=$(this).attr('data-departmentId');
            var winWidth=$(document).width();
            var winHeight=$(document).height();
            $.ajax({
                url: '${webRequest.baseUrl}/front/ajaxDepartment',
                dataType: "jsonp",
                jsonp: "callback",
                async: false,
                data: {id: id},
                success: function(data){
                    if(data.result) {
                        var html4 = '<div class="layer"><header id="title" class="panel-heading"><span>' + data.frameworkDepartmentInstance.name + '职责描述</span>';
                        html4 += '<div class="close"><a href="javascript:;" class="fa fa-times"></a></div>';
                        if (data.frameworkDepartmentInstance.responsibility) {
                            html4 += '</header><div class="lay-content">' + data.frameworkDepartmentInstance.responsibility + '</div></div><div id="over"></div>'
                        } else {
                            html4 += '</header><div class="lay-content">无</div></div><div id="over"></div>'
                        }

                        $('html').append(html4);
                    }
                }
            });
        });
        $(document).on(event,'#departments .department');
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
    })
</script>
</body>
</html>