package com.guihuabao

class Chapter {

    String chapterName  //章节名
    String remark   //备注
    Date dateCreate     //创建时间
    static hasMany = [contents: Content]
    static belongsTo = [syllabus: Syllabus]

    static constraints = {
        chapterName(nullable: true)
        remark(nullable: true)
    }
}
