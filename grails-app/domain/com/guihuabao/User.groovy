package com.guihuabao

class User {
    String name
    String city
    String phone
    Integer cid
    String address
    String username
    String password
    Integer rid
    Date dateCreat

    static constraints = {
        name(nullable: true)
        city(nullable: true)
        phone(nullable: true)
        cid(nullable: true)
        address(nullable: true)
        username(nullable: true)
        password(nullable: true)
        rid(nullable: true)
        dateCreat(nullable: true)
    }
}
