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
    <link href="${resource(dir: 'css', file: 'style.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'style-responsive.css')}" rel="stylesheet">

    <link href="${resource(dir: 'css', file: 'ownset.css')}" rel="stylesheet">
</head>

<body>

<section id="container" >
    <!--header start-->
    <g:render template="header" />
    <!--header end-->
    <!--sidebar start-->
    <g:render template="set_siderbar" />
    <!--sidebar end-->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <div class="info_content">
                <div class="info_title">
                    个人设置
                </div>
                <div class="text clearfix">
                    <g:form url="[controller:'front',action:'personalUpdate']" method="post" enctype="multipart/form-data">
                        <g:hiddenField name="cid" value="${session.company.id}" />
                        <g:hiddenField name="id" value="${userInstance?.id}" />
                        <g:hiddenField name="version" value="${userInstance?.version}" />
                        <table class="f-l">
                            <tr>
                                <td>姓名：</td>
                                <td><input class="input-shadow" type="text" name="username" value="${userInstance?.username}" /></td>
                            </tr>
                            <tr>
                                <td>密码：</td>
                                <td>
                                    <span id="passwordedit" class="btn btn-info"><i class="fa fa-pencil"></i>更换密码</span>
                                </td>
                            </tr>
                            <tr>
                                <td>性别：</td>
                                <td><input type="radio" name="sex" value="男" <g:if test="${userInstance?.sex == '男'}">checked</g:if>>男<input type="radio" name="sex" value="女" <g:if test="${userInstance?.sex == '女'}">checked</g:if>>女</td>
                            </tr>
                            <tr>
                                <td>电话：</td>
                                <td><input class="input-shadow" name="phone" type="text" value="${userInstance?.phone}" /></td>
                            </tr>
                            <tr>
                                <td>部门：</td>
                                <td>
                                    ${bumen?.name}
                                </td>
                            </tr>
                            <tr>
                                <td>角色：</td>
                                <td>
                                    <g:if test="${userInstance?.pid == 1}">Boss</g:if><g:if test="${userInstance?.pid==2}">经理</g:if><g:if test="${userInstance?.pid==3}">员工</g:if>
                                </td>
                            </tr>
                            <tr>
                                <td><button type="submit" class="btn btn-info">保存</button></td>
                                <td></td>
                            </tr>
                        </table>
                        <div class="imgupload f-l">
                            <div class="f-l">头像设置：</div>
                            <div class="f-l">
                                <input type="file" id="up_img" name="file1" value="${userInstance?.img}"/>
                                <div id="imgdiv" class="mt20"><img id="imgShow" width="305" height="305" src="<g:if test="${userInstance?.img}">${resource(dir:"images", file: ''+userInstance?.img+'')}</g:if><g:else>${resource(dir:"img", file: "touxiang.jpg")}</g:else>"/></div>
                                <span>头像大小（100*100）</span>
                            </div>
                        </div>
                    </g:form>
                </div>
            </div>
            <!--密码弹层 start-->
            <div class="passwordedit">
                <div class="m_box">
                    <header class="panel-heading">
                        <span><i class="yh"></i>新建用户</span>
                        <div class="close"><a href="javascript:;" class="fa fa-times"></a></div>
                    </header>
                    <g:form>
                        <table>
                            <tr>
                                <td align="right">旧密码：</td>
                                <td width="300"><input class="form-control form-control-inline input-medium default-date-picker" type="password" name="oldpassword" /></td>
                                <td width="100"><span style="color:#F00;font-size:12px;" class="oldwarn"></span></td>
                            </tr>
                            <tr>
                                <td align="right">新密码：</td>
                                <td><input class="form-control form-control-inline input-medium default-date-picker" type="password" name="newpassword" /></td>
                            </tr>
                            <tr>
                                <td align="right">重复密码：</td>
                                <td><input class="form-control form-control-inline input-medium default-date-picker" type="password" name="repassword" /></td>
                                <td><span style="color:#F00;font-size:12px;" class="rewarn"></span></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <span id="submit" class="btn btn-info">保存</span>
                                    <button type="reset" class="btn btn-info">重置</button>
                                </td>
                                <td></td>
                            </tr>
                        </table>
                    </g:form>
                </div>
            </div>
            <!--密码弹层 end-->
        </section>
    </section>
        <!--main content end-->

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

    <!--上传图片预览 js-->
    <script src="${resource(dir: 'js', file: 'uploadPreview.js')}"></script>
    <script type="text/javascript">
        window.onload = function () {
            new uploadPreview({ UpBtn: "up_img", DivShow: "imgdiv", ImgShow: "imgShow" });
        }
    </script>

    <!--密码弹出框 js-->
    <script type="text/javascript">
        $(function(){
            $("#passwordedit").click(function(){
                $(".passwordedit").css("display","block");
            });
            $(".close").click(function(){
                $(".passwordedit").css("display","none");
            });
            $("input[name=repassword]").blur(function(){
                var warn;
                var repassword = $(this).val();
                var newpassword = $("input[name=newpassword]").val();
                if(newpassword != repassword){

                    $(".rewarn").html("两次密码不相同！");
                }else{
                    $(".rewarn").html("");
                }
            });
            $("#submit").click(function(){
                var oldpassword = $("input[name=oldpassword]").val();
                var newpassword = $("input[name=newpassword]").val();
                var repassword = $("input[name=repassword]").val();
                var version = ${userInstance?.version};
                if(newpassword==repassword){
                    if(oldpassword&&newpassword){
                        $.ajax({
                            url:'${webRequest.baseUrl}/front/passwordUpdate?oldpassword='+oldpassword+'&newpassword='+newpassword+'&version='+version,
                            dataType: "jsonp",
                            jsonp: "callback",
                            success: function (data) {
                                // 去渲染界面
                                if(data.msg){
                                   alert("修改成功！");
                                    $(".passwordedit").css("display","none");
                                    window.location.reload();
                                }else{
                                   alert("修改失败！");

                                }
                            }
                        })
                    }
                }else{
                    $(".rewarn").html("两次密码不相同！");
                }
            })
        })
    </script>
</body>
</html>