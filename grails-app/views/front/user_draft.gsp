<%--
  Created by IntelliJ IDEA.
  User: karl
  Date: 2015/7/23
  Time: 15:45
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

    <link href="${resource(dir: 'css', file: 'ownset.css')}" rel="stylesheet">
    <style>
    .info_content{border:none;padding:0;}
    #text{padding:0;background:none;}
    #apply_top{width:100%; height:50px;text-align:center;background:#fff;border:1px solid #d2d2d2;margin-right:-1px;}
    #apply_top td{border-right:1px solid #d2d2d2;border-bottom:1px solid #d2d2d2;}
    #myfilter{border:none;width:100%;text-align:center;width:96px;border-bottom:#ff0000;}
    #filter {text-align:left;text-indent:20px; position:absolute;top:49px;left:-1px;border:1px solid #d2d2d2;border-top:none;width:160px;margin:0;background:#fff;z-index:2; display:none;padding-top:20px;}
    #filter li{height:40px;line-height:40px; list-style:none; cursor:pointer;}
    .icon{background:#03a9f4;color:#fff;width:20px;height:20px;display:inline-block;border-radius:50px;margin-right:10px;}
    #apply_tab{font-size:14px;padding:0;margin:20px 0 -1px 0;border:1px solid #d2d2d2;background:#fff;border-spacing:10px 0; border-collapse:collapse;}
    #apply_tab tr{border-bottom:1px solid #d2d2d2;display:block;}
    #apply_tab .th{background:#f8f8f8;}
    #apply_tab td{ padding:10px;margin:0;}
    #apply_tab tr td:nth-of-type(1){width:140px;}
    #apply_tab tr td:nth-of-type(2){width:600px;}
    #apply_tab tr td:nth-of-type(3){width:200px;}
    #apply_tab tr td:nth-of-type(4){width:200px;}
    #apply_tab tr td:nth-of-type(5){width:140px;}
    #apply_tab tr td:nth-of-type(6){width:140px;}
    #apply_tab tr td:nth-of-type(7){width:200px;}
    .select{width:300px;height:35px;border:1px solid #d0d0d0;}
    textarea{border:1px solid #d0d0d0;width:500px;height:400px;resize:none;}
    .panel-content{margin:15px;}
    .panel-content li{margin:15px 0;}

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
    <g:render template="spaside"/>
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content" class="col-xs-10" style="padding-left: 0;">
        <section class="wrapper">


            <div class="info_content">
                <!--<div class="info_title">-->
                <table id="apply_top" width="100%" height="50px">
                    <tr>
                        <td width="106px">草稿</td>
                        %{--<td style=" position:relative;width:96px;">--}%
                            %{--<div id="myfilter" href="#"><span id="filter-content">筛选</span><span style="margin-left:20px;"><i class="fa fa-sort-down"></i></span></div>--}%
                            %{--<ul id="filter">--}%
                                %{--<li>默认</li>--}%
                                %{--<li>已通过</li>--}%
                                %{--<li>未通过</li>--}%
                                %{--<li>待处理</li>--}%
                            %{--</ul>--}%
                        %{--</td>--}%
                        <td width="1442px"></td>

                    </tr>
                </table>
                <!--</div>-->
                <div class=" clearfix" id="text">
                    <table width="100%" id="apply_tab">
                        <tr>

                            <td>申请类型</td>
                            <td>申请内容</td>
                            <td>审批人</td>
                            <td>抄送人</td>
                            <td>审批结果</td>
                            <td>申请时间</td>
                            <td>
                                操作
                            </td>
                        </tr>
                        <g:each in="${applylist}" status="i" var="applyInstance">
                            <tr data-id="${applyInstance.id}" data-version="${applyInstance.version}" data-spuid="${applyInstance.approvaluid}"  data-cpuid="${applyInstance.copyuid}" data-applyType="${applyInstance.type}">
                                <td>${applyInstance.type}</td>
                                <td>${applyInstance.content}</td>
                                <td>${applyInstance.approvalusername}</td>
                                <td>${applyInstance.copyname}</td>
                                <td>${applyInstance.status}</td>
                                <td>${applyInstance.dateCreate.format("yyyy-MM-dd")}</td>
                                <td>
                                    <a href="javascript:;" class="draft_pre"><img src="${resource(dir:'img',file:'pre.png')}" alt="pre" title="pre"/></a>
                                    <a href="javascript:;" class="draft_edit"><img src="${resource(dir:'img',file:'edit.png')}" alt="edit" title="edit"/></a>
                                    <g:link action="applyDelete" id="${applyInstance.id}" class="draft_delete" onclick="return confirm('确定删除？');"><img src="${resource(dir:'img',file:'delete.png')}" alt="delete" title="delete"/></g:link>
                                </td>
                            </tr>
                        </g:each>
                        %{--<tr>--}%
                            %{--<td>出差申请单</td>--}%
                            %{--<td>新项目调研，需出差五天！</td>--}%
                            %{--<td>营销部经理-法拉利</td>--}%
                            %{--<td>已通过</td>--}%
                            %{--<td>2015-7-15</td>--}%
                            %{--<td>--}%
                                %{--<a href="#" class="draft_pre"><img src="${resource(dir:'img',file:'pre.png')}" alt="pre" title="pre"/></a>--}%
                                %{--<a href="#" class="draft_edit"><img src="${resource(dir:'img',file:'edit.png')}" alt="edit" title="edit"/></a>--}%
                                %{--<a href="#" class="draft_delete"><img src="${resource(dir:'img',file:'delete.png')}" alt="delete" title="delete"/></a>--}%
                            %{--</td>--}%
                        %{--</tr>--}%


                    </table>
                <div class="pagination">
                    <g:paginate total="${applyInstanceTotal}" />
                </div>
                </div>
            </div>
        </section>
    </section>
    <!--main content end-->

</section>

<!--草稿详情弹层 start-->
<div class="passwordedit" id="draftdetails">
    <div class="m_box" style="width:804px;">
        <header class="panel-heading">
            <span><i class="yh"></i>申请详情</span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>
        <div class="panel-content">
            <ul>
                <li>申请类型：<span></span></li>
                <li>审批人：<span></span></li>
                <li>抄送人：<span></span></li>
                <li>申请内容：<span></span></li>
                <li>申请时间：<span></span></li>
                <li>申请结果：<span></span></li>
                <li>审核反馈：<span></span></li>
            </ul>
        </div>

    </div>
</div>
<!--草稿详情弹层 end-->
<!--草稿编辑弹层 start-->
<div class="passwordedit" id="draftedit">
    <div class="m_box" style="width:804px;height:466px;">
        <header class="panel-heading">
            <span><i class="yh"></i>编辑申请</span>
            <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
        </header>
            <table>
                <tr>
                    <td align="right">申请类型</td>
                    <td width="300">
                        <g:select id="type" name="type" from="${['出差', '报销', '请假','外勤','借款','公文','其他']}"/>
                    </td>

                </tr>
                <tr>
                    <td align="right">审批人</td>
                    <td><!--<input class="form-control form-control-inline input-medium default-date-picker" data-toggle="dropdown" name="newapply" />-->
                        <select id="approvaluid" name="approvaluid" class="select">
                            <g:each in="${companyuserList}" var="user">
                                <option value="${user.id}">${com.guihuabao.Bumen.get(user.bid).name}-${user.name}</option>
                            </g:each>
                        </select>

                    </td>
                </tr>
                <tr>
                    <td align="right">抄送人</td>
                    <td><!--<input class="form-control form-control-inline input-medium default-date-picker" data-toggle="dropdown" name="newapply" />-->
                        <select id="copyuid" name="copyuid" class="select">
                            <option selected>请选择抄送人</option>
                            <g:each in="${companyuserList}" var="copyuser">
                                <option value="${copyuser.id}">${com.guihuabao.Bumen.get(copyuser.bid).name}-${copyuser.name}</option>
                            </g:each>

                        </select>

                    </td>
                </tr>
                <tr>
                    <td align="right">申请内容</td>
                    <td><textarea id="applyContent" class=" form-control form-control-inline input-medium default-date-picker"  name="applycontent" cols="60" rows="8"></textarea></td>
                    <g:hiddenField name="applyId" id="applyId" ></g:hiddenField>
                    <g:hiddenField name="version" id="version" ></g:hiddenField>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <button id="button" type="button" class="applysub btn btn-info"  data-sub="0">存草稿</button>
                        <button id="button1" type="submit" class="applysub btn btn-info" data-sub="1">提交</button>
                    </td>
                    <td></td>
                </tr>
            </table>
    </div>
</div>
<!--草稿编辑弹层 end-->
<!-- js placed at the end of the document so the pages load faster -->
<script src="${resource(dir:'js',file:'jquery.js')}"></script>
<script src="${resource(dir:'js',file:'bootstrap.min.js')}"></script>
<script class="include" type="text/javascript" src="${resource(dir:'js',file:'jquery.dcjqaccordion.2.7.js')}"></script>
<script src="${resource(dir:'js',file:'jquery.scrollTo.min.js')}"></script>
<script src="${resource(dir:'js',file:'jquery.nicescroll.js')}"></script>
<script src="${resource(dir:'js',file:'jquery.sparkline.js')}"></script>
<script src="${resource(dir:'assets/jquery-easy-pie-chart',file:'jquery.easy-pie-chart.js')}"></script>
<script src="${resource(dir:'js',file:'owl.carousel.js')}" ></script>
<script src="${resource(dir:'js',file:'jquery.customSelect.min.js')}" ></script>
<script src="${resource(dir:'js',file:'respond.min.js')}" ></script>

<!--right slidebar-->
<script src="${resource(dir:'js',file:'slidebars.min.js')}"></script>

<!--common script for all pages-->
<script src="${resource(dir:'js',file:'common-scripts.js')}"></script>

<!--script for this page-->
<script src="${resource(dir:'js',file:'sparkline-chart.js')}"></script>
<script src="${resource(dir:'js',file:'easy-pie-chart.js')}"></script>
<script src="${resource(dir:'js',file:'count.js')}"></script>

<!--弹出框 js-->
<script type="text/javascript">
    $(document).ready(function(){

        $(".close").click(function(){
            $("#draftdetails").css("display","none");
            $("#draftedit").css("display","none");
        });
        $(".draft_pre").click(function(){
            var applyId = $(this).parent().parent().attr("data-id");
            var version = $(this).parent().parent().attr("data-version");
            var spuid = $(this).parent().parent().attr("data-spuid");
            var applyType = $(this).parent().siblings("td:eq(0)").html();
            var applyContent = $(this).parent().siblings("td:eq(1)").html();
            var approvalusername = $(this).parent().siblings("td:eq(2)").html();
            var copyname = $(this).parent().siblings("td:eq(3)").html();
            var applyStauts = $(this).parent().siblings("td:eq(4)").html();
            var applyDate = $(this).parent().siblings("td:eq(5)").html();
            $(".panel-content ul li:eq(0) span").html(applyType)
            $(".panel-content ul li:eq(1) span").html(approvalusername)
            $(".panel-content ul li:eq(2) span").html(copyname)
            $(".panel-content ul li:eq(3) span").html(applyContent)
            $(".panel-content ul li:eq(4) span").html(applyDate)
            $(".panel-content ul li:eq(5) span").html(applyStauts)
            $("#draftdetails").css("display","block");
        })
        $(".draft_edit").click(function(){
            $("#draftedit").css("display","block");
            var applyId = $(this).parent().parent().attr("data-id");
            var version = $(this).parent().parent().attr("data-version");
            var spuid = $(this).parent().parent().attr("data-spuid");
            var cpuid = $(this).parent().parent().attr("data-cpuid");
            var applyType = $(this).parent().parent().attr("data-applyType");
            var applyContent = $(this).parent().siblings("td:eq(1)").html();
            $("#applyId").val(applyId)
            $("#version").val(version)
            $("#type").find("option[value='"+applyType+"']").attr("selected",true)
            $("#approvaluid").find("option[value='"+spuid+"']").attr("selected",true)
            $("#copyuid").find("option[value='"+cpuid+"']").attr("selected",true)
            $("#applyContent").val(applyContent)
        })
        $("#myfilter").click(function(){
            $("#myfilter").parent().css("border-bottom","1px solid #fff");
            $("#filter").css("display","block");
            $("#filter").click(function(ev){
                var ev=ev||window.event();
                var target=ev.srcElement||ev.target;
                $("#filter-content").html(target.innerHTML);
                $("#filter").css("display","none");
                $("#myfilter").parent().css("border-bottom","1px solid #d2d2d2");
            })
        })
    })
</script>
<script type="text/javascript">
    $('.applysub').click(function(){
        var content = $('#applyContent').val();
        var type=$('#type').val();
        var id = $("#applyId").val();
        var version = $("#version").val();
        var approvaluid=$('#approvaluid').val();
        var copyuid=$('#copyuid').val()
        var applysub=$(this).attr("data-sub");
        var dumpto
        if(applysub=="1"){
            dumpto="apply"
        }else{
            dumpto="user_draft"
        }
        $(this).attr("disabled","disabled")
        console.log(content+type+approvaluid)
        $.ajax({
            url:'${webRequest.baseUrl}/front/applyUpdate?id='+encodeURI(id)+'&version='+encodeURI(version)+'&content='+encodeURI(content)+'&type='+encodeURI(type)+'&approvaluid='+encodeURI(approvaluid)+'&copyuid='+encodeURI(copyuid)+'&applysub='+encodeURI(applysub),
            async: false,
            dataType: "jsonp",
            jsonp: "callback",
            success: function (data) {
                // 去渲染界面
                if(data.msg){
                    alert("修改成功！")
                    window.location.href='${webRequest.baseUrl}/front/'+dumpto
                }else{
                    alert("修改失败！");
                }
            }
        })

    })
</script>
</body>
</html>