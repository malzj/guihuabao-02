package com.guihuabao

class Syllabus {


    String syllabusName
    String remark
    Date dateCreate
    static hasMany = [chapters: Chapter]
    static belongsTo = [book: Book]
    static constraints = {
        syllabusName(nullable: true)
        remark(nullable: true)
    }
}
