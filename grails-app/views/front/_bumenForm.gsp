<table>
    <tr>
        <td>名称：</td>
        <td width="345"><input class="form-control form-control-inline input-medium" type="text" name="name"  value="${bumenInstance?.name}" /></td>
    </tr>
    <tr>
        <td>所属部门：</td>
        <td>
            <select name="affiliated" required="" class="form-control form-control-inline input-medium">
                <option value="0">无</option>
                <g:each in="${affiliatedList}" var="info">
                    <g:if test="${bumenInstance.id!=info.id}">
                    <option value="${info.id}" <g:if test="${bumenInstance.affiliated==info.id}">selected="selected" </g:if>>${info.name}</option>
                    </g:if>
                </g:each>
            </select>
        </td>
    </tr>
    <tr>
        <td>备注：</td>
        <td><input class="form-control form-control-inline input-medium" type="text" name="remark"  value="${bumenInstance?.remark}" /></td>
    </tr>

    <tr>
        <td>
            创建时间：
        </td>
        <td>
            <g:datePicker name="dateCreate" precision="day"  value="${bumenInstance?.dateCreate}"  />
        </td>
    </tr>
    <tr>
        <td></td>
        <td align="right"><button type="submit" class="btn btn-info">保存</button><a href="javascript:history.go(-1);" class="ml20 btn btn-info">取消</a></td>
    </tr>
</table>