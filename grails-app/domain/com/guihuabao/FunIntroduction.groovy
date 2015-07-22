package com.guihuabao

class FunIntroduction {
    String introduction
    Date dateCreate
    static constraints = {
        introduction(nullable: true)
        dateCreate(nullable: true)
    }
}
