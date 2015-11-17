package com.guihuabao

class Options {
    String letter //选项字母
    String content //题目内容
    Integer score //分数
    String analysis //题目解析
    static belongsTo = [questions: Questions]
    static constraints = {
        letter(nullable: true)
        content(nullable: true)
        score(nullable: true)
        analysis(nullable: true)
    }
}
