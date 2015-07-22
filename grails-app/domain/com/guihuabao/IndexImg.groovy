package com.guihuabao

class IndexImg {
    String img
    Date dateCreate

    static constraints = {
        img(nullable: true)
        dateCreate(nullable: true)
    }
}
