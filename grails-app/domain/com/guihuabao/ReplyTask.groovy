package com.guihuabao

class ReplyTask {
    Integer cid
    Integer puid
    String puname
    Integer bpuid
    String bpuname
    Integer status
    String content
    Date date
    static belongsTo = [tasks: Task]
    static constraints = {
        cid(nullable: true)
        puid(nullable: true)
        puname(nullable: true)
        bpuid(nullable: true)
        bpuname(nullable: true)
        status(nullable: true)
        content(nullable: true)
        date(nullable: true)
    }
}
