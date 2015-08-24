package com.guihuabao

class HexuTool {
    String toolName //工具或案例名称
    String toolImg//工具或案例图片
    String remark//工具或案例备注
    String style//工具1或案例2
    Date dateCreate//创建时间
    static hasMany = [ToolContents: ToolContent]


    static constraints = {
        toolName(nullable: true)
        toolImg(nullable: true)
        remark(nullable: true)
        style(nullable: true)
    }
}
