package com.guihuabao

class TestPaper {
    String title //试卷名称
    String remark //备注
    Date dateCreate //创建时间
    static hasMany = [questions: Questions]
    static constraints = {
        remark(nullable: true)
    }
}
