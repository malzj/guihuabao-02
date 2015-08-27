package com.guihuabao

class User {
    String name  //真实姓名
    String city
    String phone
    Integer cid     //公司id
    String address
    String username
    String password
    String img
    Integer rid     //权限
    Date dateCreat

    static constraints = {
        name(nullable: true)
        city(nullable: true)
        phone(nullable: true)
        cid(nullable: true)
        address(nullable: true)
        username(nullable: true)
        password(nullable: true)
        img(nullable: true)
        rid(nullable: true)
        dateCreat(nullable: true)
    }
}
