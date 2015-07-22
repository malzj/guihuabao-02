<table>
    <tr>
        <td>姓名：</td>
        <td width="345"><input class="form-control form-control-inline input-medium default-date-picker" type="text" name="name"  value="${companyUserInstance?.name}" /></td>
    </tr>
    <tr>
        <td>用户名：</td>
        <td width="345"><input class="form-control form-control-inline input-medium default-date-picker" type="text" name="username"  value="${companyUserInstance?.username}" /></td>
    </tr>
    <tr>
        <td>密码：</td>
        <td><input class="form-control form-control-inline input-medium default-date-picker" type="text" name="password"  value="${companyUserInstance?.password}" /></td>
    </tr>
    <tr>
        <td>手机号：</td>
        <td><input class="form-control form-control-inline input-medium default-date-picker" type="text" name="phone"  value="${companyUserInstance?.phone}" /></td>
    </tr>
    <tr>
        <td>部门：</td>
        <td>
            <g:select name="bid" from="${bumenList}" optionKey="id" optionValue="name" required="" value="${companyUserInstance?.bid}" class="form-control form-control-inline input-medium default-date-picker"/>
        </td>
    </tr>
    <tr>
        <td>
            角色：
        </td>
        <td>
            <select name="pid" required="" class="form-control form-control-inline input-medium default-date-picker" id="pid">
                <option value="1" <g:if test="${companyUserInstance.pid==1}">selected="selected" </g:if>>Boss</option>
                <option value="2" <g:if test="${companyUserInstance.pid==2}">selected="selected" </g:if>>经理</option>
                <option value="3" <g:if test="${companyUserInstance.pid==3}">selected="selected" </g:if>>员工</option>
            </select>
        </td>
    </tr>
    <tr>
        <td>
            时间：
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
