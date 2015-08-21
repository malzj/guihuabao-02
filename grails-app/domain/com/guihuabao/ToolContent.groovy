package com.guihuabao

class ToolContent {
    String title//内容标题
    String introduction//内容
    Date dateCreate//创建时间
    static belongsTo = [hexutools: HexuTool]
    static constraints = {
        title(nullable: true)
        introduction(nullable: true)
        dateCreate(nullable: true)
    }
}
