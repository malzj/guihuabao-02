package com.guihuabao

class Chapter {

    String chapterName
    String remark
    Date dateCreate
    static hasMany = [contents: Content]
    static belongsTo = [syllabus: Syllabus]

    static constraints = {
        chapterName(nullable: true)
        remark(nullable: true)
    }
}
