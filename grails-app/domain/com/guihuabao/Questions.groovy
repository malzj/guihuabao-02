package com.guihuabao

class Questions {
    Integer num //排序（题号）
    String question //题目
    static belongsTo = [testPapers: TestPaper]
    static hasMany = [menus: Options]
    static constraints = {
        num(nullable:true)
    }
}
