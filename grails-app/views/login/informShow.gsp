

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
    <!--sidebar start-->
    <g:render template="sidebar" />
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper mt80">

            <g:form class="form-horizontal tasi-form"  enctype= "multipart/form-data">

                <div class="hxzs_heading clearfix">
                    <h2>详情</h2>
                    <g:link action="inform" class="f-r"><h2>返回列表</h2></g:link>
                </div>
                <div class="mt25">
                    <div class="form-group">

                        <div class="col-lg-12">
                            <input class="form-control" type="text" name="title" value="${informInstance.title}" readonly />
                        </div>
                    </div>
                    <div class="textarea">
                        <textarea id="editor_id" name="content" style="width:100%;height:500px;" readonly>${informInstance.introduction}</textarea>
                    </div>
                </div>
            </g:form>
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

    <!--keditor js-->
    <script charset="utf-8" src="${resource(dir: 'keditor', file: 'kindeditor.js')}"></script>
    <script charset="utf-8" src="${resource(dir: 'keditor/lang', file: 'zh_CN.js')}"></script>
    <script>

        KindEditor.ready(function(K) {
            var editor1 = K.create('textarea[name="introduction"]', {
//                cssPath : '../plugins/code/prettify.css',
                cssPath : '${resource(dir: 'keditor/plugins/code', file: 'prettify.css')}',
//                uploadJson : '../jsp/upload_json.jsp',
                uploadJson : '../upload/',
//                fileManagerJson : '../jsp/file_manager_json.jsp',
                fileManagerJson : '${resource(dir: 'keditor/jsp', file: 'file_manager_json.jsp')}',
                allowFileManager : true,
                afterCreate : function() {
                    this.sync();
//                    document.forms['example'].submit();
                },
                afterBlur:function(){
                    this.sync();
//                    document.forms['example'].submit();
                }
            })

        });
    </script>

</body>
</html>