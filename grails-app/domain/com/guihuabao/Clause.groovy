package com.guihuabao

class Clause {
    String introduction
    Date dateCreate
    static constraints = {
        introduction(nullable: true)
        dateCreate(nullable: true)
    }
}
