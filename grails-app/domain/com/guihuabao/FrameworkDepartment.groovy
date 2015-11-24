package com.guihuabao

class FrameworkDepartment {
    String name   //部门名称
    String responsibility //部门职能
    String jobs //职位


    static constraints = {
        responsibility(nullable: true)
        jobs(nullable: true)
    }
}
