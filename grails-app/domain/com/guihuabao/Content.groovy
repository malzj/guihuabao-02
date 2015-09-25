package com.guihuabao

class Content {

    String title    //标题
    String introduction     //介绍
    Long num //内容排序
    Date dateCreate     //创建时间
    static belongsTo = [chapter: Chapter]
    static constraints = {
        title(nullable: true)
        introduction(nullable: true)
        dateCreate(nullable: true)
    }
}
