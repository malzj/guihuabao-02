package com.guihuabao

class Target {
    String cid              //公司id
    String fzuid            //负责人id
    String begintime       // 起始时间
    String etime            //结束时间
    Date dateCreate        // 创建时间
    String content          //详情
    String title            //标题
    Integer percent         //权重
    String img              //图片
    String status           //状态0未完成1已完成
    String ischeck          //完成的目标是否查看过了（未查看0，已查看1）
    String targetzj         //目标总结
    String issubmit         //是否下发0下发1未下发
    String isedit           //是否可以编辑   所有的任务都接受了以后并且所有任务权重之和为100时任务就不可以修改和删除了
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
        targetzj(nullable:true)
        issubmit(nullable:true)
        isedit(nullable:true)
        ischeck(nullable:true)
    }
}
