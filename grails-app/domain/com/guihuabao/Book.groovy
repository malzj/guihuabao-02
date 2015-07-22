package com.guihuabao

class Book {

    String bookName
    String bookImg
    String remark
    Date dateCreate
    static hasMany = [syllabus: Syllabus]
    static constraints = {
        bookName(nullable: true)
        bookImg(nullable: true)
        remark(nullable: true)
    }
}
