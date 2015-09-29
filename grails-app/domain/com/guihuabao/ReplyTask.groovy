package com.guihuabao

class ReplyTask {
    Integer cid     //公司id
    Integer puid    //评论人id
    String puname   //评论人姓名
    Integer bpuid   //被评人id
    String bpuname  //被评人姓名
    Integer status  //是否查看0未查看1已查看
    String content  //回复内容
    String date     //回复时间
    String img
    String title
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
