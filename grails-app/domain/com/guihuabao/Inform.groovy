package com.guihuabao

class Inform {
    String introduction
    Date dateCreate
    static constraints = {
        introduction(nullable: true)
        dateCreate(nullable: true)
    }
}
