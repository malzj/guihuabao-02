<table>
    <tr>
        <td>姓名：</td>
        <td width="345"><input name="name" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${userInstance?.name}"></td>
    </tr>
    <tr>
        <td>用户名：</td>
        <td><input name="username" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${userInstance?.username}"></td>
    </tr>
    <tr>
        <td>密码：</td>
        <td><input name="password" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${userInstance?.password}"></td>
    </tr>
    <tr>
        <td>城市：</td>
        <td><input name="city" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${userInstance?.city}"></td>
    </tr>
    <tr>
        <td>电话：</td>
        <td><input name="phone" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${userInstance?.phone}"></td>
    </tr>
    <tr>
        <td>公司：</td>
        <td><g:select name="cid" from="${com.guihuabao.Company.list()}" optionKey="id" optionValue="companyname" required="" value="${userInstance?.cid}" class="form-control form-control-inline input-medium default-date-picker"/></td>
    </tr>
    <tr>
        <td>权限：</td>
        <td>
            <g:select name="rid" from="${com.guihuabao.Role.list()}" optionKey="id" optionValue="rolename" required="" value="${userInstance?.rid}" class="form-control form-control-inline input-medium default-date-picker"/>
        </td>
    </tr>
    <tr>
        <td>地址：</td>
        <td><input name="address" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${userInstance?.address}"></td>
    </tr>
    <tr>
        <td>
            创建时间：
        </td>
        <td>
            <g:datePicker name="dateCreat" precision="day"  value="${companyUserInstance?.dateCreat}"  />
        </td>
    </tr>
    <tr>
        <td></td>
        <td align="right"><button type="submit" class="btn btn-info">保存</button></td>
    </tr>
</table>