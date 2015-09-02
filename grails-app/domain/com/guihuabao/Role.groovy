package com.guihuabao

class Role {
    String remark   //备注
    String rolename     //权限名
    Date dateCreat      //创建时间
    static constraints = {
        remark(nullable:true)
        rolename(nullable:true)
    }
}
