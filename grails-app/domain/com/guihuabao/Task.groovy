package com.guihuabao

class Task {
    String status    //执行状态
    String playstatus   //紧急状态
    String title  //标题
    String content//内容
    String playuid//执行人
    String fzuid//负责人id
    String fzname//负责人姓名
    String playname//执行人姓名
    String lookstatus  //查看状态0,1接受2
    String remindstatus //完成提醒状态提醒上级（未完成0,已完成1,上级已查看2）
    String reply//是否有回复
    String cid//公司id
    String bid//部门ID
    String bigentime//开始时间
    String overtime//结束日期
    String overhour//结束时间
    Date dateCreate//创建时间

    static hasMany = [replaytasks: ReplyTask]
    static constraints = {
        status(nullable: true)
        playstatus(nullable: true)
        title(nullable: true)
        content(nullable: true)
        playuid(nullable: true)
        fzuid(nullable: true)
        lookstatus(nullable: true)
        remindstatus(nullable: true)
        reply(nullable: true)
        cid(nullable: true)
        bid(nullable: true)
        bigentime(nullable: true)
        overtime(nullable: true)
        overhour(nullable: true)
        dateCreate(nullable: true)
    }
}
