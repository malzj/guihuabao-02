package com.guihuabao

class Task {
    String status    //执行状态
    String playstatus   //紧急状态
    String title
    String content
    String playuid
    String fzuid
    String fzname
    String playname
    String lookstatus  //查看状态
    String cid
    String bid
    String bigentime
    String overtime
    String overhour
    Date dateCreate


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
        overhour(nullable: true)
        dateCreate(nullable: true)
    }
}
