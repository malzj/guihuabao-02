package com.guihuabao

class Target {
    String cid
    String fzuid
    String btime
    String etime
    String ctime
    String content
    String title
    String percent
    String img
    static hasMany = [mission:Mission]
    static constraints = {
        cid(nullable: true)
        fzuid(nullable: true)
        btime(nullable: true)
        etime(nullable: true)
        ctime(nullable: true)
        content(nullable: true)
        title(nullable: true)
        percent(nullable: true)
        img(nullable: true)

    }
}
