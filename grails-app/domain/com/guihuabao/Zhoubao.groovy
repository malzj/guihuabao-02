package com.guihuabao

class Zhoubao {
    Integer uid
    String username
    Integer bid
    Integer cid
    String year
    String month
    String week
    String performance
    String xinde
    String plan
    String cooperate
    String uploadFile
    Integer submit
    Integer reply
    Date dateCreate
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