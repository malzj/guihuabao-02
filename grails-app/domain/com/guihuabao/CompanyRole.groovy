package com.guihuabao

class CompanyRole {
    String remark
    String rolename
    Date dateCreat
    static constraints = {
        remark(nullable:true)
        rolename(nullable:true)
    }
}
