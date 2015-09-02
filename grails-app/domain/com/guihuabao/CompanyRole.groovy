package com.guihuabao

class CompanyRole {
    String remark       //备注
    String rolename     //角色
    Date dateCreat      //创建时间
    static constraints = {
        remark(nullable:true)
        rolename(nullable:true)
    }
}
