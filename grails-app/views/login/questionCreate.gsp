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
            <div class="middle_content">
                <div class="m_box">

                    <header class="panel-heading">
                        新建试题
                    </header>

                    <g:form class="form-horizontal tasi-form" url="[controller:'login',action:'questionSave']" method="post"  enctype= "multipart/form-data">
                        <table>
                            <g:hiddenField name="id" value="${id}"></g:hiddenField>
                            <tr>
                                <td>题号：</td>
                                <td width="345"><input name="num" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${num}"></td>
                            </tr>
                            <tr>
                                <td>题目内容：</td>
                                <td><input name="question" class="form-control form-control-inline input-medium default-date-picker" type="text" value=""></td>
                            </tr>
                            <tr>
                                <td>题目类型：</td>
                                <td>
                                    <select id="type" name="type" class="form-control form-control-inline input-medium">
                                        <option value="1">单选</option>
                                        <option value="2">多选</option>
                                        <option value="3">填空</option>
                                    </select>
                                </td>
                            </tr>
                            <tr class="select-type">
                                <td>选项：(<a href="javascript:;" id="addoption" class="btn btn-info" style="display:block;">+</a>)</td>
                                <td>
                                    <table id="options">
                                        <tr>
                                            <td><input placeholder="选项字母" name="letter" value="" /></td>
                                            <td><input placeholder="选项内容" name="content" value="" /></td>
                                            <td><input placeholder="选项分数" name="score" value="" /></td>
                                            <td><input placeholder="选项解析" name="analysis" value="" /></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <button type="submit" class="btn btn-info">保存</button>
                                    <button class="btn btn-info">返回</button>
                                </td>
                            </tr>
                        </table>
                    </g:form>
                </div>
            </div>
        </section>
        <!--main content end-->

        <!--footer start-->
        %{--<footer class="site-footer">--}%
        %{--<div class="text-center">--}%
        %{--2013 &copy; FlatLab by VectorLab.--}%
        %{--<a href="index.html#" class="go-top">--}%
        %{--<i class="fa fa-angle-up"></i>--}%
        %{--</a>--}%
        %{--</div>--}%
        %{--</footer>--}%
        <!--footer end-->
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
        $(document).ready(function(){
            $(document).on('click','#addoption',function(){
                var html='<tr><td><input placeholder="选项字母" name="letter" value="" /></td><td><input placeholder="选项内容" name="content" value="" /></td><td><input placeholder="选项分数" name="score" value="" /></td><td><input placeholder="选项解析" name="analysis" value="" /></td></tr>';
                $('#options').append(html);
            }) ;
            $('#type').change(function(){
               var type = $(this).val();
                var html1
                if(type==1||type==2){
                    html1='<td>选项：(<a href="javascript:;" id="addoption" class="btn btn-info" style="display:block;">+</a>)</td><td><table id="options">';
                    html1+='<tr><td><input placeholder="选项字母" name="letter" value="" /></td><td><input placeholder="选项内容" name="content" value="" /></td><td><input placeholder="选项分数" name="score" value="" /></td><td><input placeholder="选项解析" name="analysis" value="" /></td></tr>';
                    html1+='</table></td>';
                }else if(type==3){
                    html1='<td>空位数：</td><td><table id="options">';
                    html1+='<tr><td><input placeholder="空位个数" name="blank" value="" /></td></tr>';
                    html1+='</table></td>';
                }
                $('.select-type').empty().html(html1);
            });
        });
    </script>

</body>
</html>