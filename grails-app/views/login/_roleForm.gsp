<table>
    <tr>
        <td>名称：</td>
        <td width="345"><input name="rolename" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${roleInstance?.rolename}"></td>
    </tr>
    <tr>
        <td>备注：</td>
        <td><input name="remark" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${roleInstance?.remark}"></td>
    </tr>
    <tr>
        <td>
            创建时间：
        </td>
        <td>
            <g:datePicker name="dateCreat" precision="day"  value="${roleInstance?.dateCreat}"  />
        </td>
    </tr>
    <tr>
        <td></td>
        <td align="right">
            <button type="submit" class="btn btn-info">保存</button>
        </td>
    </tr>
</table>
