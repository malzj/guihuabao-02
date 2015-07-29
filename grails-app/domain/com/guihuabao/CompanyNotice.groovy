package com.guihuabao

class CompanyNotice {
    String cid
    String title
    String content
    Date dateCreate
    static constraints = {
        cid(nullable: true)
        title(nullable: true)
        content(nullable: true)
        dateCreate(nullable: true)
    }
}
