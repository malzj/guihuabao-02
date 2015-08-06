package com.guihuabao

import grails.converters.JSON

class GuihuabaoapiController {
    static allowedMethods = [login: "POST", update: "POST", delete: "POST"]
    //系统登陆
    def login(){
        def rs= [:]
        def username= params.username
        def password = params.password
        def companyUser = CompanyUser.findByUsernameAndPassword(username,password)
        if(!companyUser){
            rs.msg="您的账号密码输入有误"
            rs.result=false
        }else {
            def date= new Date()
            def company= Company.get(companyUser.cid)
            if (company.dateUse>date){
                rs.user=companyUser
                rs.company=company
                rs.msg="欢迎登陆规划宝"
                rs.result=true
            }else {
                rs.result=false
                rs.msg="您的公司账号已过期"
            }
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //任务新增
    def taskSave(){
        def rs = [:]
        def taskInstance = new Task(params)
        taskInstance.dateCreate = new Date()
        if (!taskInstance.save(flush: true)) {
          rs.result=false
          rs.msg="未保存成功"
        }else {
            rs.result=true
            rs.msg="保存成功"
            rs.task=taskInstance
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
}
