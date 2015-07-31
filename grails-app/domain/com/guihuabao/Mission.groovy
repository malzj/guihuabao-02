package com.guihuabao

import org.apache.tools.ant.taskdefs.Tar

class Mission {
    String status    //执行状态
    String tid      //目标id
    String title    //概述
    String content  //详情
    String playuid  //执行人id
    String bid  //部门id
    String begintime    //开始时间
    String overtime     //截止时间日
    String overhour     //截止时间时分
    Date dateCreate     //创建时间
    static belongsTo = [target:Target]
    static constraints = {
        status(nullable: true)
        tid(nullable:true)
        title(nullable: true)
        content(nullable: true)
        playuid(nullable: true)
        bid(nullable: true)
        begintime(nullable: true)
        overtime(nullable: true)
        overhour(nullable: true)
        dateCreate(nullable: true)
    }
}
