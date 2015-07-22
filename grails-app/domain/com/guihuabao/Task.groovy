package com.guihuabao

class Task {
    String status
    String playstatus
    String title
    String content
    String playuid
    String fzuid
    String lookstatus
    String cid
    String bid
    String bigentime
    String overtime
    String time


    static constraints = {
        status(nullable: true)
        playstatus(nullable: true)
        title(nullable: true)
        content(nullable: true)
        playuid(nullable: true)
        fzuid(nullable: true)
        lookstatus(nullable: true)
        cid(nullable: true)
        bid(nullable: true)
        bigentime(nullable: true)
        overtime(nullable: true)
        time(nullable: true)
    }
}
