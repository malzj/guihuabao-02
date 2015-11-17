package com.guihuabao

class Questions {
    Integer num //排序（题号）
    String question //题目
    Integer type //1.填空 2.选择
    Integer blank //空位个数
    static belongsTo = [testPapers: TestPaper]
    static hasMany = [menus: Options]
    static constraints = {
        num(nullable:true)
        blank(nullable:true)
    }
}
