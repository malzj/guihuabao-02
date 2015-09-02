package com.guihuabao

class Apply {
    String type     //申请类型
    String applyuid     //申请人id
    String applyusername        //申请人用户名
    String content      //申请内容
    String approvaluid      //审批人id
    String approvalusername     //审批人用户名
    String status//中文审核状态 未审核  已通过 未通过
    String cid      //公司id
    String approvetext      //审批反馈
    Date dateCreate     //申请时间
    Integer applystatus//审核状态 0未审核1已通过2未通过
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
