package com.guihuabao

class CompanyApps {
    String cid//公司id
    String name//应用名称（用于公司自己设置应用名称）
    String img//应用图片（用于公司自己设置应用图片）
    String appurl//应用链接
    Date buydate//购买时间
    Date enddate//到期时间
    static belongsTo = [app: Apps]
    static hasMany = [showApp:ShowApp]
    static constraints = {
        cid(nullable:true)
        name(nullable: true)
        img(nullable: true)
        appurl(nullable: true)
        buydate(nullable: true)
        enddate(nullable: true)
    }
}
