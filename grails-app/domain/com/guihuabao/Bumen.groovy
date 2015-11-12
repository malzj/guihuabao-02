package com.guihuabao

class Bumen {
    String name     //部门名称
    Integer affiliated     //所属部门
    String remark   //备注
    String cid      //公司id
    String responsibility //部门职责
    Date dateCreate     //创建时间

    static constraints = {
        name(nullable:true)
        affiliated(nullable:true)
        remark(nullable:true)
        cid(nullable:true)
        responsibility(nullable:true)
    }
}
