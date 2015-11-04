<table>
    <tr>
        <td>姓名：</td>
        <td width="345"><input class="form-control form-control-inline input-medium" type="text" name="name"  value="${companyUserInstance?.name}" /></td>
    </tr>
    <tr>
        <td>用户名：</td>
        <td width="345"><input class="form-control form-control-inline input-medium" type="text" name="username"  value="${companyUserInstance?.username}" /></td>
    </tr>
    <tr>
        <td>密码：</td>
        <td><input class="form-control form-control-inline input-medium" type="text" name="password"  value="${companyUserInstance?.password}" /></td>
    </tr>
    <tr>
        <td>手机号：</td>
        <td><input class="form-control form-control-inline input-medium" type="text" name="phone"  value="${companyUserInstance?.phone}" /></td>
    </tr>
    <tr>
        <td>部门：</td>
        <td>
            <g:select name="bid" from="${bumenList}" optionKey="id" optionValue="name" noSelection="['0':'无']" required="" value="${companyUserInstance?.bid}" class="form-control form-control-inline input-medium"/>
        </td>
    </tr>
    <tr>
        <td>
            角色：
        </td>
        <td>
            <select name="pid" required="" class="form-control form-control-inline input-medium" id="pid">
                %{--<option value="1" <g:if test="${companyUserInstance.pid==1}">selected="selected" </g:if>>Boss</option>--}%
                %{--<option value="2" <g:if test="${companyUserInstance.pid==2}">selected="selected" </g:if>>经理</option>--}%
                %{--<option value="3" <g:if test="${companyUserInstance.pid==3}">selected="selected" </g:if>>员工</option>--}%
                <g:each in="${com.guihuabao.Persona.findAll()}" var="pinfo">
                    <option value="${pinfo.id}" <g:if test="${companyUserInstance.pid==pinfo.id}">selected="selected" </g:if>>${pinfo.name}</option>
                </g:each>
            </select>
        </td>
    </tr>
    <tr>
        <td>员工职位：</td>
        <td>
            <input class="form-control form-control-inline input-medium" type="text" name="position"  value="${companyUserInstance?.position}" />
        </td>
    </tr>
    <tr>
        <td>员工职责：</td>
        <td>
            <textarea name="responsibility" class="wysihtml5 form-control" rows="10">${companyUserInstance?.responsibility}</textarea>
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
        <td align="right"><button type="submit" class="btn btn-info">保存</button><a href="javascript:history.go(-1);" class="ml20 btn btn-info">取消</a></td>
    </tr>
</table>
