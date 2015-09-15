package com.guihuabao

import org.apache.tools.ant.taskdefs.Tar

class Mission {
    String status    //执行状态 0未读1已读2接受未完成3接受已完成
    Integer percent //权重
    String title    //概述
    String content  //详情
    String playuid  //执行人id
    String playname //执行人
    String bid       //部门id
    String begintime    //开始时间
    String overtime     //截止时间日

    Date dateCreate     //创建时间
    String hasvisited   //是否已阅读
    String issubmit     //是否下发
//    String reply        //是否有回复
    String playstatus   //紧急状态 1紧急且重要2紧急不重要3重要不紧急4不重要不紧急
    static belongsTo = [target:Target]
    static hasMany = [replymission: ReplyMission]
    static constraints = {
        status(nullable: true)
        percent(nullable:true)
        title(nullable: true)
        content(nullable: true)
        playuid(nullable: true)
        playname(nullable:true)
        bid(nullable: true)
        begintime(nullable: true)
        overtime(nullable: true)

        dateCreate(nullable: true)
        hasvisited(nullable:true)
        issubmit(nullable:true)
//        reply(nullable: true)
        playstatus(nullable: true)
    }
}
