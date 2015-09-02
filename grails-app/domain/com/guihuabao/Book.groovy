package com.guihuabao

class Book {

    String bookName     //书名
    String bookImg      //封面
    String remark       //备注
    Date dateCreate     //创建时间
    static hasMany = [syllabus: Syllabus]
    static constraints = {
        bookName(nullable: true)
        bookImg(nullable: true)
        remark(nullable: true)
    }
}
