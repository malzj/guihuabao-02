package com.guihuabao

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

import java.text.SimpleDateFormat

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
        taskInstance.remindstatus = 0
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
    //获取部门
        def bumenlist(){
    def rs=[:]
        def cid = params.cid
        def bumenlist= Bumen.findAllByCid(cid)
        if(bumenlist){
            rs.result = true
            rs.bumenlist = bumenlist
        }else {
            rs.result=false
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //获取部门员工
    def bumenCompanyUserList(){
        def rs=[:]
        def bid = params.bid
        def cid = params.cid
        def companyUserList = CompanyUser.findAllByCidAndBid(cid,bid)
        if(companyUserList){
            rs.result =true
            rs.companyUserList = companyUserList
        }else {
           rs.result = false
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //我的任务
      def  mytask(){
      def rs =[:]
      def userId = params.userId
      def cid = params.cid
          def current = new Date()
          SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd")
          def now = time.format(current)
          def order = [sort:"dateCreate",order: "desc"]
          def todayTaskList = Task.findAllByCidAndPlayuidAndLookstatusAndStatusAndBigentimeLessThanEqualsAndOvertimeGreaterThanEquals(cid,userId,2,0,now,now,order)
          def dueTaskList = Task.findAllByCidAndPlayuidAndLookstatusAndStatusAndOvertimeGreaterThanEquals(cid,userId,2,0,now,[sort:"overtime",order:"desc"])
            if(todayTaskList||dueTaskList){
                rs.result =true
                rs.todayTaskList=todayTaskList
                rs.dueTaskList=dueTaskList
            }    else {
                rs.result = false
                rs.todayTaskList=todayTaskList
                rs.dueTaskList=dueTaskList
            }

          if (params.callback) {
              render "${params.callback}(${rs as JSON})"
          } else
              render rs as JSON
      }
    //删除任务
    def taskDelete(){
        def id= params.id
        def cid = params.cid
        def taskInstnstance = Task.findByIdAndCid(id,cid)
        def rs = [:]
        if (!taskInstnstance) {
            rs.result = false
            rs.msg="没有找到对应任务"
        }else {
            try {
                taskInstnstance.delete(flush: true)
                rs.result = true
                rs.msg="删除成功"
            }
            catch (DataIntegrityViolationException e) {
                rs.result = false
                rs.msg="删除未成功"
            }

        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //完成任务
         def taskupdate(){
        def rs =[:]
        def id = params.id
        def cid = params.cid
        def taskInstance = Task.findByCidAndId(cid,id)
        if (taskInstance){
            taskInstance.status = 1
            taskInstance.remindstatus = 1
            if (!taskInstance.save(flush: true)) {
                rs.result = false
                rs.msg ="未完成"
            }else {
                rs.result= true
                rs.msg ="已完成"
            }
        }else {
            rs.result = false
            rs.msg ="未找到任务"
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //负责任务列表
       def fztaskList(){
           def rs= [:]
           def userId = params.userId
           def cid = params.cid

           params.max = 5
           params<<[sort: "id",order: "desc"]
           def offset = 0;


           if (params.offset.toInteger()>0){
               offset =params.offset.toInteger()
           }
           params<<[offset:offset]
           def fztaskSize = Task.countByCidAndFzuid(cid,userId)
           def x = fztaskSize
           def offse=params.offset.toInteger()
           if (x>offse){
               def fztaskList = Task.findAllByFzuidAndCid(userId,cid,params)
               if (fztaskList){
                   rs.result =  true
                   rs.fztaskList=fztaskList
               }else {
                   rs.result = false
                   rs.msg="已加载所有数据"
               }
           }else {
               rs.result = false
               rs.msg="已加载所有数据"
           }

           if (params.callback) {
               render "${params.callback}(${rs as JSON})"
           } else
               render rs as JSON
       }
    //参与任务列表
    def cytaskList(){
        def rs= [:]
        def userId = params.userId
        def cid = params.cid

        params.max = 5
        params<<[sort: "id",order: "desc"]
        def offset = 0;


        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def fztaskSize = Task.countByCidAndPlayuid(cid,userId)
        def x = fztaskSize
        def offse=params.offset.toInteger()
        if (x>offse){
            def cytaskList = Task.findAllByPlayuidAndCid(userId,cid,params)
            if (cytaskList){
                rs.result =  true
                rs.cytaskList=cytaskList
            }else {
                rs.result = false
                rs.msg="已加载所有数据"
            }
        }else {
            rs.result = false
            rs.msg="已加载所有数据"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //任务详情
    def taskInstance(){
        def rs =[:]
        def cid = params.cid
        def id = params.id
        def userId = params.userId
        def replyId = params.replyId
        if (replyId){
            def rep =ReplyTask.get(replyId)
            rep.status =1
        }
        def taskInstance = Task.findByCidAndId(cid,id)
        if (userId==taskInstance.playuid){
              if (taskInstance.lookstatus==0){
                taskInstance.lookstatus=1
                taskInstance.save(flush: true)
            }
        }
        if (userId == taskInstance.fzuid){
            if(taskInstance.remindstatus==1){
                taskInstance.remindstatus=2
            }
        }
        if (taskInstance){
            rs.result =true
            rs.taskInstance = taskInstance
            rs.replaytasks  =taskInstance.replaytasks
        }else {
            rs.result =false
            rs.msg="未找到任务"
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //接受任务
    def taskInstanceupdateLookStaust(){
        def rs =[:]
        def cid = params.cid
        def id = params.id
        def userId = params.userId
        def taskInstance = Task.findByCidAndId(cid,id)
        if (userId==taskInstance.playuid){
            taskInstance.lookstatus=2
            taskInstance.save(flush: true)
        }
        if (taskInstance){
            rs.result =true
            rs.taskInstance = taskInstance
            rs.replaytasks  =taskInstance.replaytasks
        }else {
            rs.result =false
            rs.msg="未找到任务"
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //未接受任务
    def wjstaskList(){
             def rs=[:]
             def userId = params.userId
             def cid = params.cid
             params.max = 5
             params<<[sort: "id",order: "desc"]
             def offset = 0;


             if (params.offset.toInteger()>0){
                 offset =params.offset.toInteger()
             }
             params<<[offset:offset]
             def fztaskSize = Task.countByCidAndPlayuidAndLookstatus(cid,userId,1)
             def x = fztaskSize
             def offse=params.offset.toInteger()
             if (x>offse){
                 def wjstaskList = Task.findAllByPlayuidAndCidAndLookstatus(userId,cid,1,params)
                 if (wjstaskList){
                     rs.result =  true
                     rs.wjstaskList=wjstaskList
                 }else {
                     rs.result = false
                     rs.msg="已加载所有数据"
                 }
             }else {
                 rs.result = false
                 rs.msg="已加载所有数据"
             }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
         }
    //未读任务
    def wdtaskList(){
             def rs=[:]
             def userId = params.userId
             def cid = params.cid
             params.max = 5
             params<<[sort: "id",order: "desc"]
             def offset = 0;


             if (params.offset.toInteger()>0){
                 offset =params.offset.toInteger()
             }
             params<<[offset:offset]
             def fztaskSize = Task.countByCidAndPlayuidAndLookstatus(cid,userId,0)
             def x = fztaskSize
             def offse=params.offset.toInteger()
             if (x>offse){
                 def wdtaskList = Task.findAllByPlayuidAndCidAndLookstatus(userId,cid,0,params)
                 if (wdtaskList){
                     rs.result =  true
                     rs.wdtaskList=wdtaskList
                 }else {
                     rs.result = false
                     rs.msg="已加载所有数据"
                 }
             }else {
                 rs.result = false
                 rs.msg="已加载所有数据"
             }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
         }
    //未读的回复
    def wdReplyTaskList(){
        def rs=[:]
        def replyInfo = []
        def userId = params.userId
        def cid =params.cid
        def replyTaskList = ReplyTask.findAllByCidAndBpuidAndStatus(cid,userId,0)
        if (replyTaskList){
            for (def i=0;i<replyTaskList.size();i++){
                def info= [:]
                def allInfo=replyTaskList.get(i)
                allInfo.img=CompanyUser.findByIdAndCid(allInfo.puid,cid).img
                allInfo.title=allInfo.tasks.title
                info.allInfo=allInfo

//                info.allInfo<<[title:allInfo.tasks.title]
//                info.allInfo<<[img:CompanyUser.findByIdAndCid(allInfo.puid,cid).img]
                replyInfo<<info
            }
            rs.result = true
            rs.replyInfo = replyInfo
//            rs.replyTaskList=replyTaskList
        }else {
            rs.result =false
            rs.msg = "没有未回复消息"
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //新增回复
    def saveReplyTask(){
        def rs=[:]
        def   id = params.id
        def taskInstance =Task.get(id)

        def replyTaskInstance = new ReplyTask(params)
        replyTaskInstance.tasks=taskInstance
        if (!replyTaskInstance.save(flush: true)) {
            rs.result =false
            rs.msg = "没有回复成功"
        }else {
            rs.result = true
            rs.replyTaskInstance=replyTaskInstance
            rs.task = replyTaskInstance.tasks
            rs.replyTaskList = replyTaskInstance.tasks.replaytasks
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
}