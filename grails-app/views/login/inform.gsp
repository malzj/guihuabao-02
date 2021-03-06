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
            <div class="wrapper_title">
                <span class="f-l"><i class="yh"></i>系统通知列表</span>
                %{--<form class="f-r">--}%
                    %{--<input type="text" name="search" />--}%
                    %{--<input type="submit" value="" />--}%
                %{--</form>--}%
                <g:link action="informCreate" class="f-r"><i class="fa fa-plus-circle"></i>新建</g:link>
            </div>
            <div class="content">
                <table class="table table-striped table-advance table-hover">
                    <tr class="even">
                        <th width="10%">#编号</th>
                        <th width="80%">标题</th>
                        <th>操作</th>
                    </tr>

                    <g:each in="${informList}" status="i" var="inform">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                            <td>${i+1}</td>
                            <td><g:link  action="informShow" id="${inform?.id}">${inform.title}</g:link></td>
                            <td>
                                <g:link  action="informShow" id="${inform?.id}" class="btn btn-success btn-xs"><i class="fa fa-eye"></i></g:link>
                                <g:link action="informEdit" id="${inform?.id}" class="btn btn-primary btn-xs"><i class="fa fa-pencil"></i></g:link>
                                <g:link action="informDelete" id="${inform?.id}" class="btn btn-danger btn-xs" onclick="return confirm('确定删除？');"><i class="fa fa-trash-o "></i></g:link>
                            </td>


                        </tr>
                    </g:each>
                </table>
                %{--<div class="pagination">--}%
                    %{--<g:paginate total="${companyNoticeInstanceTotal}" />--}%
                %{--</div>--}%
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