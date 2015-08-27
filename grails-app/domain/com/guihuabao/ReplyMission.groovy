package com.guihuabao

class ReplyMission {

    Integer cid
    Integer puid    //评论人id
    String puname   //评论人姓名
    Integer bpuid   //被评人id
    String bpuname  //被评人姓名
    Integer status
    String content
    String date
    static belongsTo = [mission: Mission]
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
