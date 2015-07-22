package com.guihuabao

class Feedback {
     String content
    String username
    String userId
    static constraints = {
        content(nullable: true)
        username(nullable: true)
        userId(nullable: true)
    }
}
