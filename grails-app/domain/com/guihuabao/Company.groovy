package com.guihuabao

class Company {
    String companyname  //公司名称
    String companyAbbrev    //企业简称
    String contactName      //企业联系人
    String sex          //联系人性别
    String job          //职务
    String telephone        //移动电话
    String email            //电子邮件
    String fax              //传真
    String companyType      //企业类型
    Date regtime            //企业成立时间
    String postalcode       //邮政编码
    String website          //网址
    String remark           //备注
    Date dateUse            //使用时间
    Date dateCreat          //创建时间
    String address          //通信地址
    String phone            //公司电话
    String logoimg          //公司logo

    static constraints = {
        companyname(nullable: true)
        remark(nullable: true)
        address(nullable: true)
        phone(nullable: true)
        companyAbbrev(nullable: true)
        contactName(nullable: true)
        sex(nullable: true)
        job(nullable: true)
        telephone(nullable: true)
        email(nullable: true)
        fax(nullable: true)
        companyType(nullable: true)
        regtime(nullable: true)
        postalcode(nullable: true)
        website(nullable: true)
        logoimg(nullable: true)
    }
}
