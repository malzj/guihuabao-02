package com.guihuabao

class Inform {
    String title
    String introduction     //介绍
    Date dateCreate     //创建时间
    static constraints = {
        title(nullable: true)
        introduction(nullable: true)
        dateCreate(nullable: true)
    }
}
