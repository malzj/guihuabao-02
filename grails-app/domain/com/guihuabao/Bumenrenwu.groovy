package com.guihuabao

class Bumenrenwu {
   String cid      //公司id
    String uid      //用户id
    String title     //标题
    String content      //内容
    String etime      //完成时间
    String dateCreate      //创建时间
    String sid      //选择部门id
    String sname //选择部门名字
    static constraints = {
        cid(nullable: true)
        uid(nullable: true)
        title (nullable: true)
        content (nullable: true)
        etime(nullable: true)
        dateCreate(nullable: true)
        sid(nullable: true)
        sname(nullable:true)
    }
}
