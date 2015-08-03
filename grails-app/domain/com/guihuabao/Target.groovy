package com.guihuabao

class Target {
    String cid
    String fzuid
    String begintime
    String etime
    Date dateCreate
    String content
    String title
    String percent
    String img
    String status
    static hasMany = [mission:Mission]
    static constraints = {
        cid(nullable: true)
        fzuid(nullable: true)
        begintime(nullable: true)
        etime(nullable: true)
        dateCreate(nullable: true)
        content(nullable: true)
        title(nullable: true)
        percent(nullable: true)
        img(nullable: true)
        status(nullable:true)
    }
}
