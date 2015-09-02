package com.guihuabao

class CompanyNotice {
    String cid      //公司id
    String title    //标题
    String content      //内容
    Date dateCreate     //创建时间
    static constraints = {
        cid(nullable: true)
        title(nullable: true)
        content(nullable: true)
        dateCreate(nullable: true)
    }
}
