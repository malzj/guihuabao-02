package com.guihuabao

class ReplyMission {

    Integer cid     //公司id
    Integer puid    //评论人id
    String puname   //评论人姓名
    Integer bpuid   //被评人id
    String bpuname  //被评人姓名
    Integer status  //0未读1已读
    String content  //评论内容
    String date     //评论时间
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
