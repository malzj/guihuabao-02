<table>
    <tr>
        <td>名称：</td>
        <td width="345"><input class="form-control form-control-inline input-medium default-date-picker" type="text" name="name"  value="${bumenInstance?.name}" /></td>
    </tr>
    <tr>
        <td>备注：</td>
        <td><input class="form-control form-control-inline input-medium default-date-picker" type="text" name="remark"  value="${bumenInstance?.remark}" /></td>
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
        <td align="right"><button type="submit" class="btn btn-info">保存</button></td>
    </tr>
</table>