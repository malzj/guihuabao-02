package com.guihuabao

class Company {
    String companyname
    String companyAbbrev
    String contactName
    String sex
    String job
    String telephone
    String email
    String fax
    String companyType
    Date regtime
    String postalcode
    String website
    String remark
    Date dateUse
    Date dateCreat
    String address
    String phone
    String logoimg

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
