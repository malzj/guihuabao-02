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
    String remindstatus //完成提醒状态提醒上级（未完成0,已完成1,上级已查看2）
    String targetzj         //目标总结
    String issubmit         //是否下发0下发1未下发
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
    }
}
