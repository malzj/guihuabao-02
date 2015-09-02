package com.guihuabao

class ReplyReport {
    Integer cid
    Integer puid    //评论人id
    String puname   //评论人名字
    Integer bpuid   //被评人id
    String bpuname  //被评人名字
    Integer status  //0未读1已读
    String content  //评论内容
    Date date       //评论时间
    static belongsTo = [zhoubao: Zhoubao]
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
