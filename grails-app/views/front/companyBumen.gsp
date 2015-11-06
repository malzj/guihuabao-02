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
    %{--<link rel="stylesheet" href="css/bootstrap.min.css"/>--}%
    %{--<link rel="stylesheet" href="css/custom.css"/>--}%
    %{--<link rel="stylesheet" href="css/jquery.jOrgChart.css"/>--}%
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

    <link href="${resource(dir: 'css', file: 'custom.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'jquery.jOrgChart.css')}" rel="stylesheet">

    <link href="${resource(dir: 'css', file: 'ownset.css')}" rel="stylesheet">
    <style type="text/css">
    #chart table{margin: 0 auto;}
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
        <g:render template="structuresiderbar" />
        <!--sidebar end-->
        <!--main content start-->
        <section id="main-content" class="col-xs-10" style="padding-left: 0;">
            <section class="wrapper">
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




<script>
    jQuery(document).ready(function() {
        function bumenfor(bumenInfo){
            var html = '';
            html+='<li><div data-id="'+bumenInfo.id+'" data-cid="'+bumenInfo.cid+'">'+bumenInfo.name+'</div>';
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
                if(data){
                    var html2=printStructure(data.bumenList);
                    $('#chart').append(html2);
                    $('#chart').ajaxComplete(function(){
                        $("#org1").jOrgChart({
                            chartElement : '#chart1',
                            dragAndDrop  : false
                        });
                    })
                }else{
                    alert("加载失败!")
                }
            }
        })

    });
</script>
</body>
</html>