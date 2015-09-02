package com.guihuabao

class Feedback {
     String content     //内容
    String username     //用户名
    String userId       //用户id
    static constraints = {
        content(nullable: true)
        username(nullable: true)
        userId(nullable: true)
    }
}
