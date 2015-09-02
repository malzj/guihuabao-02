package com.guihuabao

class Zhoubao {
    Integer uid     //用户id
    String username     //用户名
    Integer bid     //部门id
    Integer cid     //公司id
    String year     //年
    String month    //月
    String week     //周
    String performance  //本周工作成效
    String xinde        //心得
    String plan     //计划
    String cooperate    //团队协作
    String uploadFile   //上传文件
    Integer submit      //是否提交0未提交1提交
    Integer reply       //是否有评论0没有1有
    Date dateCreate     //创建时间
    static hasMany = [replyReports: ReplyReport]
    static constraints = {
        uid(nullable: true)
        username(nullable: true)
        bid(nullable: true)
        cid(nullable: true)
        year(nullable: true)
        month(nullable: true)
        week(nullable: true)
        performance(nullable: true)
        xinde(nullable: true)
        plan(nullable: true)
        cooperate(nullable: true)
        uploadFile(nullable: true)
        submit(nullable: true)
        reply(nullable: true)
        dateCreate(nullable: true)
    }

}