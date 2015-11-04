package com.guihuabao

class Bumen {
    String name     //部门名称
    Integer affiliated     //所属部门
    String remark   //备注
    String cid      //公司id
    Date dateCreate     //创建时间

    static constraints = {
        name(nullable:true)
        affiliated(nullable:true)
        remark(nullable:true)
        cid(nullable:true)
    }
}
