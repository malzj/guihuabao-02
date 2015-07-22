package com.guihuabao

class Content {

    String title
    String introduction
    Date dateCreate
    static belongsTo = [chapter: Chapter]
    static constraints = {
        title(nullable: true)
        introduction(nullable: true)
        dateCreate(nullable: true)
    }
}
