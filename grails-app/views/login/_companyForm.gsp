<table>
    <tr>
        <td>企业名称：</td>
        <td width="345"><input name="companyname" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${companyInstance?.companyname}"></td>
    </tr>
    <tr>
        <td>企业简称：</td>
        <td><input name="companyAbbrev" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${companyInstance?.companyAbbrev}"></td>
    </tr>
    <tr>
        <td>企业联系人：</td>
        <td><input name="contactName" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${companyInstance?.contactName}"></td>
    </tr>
    <tr>
        <td>联系人性别：</td>
        <td><input name="sex" type="radio" value="男" <g:if test="${companyInstance?.sex=="男"}">checked="checked" </g:if> />男
            <input name="sex" type="radio" value="女" <g:if test="${companyInstance?.sex=="女"}">checked="checked" </g:if> />女</td>
    </tr>
    <tr>
        <td>职务：</td>
        <td><input name="job" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${companyInstance?.job}"></td>
    </tr>
    <tr>
        <td>公司电话：</td>
        <td><input name="phone" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${companyInstance?.phone}"></td>
    </tr>
    <tr>
        <td>移动电话：</td>
        <td><input name="telephone" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${companyInstance?.telephone}"></td>
    </tr>
    <tr>
        <td>电子邮件：</td>
        <td><input name="email" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${companyInstance?.email}"></td>
    </tr>
    <tr>
        <td>传真：</td>
        <td><input name="fax" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${companyInstance?.fax}"></td>
    </tr>
    <tr>
        <td>企业类型：</td>
        <td><input name="companyType" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${companyInstance?.companyType}"></td>
    </tr>
    <tr>
        <td>企业成立时间：</td>
        <td><g:datePicker name="regtime" precision="day"  value="${companyInstance?.regtime}"  /></td>
    </tr>
    <tr>
        <td>通信地址：</td>
        <td><input name="address" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${companyInstance?.address}"></td>
    </tr>
    <tr>
        <td>邮政编码：</td>
        <td><input name="postalcode" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${companyInstance?.postalcode}"></td>
    </tr>
    <tr>
        <td>网址：</td>
        <td><input name="website" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${companyInstance?.website}"></td>
    </tr>
    <tr>
        <td>备注：</td>
        <td><input name="remark" class="form-control form-control-inline input-medium default-date-picker" type="text" value="${companyInstance?.remark}"></td>
    </tr>
    <tr>
        <td>使用时间：</td>
        <td><g:datePicker name="dateUse" precision="day"  value="${companyInstance?.dateUse}"  /></td>
    </tr>
    <tr>
        <td>
            创建时间：
        </td>
        <td>
            <g:datePicker name="dateCreat" precision="day"  value="${companyInstance?.dateCreat}"  />
        </td>
    </tr>
    <tr>
        <td>公司logo：</td>
        <td><input type="file" name="file1" value="${companyInstance?.logoimg}" /></td>
    </tr>
    <tr>
        <td></td>
        <td align="right">
            <button type="submit" class="btn btn-info">保存</button>
        </td>
    </tr>
</table>
