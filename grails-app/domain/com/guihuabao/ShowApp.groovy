package com.guihuabao

class ShowApp {
    String cid//公司id
    String uid//用户id
    String name//应用名称（用于公司自己设置应用名称）
    String img//应用图片（用于公司自己设置应用图片）
    Date buydate//购买时间
    Date enddate//到期时间
    String appurl//链接
    Integer num//排序的序列号
    static belongsTo = [companyApp:CompanyApps]
    static constraints = {
        name(nullable: true)
        img(nullable: true)
        buydate(nullable: true)
        enddate(nullable: true)
        cid(nullable: true)
        uid(nullable:true)
        num(nullable:true)
    }
}
