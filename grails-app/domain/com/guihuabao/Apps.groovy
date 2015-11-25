package com.guihuabao

class Apps {
    String appName//应用名称
    String appIntrodaction//应用介绍
    String appImg//应用图片(路径 uploadfile/appimg)
    String appurl//应用链接
    String apptype//应用链接
    Date dateCreate//应用创建时间

    static hasMany = [companyApp: CompanyApps]
    static constraints = {
        appName(nullable: true)
        appIntrodaction(nullable: true)
        appImg(nullable: true)
        appurl(nullable: true)
        apptype(nullable: true)
        dateCreate(nullable: true)
    }
}
