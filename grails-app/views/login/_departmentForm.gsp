<table>
    <tr>
        <td>名称：</td>
        <td width="345"><input name="name" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${frameworkDepartmentInstance?.name}"></td>
    </tr>
    <tr>
        <td>职位1：</td>
        <td><input name="jobs" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${frameworkDepartmentInstance?.jobs}">（多部门用英文逗号“,”隔开）</td>
    </tr>
    </tr>
    <tr>
        <td>部门职能：</td>
        <td><textarea name="responsibility" class="wysihtml5 form-control" rows="10">${frameworkDepartmentInstance?.responsibility}</textarea></td>
    </tr>
    <tr>
        <td></td>
        <td align="right"><button type="submit" class="btn btn-info">保存</button><a href="javascript:history.go(-1);" class="ml20 btn btn-info">取消</a></td>
    </tr>
</table>