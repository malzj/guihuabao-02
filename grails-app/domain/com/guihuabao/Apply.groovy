package com.guihuabao

class Apply {
    String type
    String applyuid
    String applyusername
    String content
    String approvaluid
    String approvalusername
    String status
    String cid
    String dateCreate
    Integer applystatus
    Integer applystatuss
    static constraints = {
        type(nullable: true)
        applyuid(nullable: true)
        applyusername(nullable: true)
        content(nullable: true)
        approvaluid(nullable: true)
        approvalusername(nullable: true)
        status(nullable: true)
        cid(nullable: true)
        dateCreate(nullable: true)
        applystatus(nullable: true)
        applystatuss(nullable: true)

    }
}
