<html>
<head>
    <title>规划宝后台管理系统</title>
    <!-- Bootstrap core CSS -->
    <link href="${resource(dir: 'css', file: 'bootstrap.min.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'bootstrap-reset.css')}" rel="stylesheet" type="text/css">

    <link href="${resource(dir: 'css', file: 'ownset.css')}" rel="stylesheet">
</head>
<body style="background-color:#fff;">
<img width="100%" height="50%" src="${resource(dir: 'img', file: 'login_bg.png')}" />
<div class="login">
    <g:form url="[controller:'login',action:'login']">
        <table>
            <tr>
                <td><input class="form-control" id="username" name="username" placeholder="用户名" type="text" autofocus /></td>
            </tr>
            <tr>
                <td><input class="form-control" id="password" name="password" placeholder="密码" type="password" /></td>
            </tr>
            <tr>
                <td><input class="btn btn-info" type="submit" value="登录" /></td>
            </tr>
        </table>
    </g:form>
</div>
<div class="footer">
    Copyright &copy; 2012 IZP Technologies Co.,Ltd. All Rights Reserved. 京ICP备13047936号-3  京公网安备 110105018529
</div>
</body>
</html>