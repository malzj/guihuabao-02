package com.guihuabao

class Role {
    String remark
    String rolename
    Date dateCreat
    static constraints = {
        remark(nullable:true)
        rolename(nullable:true)
    }
}
