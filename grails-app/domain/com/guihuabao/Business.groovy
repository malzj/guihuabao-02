package com.guihuabao

class Business {
    String companyname
    String name
    String telphone
    String email
    String content
    static constraints = {
        companyname(nullable: true)
        name(nullable: true)
        telphone(nullable: true)
        content(nullable: true)
        email(nullable: true)
        content(nullable: true)
    }
}
