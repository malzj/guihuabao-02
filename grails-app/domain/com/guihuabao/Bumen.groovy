package com.guihuabao

class Bumen {
    String name
    String remark
    String cid
    Date dateCreate

    static constraints = {
        name(nullable:true)
        remark(nullable:true)
        cid(nullable:true)
    }
}
