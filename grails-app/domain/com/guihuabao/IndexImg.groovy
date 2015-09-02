package com.guihuabao

class IndexImg {
    String img      //图片
    Date dateCreate     //创建时间

    static constraints = {
        img(nullable: true)
        dateCreate(nullable: true)
    }
}
