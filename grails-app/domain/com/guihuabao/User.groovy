package com.guihuabao

class User {
    String name  //真实姓名
    String city     //城市
    String phone    //电话
    Integer cid     //公司id
    String address  //地址
    String username //用户名
    String password //密码
    String img  //图片
    Integer rid     //权限
    Date dateCreat  //创建时间

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
