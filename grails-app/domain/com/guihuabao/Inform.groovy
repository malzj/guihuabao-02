package com.guihuabao

class Inform {
    String introduction     //介绍
    Date dateCreate     //创建时间
    static constraints = {
        introduction(nullable: true)
        dateCreate(nullable: true)
    }
}
