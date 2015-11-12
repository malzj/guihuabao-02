package com.guihuabao

class Caiwu {
    String cid
    String uid
    String begintime
    String endtime
    String mouth
    String yingshou
    String maolilv
    String pingxiaobi
    String jinglirun

    static constraints = {
         cid(nullable: true)
         uid(nullable: true)
         begintime(nullable: true)
         endtime(nullable: true)
         mouth(nullable: true)
         yingshou(nullable: true)
         maolilv(nullable: true)
         pingxiaobi(nullable: true)
         jinglirun(nullable: true)
    }
}
