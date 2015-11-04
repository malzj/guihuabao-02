package com.guihuabao

class CompanyUser {
    String username     //用户名
    String password     //密码
    Integer cid         //公司id
    Integer rid         //权限id
    Integer pid //角色 决策 管理  执行
    String name     //真实姓名
    String img      //头像
    String sex      //性别
    String phone       //电话
    Integer bid //部门
    String position //员工职位
    String responsibility //员工职责
    Date dateCreat  //创建时间

    static constraints = {
        username(nullable: true)
        password(nullable: true)
        cid(nullable: true)
        rid(nullable: true)
        pid(nullable: true)
        name(nullable: true)
        img(nullable: true)
        sex(nullable: true)
        phone(nullable: true)
        bid(nullable: true)
        position(nullable: true)
        responsibility(nullable: true)
        dateCreat(nullable: true)
    }
}
