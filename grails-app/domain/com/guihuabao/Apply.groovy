package com.guihuabao

class Apply {
    String type
    String applyuid
    String applyusername
    String content
    String approvaluid
    String approvalusername
    static constraints = {
        type(nullable: true)
        applyuid(nullable: true)
        applyusername(nullable: true)
        content(nullable: true)
        approvaluid(nullable: true)
        approvalusername(nullable: true)
    }
}
