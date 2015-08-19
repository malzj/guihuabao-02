package com.guihuabao

class Apply {
    String type
    String applyuid
    String applyusername
    String content
    String approvaluid
    String approvalusername
    String status//中文审核状态
    String cid
    String approvetext
    Date dateCreate
    Integer applystatus//审核状态
    Integer applystatuss//提交状态(草稿0，提交1)
    String remindstatus//审核提醒状态（初始或查看后0，审核但未查看1）
    static constraints = {
        type(nullable: true)
        applyuid(nullable: true)
        applyusername(nullable: true)
        content(nullable: true)
        approvaluid(nullable: true)
        approvalusername(nullable: true)
        status(nullable: true)
        cid(nullable: true)
        approvetext(nullable: true)
        dateCreate(nullable: true)
        applystatus(nullable: true)
        applystatuss(nullable: true)
        remindstatus(nullable: true)
    }
}
