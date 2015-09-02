package com.guihuabao

class Syllabus {


    String syllabusName     //大纲名
    String remark       //备注
    Date dateCreate     //创建时间
    static hasMany = [chapters: Chapter]
    static belongsTo = [book: Book]
    static constraints = {
        syllabusName(nullable: true)
        remark(nullable: true)
    }
}
