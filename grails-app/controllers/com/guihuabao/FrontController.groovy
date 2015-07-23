package com.guihuabao

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.web.multipart.MultipartFile

import java.text.SimpleDateFormat
import java.util.logging.Logger

class FrontController {
    private  Logger logger


    def index() {
        print("!")
    }

    def login(){
        def username= params.username
        def password = params.password
        def companyUser = CompanyUser.findByUsernameAndPassword(username,password)
        if(!companyUser){
            flash.message = "您的账号密码输入有误"
           redirect(action: "index",id:1,msg:"您的账号密码输入有误")
            return
        }else {
            def date= new Date()
            def company= Company.get(companyUser.cid)
            if (company.dateUse>date){
                session.user=companyUser
                session.company=company
                redirect(action: "companyUserList")
            }else {
                flash.message ="您的公司账号已过期"
                redirect(action: "index",msg:"您的公司账号已过期")
                return
            }
        }

    }
    def frontIndex(){

    }
    def companyUserCreate() {
        def bumenList = Bumen.findAllByCid(session.company.id)
        [companyUserInstance: new CompanyUser(params), bumenList: bumenList]
    }
    def companyUserSave(){
        def companyUserInstance = new CompanyUser(params)
        if(params.pid==1){
            companyUserInstance.pid = 2
        }

        companyUserInstance.img = "touxiang.jpg"

        if (!companyUserInstance.save(flush: true)) {
            render(view: "companyUserCreate", model: [companyUserInstance: companyUserInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'companyUser.label', default: 'companyUser'), companyUserInstance.id])
        redirect(action: "companyUserShow", id: companyUserInstance.id)
    }
    def companyUserList(Integer max){
        params.max = Math.min(max ?: 10, 100)
        [companyUserInstanceList: CompanyUser.list(params), companyUserInstanceTotal: CompanyUser.count()]
    }
    def companyUserShow(Long id) {
        def companyUserInstance = CompanyUser.get(id)
        if (!companyUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'companyUser.label', default: 'CompanyUser'), id])
            redirect(action: "companyUserList")
            return
        }

        [companyUserInstance: companyUserInstance]
    }
    def companyUserEdit(Long id) {
        def companyUserInstance = CompanyUser.get(id)
        def bumenList = Bumen.findAllByCid(session.company.id)
        if (!companyUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'companyUser.label', default: 'CompanyUser'), id])
            redirect(action: "companyUserList")
            return
        }

        [companyUserInstance: companyUserInstance, bumenList: bumenList]
    }
    def companyUserUpdate(Long id, Long version) {
        def companyUserInstance = CompanyUser.get(id)

        if (!companyUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'companyUser.label', default: 'CompanyUser'), id])
            redirect(action: "companyUserList")
            return
        }

        if (version != null) {
            if (companyUserInstance.version > version) {
                companyUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'companyUser.label', default: 'CompanyUser')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "companyUserEdit", model: [companyUserInstance: companyUserInstance])
                return
            }
        }

        companyUserInstance.properties = params

        if (!companyUserInstance.save(flush: true)) {
            render(view: "companyUserEdit", model: [companyUserInstance: companyUserInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'companyUser.label', default: 'CompanyUser'), companyUserInstance.id])
        redirect(action: "companyUserShow", id: companyUserInstance.id)
    }
    def companyUserDelete(Long id) {
        def companyUserInstance = CompanyUser.get(id)
        if (!companyUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'companyUser.label', default: 'CompanyUser'), id])
            redirect(action: "companyUserList")
            return
        }

        try {
            companyUserInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'companyUser.label', default: 'CompanyUser'), id])
            redirect(action: "companyUserList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'companyUser.label', default: 'CompanyUser'), id])
            redirect(action: "companyUserShow", id: id)
        }
    }


    def bumenList(Integer max){
        params.max = Math.min(max ?: 10, 100)
        [bumenInstanceList:Bumen.list(params), bumenInstanceTotal: Bumen.count()]
    }
    def bumenCreate(){
        [bumenInstance: new Bumen(params)]
    }
    def bumenSave(){
        def bumenInstance = new Bumen(params)
        if (!bumenInstance.save(flush: true)) {
            render(view: "bumenCreate", model: [bumenInstance: bumenInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'bumen.label', default: 'companyUser'), bumenInstance.id])
        redirect(action: "bumenShow", id: bumenInstance.id)
    }
    def bumenShow(Long id) {
        def bumenInstance = Bumen.get(id)
        if (!bumenInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bumen.label', default: 'Bumen'), id])
            redirect(action: "bumenList")
            return
        }

        [bumenInstance: bumenInstance]
    }
    def bumenEdit(Long id) {
        def bumenInstance = Bumen.get(id)
        if (!bumenInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bumen.label', default: 'Bumen'), id])
            redirect(action: "bumenList")
            return
        }

        [bumenInstance: bumenInstance]
    }
    def bumenUpdate(Long id, Long version) {
        def bumenInstance = Bumen.get(id)
        if (!bumenInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bumen.label', default: 'Bumen'), id])
            redirect(action: "bumenList")
            return
        }

        if (version != null) {
            if (bumenInstance.version > version) {
                bumenInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'bumen.label', default: 'Bumen')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "bumenEdit", model: [bumenInstance: bumenInstance])
                return
            }
        }

        bumenInstance.properties = params

        if (!bumenInstance.save(flush: true)) {
            render(view: "bumenEdit", model: [bumenInstance: bumenInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'bumen.label', default: 'Bumen'), bumenInstance.id])
        redirect(action: "bumenShow", id: bumenInstance.id)
    }
    def bumenDelete(Long id) {
        def bumenInstance = Bumen.get(id)
        if (!bumenInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bumen.label', default: 'Bumen'), id])
            redirect(action: "bumenList")
            return
        }

        try {
            bumenInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'bumen.label', default: 'Bumen'), id])
            redirect(action: "bumenList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'bumen.label', default: 'Bumen'), id])
            redirect(action: "bumenShow", id: id)
        }
    }


    def companyRoleList(Integer max){
        params.max = Math.min(max ?: 10, 100)
        [companyRoleInstanceList: CompanyRole.list(params), companyRoleInstanceTotal: CompanyRole.count()]
    }
    def companyRoleCreate(){
        [companyRoleInstance: new CompanyRole(params)]
    }
    def companyRoleSave(){
        def companyRoleInstance = new CompanyRole(params)
        if(!companyRoleInstance.save(flush: true)){
            render(view: "companyRoleCreate", model: [companyRoleInstance: companyRoleInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'companyRole.label', default: 'companyRole'), companyRoleInstance.id])
        redirect(action: "companyRoleShow", id: companyRoleInstance.id)
    }
    //和许助手
    def hxhelper(Integer max){
        params.max = Math.min(max ?: 10, 100)
        [bookInstanceList: Book.list(params), bookInstanceTotal: Book.count()]
    }
    def book(Integer max,Long id){
        params.max = Math.min(max ?: 2, 100)
        params<<[sort: "id",order: "asc"]
        def offset = 0;
        if (params.offset>0){
            offset =params.offset
        }
        params<<[offset:offset]
        def syll = Syllabus.findAllByBook(Book.get(id),[sort:"id", order:"asc"])
        def bookInstance = Book.get(id)
        def syllabus  = Syllabus.findByBook(Book.get(id))
        def chapter = Chapter.findBySyllabus(syllabus)
        def contentlist = Content.findAllByChapter(chapter,params)
        def contentsize= Content.countByChapter(chapter)
        def content=""
        def content1 =""

        if(contentlist.size()>0){
            content= contentlist.get(0).introduction
            if (contentlist.size()>1){
                content1=contentlist.get(1).introduction
            }
        }
        if(!bookInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), id])
            redirect(action: "hxhelper")
            return
        }

        [bookInstance: bookInstance,syllabusInstanceList: syll,content:content,content1:content1,contentsize:contentsize,bookId:id,offset: offset,syllabusname:syllabus.syllabusName,chaptername:chapter.chapterName]
    }
    def chapterBook(Integer max,Long id){
        params.max = Math.min(max ?: 2, 100)
        params<<[sort: "id",order: "asc"]
        def offset = 0;
        if (params.offset>0){
            offset =params.offset
        }
        params<<[offset:offset]
        def chapter = Chapter.get(id)
        def syllabus=chapter.syllabus
        def bookId=chapter.syllabus.book.id
        def syllabusInstanceList = Syllabus.findAllByBook(Book.get(bookId),[sort:"id", order:"asc"])
        def bookInstance = Book.get(bookId)
        def contentlist = Content.findAllByChapter(chapter,params)
        def contentsize= Content.countByChapter(chapter)
        def content=""
        def content1 =""

        if(contentlist.size()>0){
            content= contentlist.get(0).introduction
            if (contentlist.size()>1){
                content1=contentlist.get(1).introduction
            }
        }
        [bookInstance: bookInstance,content:content,content1:content1,contentsize:contentsize,syllabusInstanceList:syllabusInstanceList,bookId: chapter.id,offset: offset,syllabusname:syllabus.syllabusName,chaptername:chapter.chapterName]
    }
    //系统设置

    //功能介绍
    def funIntroduction(Long id){
        def funIntroduction = FunIntroduction.get(id)
        if (!funIntroduction) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "list")
            return
        }
        [funIntroduction: funIntroduction]
    }
    //系统通知
    def inform(Long id){
        def informInstance = Inform.get(id)
        if (!informInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "list")
            return
        }
        [informInstance: informInstance]
    }
    //检查版本
    def banben(Long id){
        def banbenInstance = Banben.get(id)
        if (!banbenInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "list")
            return
        }
        [banbenInstance: banbenInstance]
    }
    //使用条款
    def clause(Long id){
        def clauseInstance = Banben.get(id)
        if (!clauseInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "list")
            return
        }
        [clauseInstance: clauseInstance]
    }
    //帮助与反馈
    def feedback(String id){
       def a=id
      if (a){
          [msg:"已提交"]
      }else {
         [msg:""]
      }
    }
    def feedbackSave(){

        def feedbackInstance = new Feedback(params)
        feedbackInstance.userId=session.user.id
        feedbackInstance.username=session.user.username
        if (!feedbackInstance.save(flush: true)) {
            render(view: "create", model: [feedbackInstance: feedbackInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'feedback.label', default: 'Feedback'), feedbackInstance.id])
        redirect(action: "feedback", id: feedbackInstance.id,msg:"已提交")
    }
    //个人设置
    def personalSet(){
        def userInstance = CompanyUser.get(session.user.id)
        def bumen = Bumen.findByCidAndId(session.company.id,session.user.bid)
        def role = Role.findById(session.user.pid)
        if(!userInstance){
            redirect(action: "login")
        }
        [userInstance: userInstance,bumen: bumen,role: role]
    }
    def personalUpdate(Long id, Long version){
        def companyUserInstance = CompanyUser.get(id)
        def filePath
        def fileName
        MultipartFile f = request.getFile('file1')
        if(!f.empty) {
            fileName=f.getOriginalFilename()
            filePath="web-app/images/"
            f.transferTo(new File(filePath+fileName))
        }

        if(fileName){
        companyUserInstance.img=fileName
        }
        if (!companyUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'companyUser.label', default: 'CompanyUser'), id])
            redirect(action: "personalSet")
            return
        }

        if (version != null) {
            if (companyUserInstance.version > version) {
                companyUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'companyUser.label', default: 'CompanyUser')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "personalSet", model: [companyUserInstance: companyUserInstance])
                return
            }
        }

        companyUserInstance.properties = params

        if (!companyUserInstance.save(flush: true)) {
            render(view: "personalSet", model: [companyUserInstance: companyUserInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'companyUser.label', default: 'CompanyUser'), companyUserInstance.id])
        redirect(action: "personalSet", id: companyUserInstance.id)
    }
    //修改密码
    def checkPassword(){
        def rs =[:]
        def user = CompanyUser.get(session.user.id)
        def password = params.oldpassword
        if (user.password==password){
            rs.msg=true
        }else {
            rs.msg=false
        }


        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    def passwordUpdate(){
        def rs =[:]
        def password = params.oldpassword
        def userInstance = CompanyUser.get(session.user.id)
        def newpassword = params.newpassword
        def version = params.version.toLong()

//        if (!userInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bumen.label', default: 'Bumen'), id])
//            redirect(action: "personalSet")
//            return
//        }

        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("user", "default.optimistic.locking.failure",
                        [message(code: 'user.label', default: 'user')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "personalSet", model: [userInstance: userInstance])
                return
            }
        }

        if (userInstance.password==password&&(!newpassword.empty)){
            userInstance.password = newpassword
            if (userInstance.save(flush: true)) {
                rs.msg=true
            }
        }else {
            rs.msg=false
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //周报
    //我的报告
    def myReport(){
        Calendar c = Calendar.getInstance()
        def year = c.get(Calendar.YEAR)
        def month =c.get(Calendar.MONTH)
        def week = c.get(Calendar.WEEK_OF_MONTH)
        def month1=["一","二","三","四","五","六","七","八","九","十","十一","十二"]
        def week1=[1,2,3,4]
        def userId= session.user.id
        def companyId= session.company.id


//        def myReportInfo =Zhoubao.findByUidAndCidAndYearAndMonthAndWeek(userId,companyId,year,month,week)
        def myReportInfo =Zhoubao.findByUidAndCidAndYearAndMonthAndWeek(userId,companyId,year.toString(),month.toString(),week.toString())
        [myReportInfo: myReportInfo,year: year,month: month,week: week,month1:month1,week1:week1]
    }
    def reportShow(){
        Calendar c = Calendar.getInstance()
        def year = c.get(Calendar.YEAR)
        def month =c.get(Calendar.MONTH)
        def week = c.get(Calendar.WEEK_OF_MONTH)
        def month1=["一","二","三","四","五","六","七","八","九","十","十一","十二"]
        def week1=[1,2,3,4]
        def n_year=params.year.toInteger()
        def n_month=params.month.toInteger()
        def n_week=params.week.toInteger()
        if(n_year==year&&n_month==month&&n_week==week){
            redirect(action: "myReport")
            return
        }

        def myReportInfo =Zhoubao.findByUidAndCidAndYearAndMonthAndWeek(session.user.id.toLong(),session.company.id.toLong(),n_year,n_month,n_week)
        [myReportInfo: myReportInfo,year: n_year,month: n_month,week: n_week,month1:month1,week1:week1]
    }

    def reportUpdate(Long id, Long cid, Long version){
        def myReportInfo = Zhoubao.findByIdAndCid(id,cid)
        def filePath
        def fileName
        MultipartFile f = request.getFile('file1')
        if(!f.empty) {
            fileName=f.getOriginalFilename()
            filePath="web-app/uploadfile/"
            f.transferTo(new File(filePath+fileName))
        }

        if(fileName){
            myReportInfo.uploadFile=fileName
        }
        if (!myReportInfo) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'zhoubao.label', default: 'Zhoubao'), id])
            redirect(action: "myReport")
            return
        }

        if (version != null) {
            if (myReportInfo.version > version) {
                myReportInfo.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'zhoubao.label', default: 'Zhoubao')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "myReport", model: [myReportInfo: myReportInfo])
                return
            }
        }
        myReportInfo.submit = 1
        myReportInfo.properties = params

        if (!myReportInfo.save(flush: true)) {
            render(view: "myReport", model: [myReportInfo: myReportInfo])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'zhoubao.label', default: 'Zhoubao'), myReportInfo.id])
        redirect(action: "myReport", id: myReportInfo.id)
    }
    //周报ajax保存
    def reportSave(Long id, Long version){
        def myReportInfo
        def rs =[:]

        if (!id) {
            myReportInfo = new Zhoubao(params)
            myReportInfo.dateCreate = new Date()
            myReportInfo.submit = 0
        }else {
            myReportInfo = Zhoubao.get(id)
        }

        if (version != null) {
            if (myReportInfo.version > version) {
                myReportInfo.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'zhoubao.label', default: 'Zhoubao')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "myReport", model: [myReportInfo: myReportInfo])
                return
            }
        }

        myReportInfo.properties = params
        if (myReportInfo.save(flush: true)) {
            rs.msg = true
        }else{
            rs.msg = false
        }


        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //周报ajax预览
    def ylReport(){
        def reportInfo = Zhoubao.get(params.id)
        def rs = [:]

        rs<<[reportInfo:reportInfo]
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //下属报告
    def xsReport(){
        def upid = session.user.pid
        def ubid = session.user.bid
        def ucid = session.user.cid
        def bumenInfo
        if(upid==1){
            bumenInfo = Bumen.findAllByCid(ucid)
            render(view: "reportBumenList", model: [bumenInfo: bumenInfo])
        }else if(upid==2){
            redirect(action: "reportUserList",params: [bid: ubid,cid: ucid])
            return
        }
    }
    def reportUserList(){
        def companyUserInstance = CompanyUser.findAllByBidAndCid(params.bid,params.cid)
        [companyUserInstance: companyUserInstance]
    }
    def xsReportShow(){
        Calendar c = Calendar.getInstance()
        def year = c.get(Calendar.YEAR)
        def month =c.get(Calendar.MONTH)
        def week = c.get(Calendar.WEEK_OF_MONTH)
        def month1=["一","二","三","四","五","六","七","八","九","十","十一","十二"]
        def week1=[1,2,3,4]
        def n_year
        def n_month
        def n_week
        if(!params.year||!params.month||!params.week){      //判断时间周数是否为空，空则为第一次访问，显示本周周报
            n_year=year
            n_month=month
            n_week=week
        }else{
            n_year=params.year.toInteger()
            n_month=params.month.toInteger()
            n_week=params.week.toInteger()
        }

        def myReportInfo =Zhoubao.findByUidAndCidAndYearAndMonthAndWeekAndSubmit(params.uid,params.cid,n_year,n_month,n_week,1)
        [myReportInfo: myReportInfo,uid: params.uid,cid: params.cid,year: n_year,month: n_month,week: n_week,month1:month1,week1:week1]
    }
    //周报回复保存
    def replySave(Long id){
        def replyInstance = new ReplyReport(params)
        def zhoubao = Zhoubao.get(id)
        zhoubao.reply = 1
         replyInstance.zhoubao=  zhoubao

        def date = new Date()
        replyInstance.date = date
        replyInstance.status = 0
        if(!replyInstance.save(flush: true)){
            render(view: "xsReportShow")
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'companyRole.label', default: 'companyRole'), replyInstance.id])
        redirect(action: "xsReportShow",params: [uid: params.uid,cid: params.cid,year: params.year,month: params.month,week: params.week])
    }
    //回复我的
    def replyReport(Long id){
        def uid = session.user.id
        def cid = session.company.id
        def zhoubao
        def i
        def replyInstance = ReplyReport.findAllByBpuidAndCidAndStatus(uid,cid,0,[sort: "date",order: "desc"])
        def count = replyInstance?.size()
        if(!id&&count!=0){
            zhoubao = replyInstance[0].zhoubao
        }else if(!id&&count==0) {

        }else{
            zhoubao = Zhoubao.get(id)
        }
        def allReplyInfo = ReplyReport.findAllByZhoubaoAndCid(zhoubao,cid,[sort: "date",order: "desc"])
        def myReplyInfo = ReplyReport.findAllByZhoubaoAndCidAndBpuid(zhoubao,cid,uid,[sort: "date",order: "desc"])
        for(i=0;i<myReplyInfo.size();i++){
            myReplyInfo[i].status=1
        }

        [replyInstance: replyInstance,allReplyInfo: allReplyInfo,count: count]
    }

    //回复我的
    def allReplyReport(Long id){
        def uid = session.user.id
        def cid = session.company.id
        Calendar c = Calendar.getInstance()
        def year = c.get(Calendar.YEAR)
        def month =c.get(Calendar.MONTH)
        def week = c.get(Calendar.WEEK_OF_MONTH)
        def n_year
        def n_month
        def n_week
        if(!params.year||!params.month||!params.week){      //判断时间周数是否为空，空则为第一次访问，显示本周周报
            n_year=year
            n_month=month
            n_week=week
        }else{
            n_year=params.year.toInteger()
            n_month=params.month.toInteger()
            n_week=params.week.toInteger()
        }
        def zhoubaoInstance = Zhoubao.findAllByUidAndCidAndReply(uid,cid,1,[sort:"dateCreate",order: "desc"])
        def zhoubaoReportInfo=Zhoubao.findByUidAndCidAndYearAndMonthAndWeekAndSubmit(uid,cid,n_year,n_month,n_week,1)
        [zhoubaoInstance: zhoubaoInstance,zhoubaoReportInfo: zhoubaoReportInfo]
    }

    def myReplySave(Long id){
        def replyInstance = new ReplyReport(params)
        def zhoubao = Zhoubao.get(id)
        zhoubao.reply = 1
        replyInstance.zhoubao=  zhoubao

        def date = new Date()
        replyInstance.date = date
        replyInstance.status = 0
        if(!replyInstance.save(flush: true)){
            render(view: "replyReport")
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'companyRole.label', default: 'companyRole'), replyInstance.id])
        redirect(action: "replyReport",id: id)
    }
    //任务

    def taskCreate(){
        def current = new Date()
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd")
        def now = time.format(current)
        def tomorrow = time.format(new Date(current.getTime()+1*24*60*60*1000))
        def bumenInstance = Bumen.findAllByCid(session.company.id)
        def order = [sort:"dateCreate",order: "desc"]
        def todayTaskInstance = Task.findAllByCidAndPlayuidAndStatusAndBigentimeLessThanEqualsAndOvertimeGreaterThanEquals(session.company.id,session.user.id,0,now,now,order)
        def todayFinishedTaskInstance = Task.findAllByCidAndPlayuidAndStatusAndBigentimeLessThanEqualsAndOvertimeGreaterThanEquals(session.company.id,session.user.id,1,now,now,order)
        def tomorrowTaskInstance = Task.findAllByCidAndPlayuidAndStatusAndBigentimeLessThanEqualsAndOvertimeGreaterThanEquals(session.company.id,session.user.id,0,tomorrow,tomorrow,order)
        def taskInstance = Task.findAllByCidAndPlayuidAndStatusAndOvertimeGreaterThanEquals(session.company.id,session.user.id,0,now,[sort:"overtime",order:"asc"])
        [taskInstance: taskInstance,todayTaskInstance: todayTaskInstance,todayFinishedTaskInstance: todayFinishedTaskInstance,tomorrowTaskInstance: tomorrowTaskInstance,bumenInstance: bumenInstance]
    }


    def taskSave(){
        def taskInstance = new Task(params)
        def overdate = params.overtime.split(" ")
        taskInstance.cid = session.company.id
        taskInstance.fzuid = session.user.id
        taskInstance.fzname = session.user.name
        taskInstance.overtime = overdate[0]
        taskInstance.overhour = overdate[1]
        taskInstance.status = 0
        taskInstance.dateCreate = new Date()

        if (!taskInstance.save(flush: true)) {
            render(view: "create", model: [taskInstance: taskInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'task.label', default: 'Task'), taskInstance.id])

        redirect(action: "taskCreate", id: taskInstance.id)
    }

    def taskUpdate(Long id, Long version){
        def taskInstance = Task.findByIdAndCid(id,session.company.id)
        taskInstance.status = 1
        if (!taskInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "taskCreate")
            return
        }

        if (version != null) {
            if (taskInstance.version > version) {
                taskInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'task.label', default: 'task')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "taskCreate", model: [taskInstance: taskInstance])
                return
            }
        }

        taskInstance.properties = params
        taskInstance.status = 1

        if (!taskInstance.save(flush: true)) {
            render(view: "taskCreate", model: [companyUserInstance: taskInstance])
            return
        }
        flash.message = message(code: 'default.updated.message', args: [message(code: 'task.label', default: 'Task'), taskInstance.id])
        redirect(action: "taskCreate", id: taskInstance.id)
    }

    def taskDelete(Long id){
        def taskInstnstance = Task.findByIdAndCid(id,session.company.id)
        if (!taskInstnstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "taskCreate")
            return
        }

        try {
            taskInstnstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "taskCreate")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "taskCreate", id: id)
        }
    }
    def finishedTaskDelete(Long id){
        def taskInstnstance = Task.findByIdAndCid(id,session.company.id)
        if (!taskInstnstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "finishedTask")
            return
        }

        try {
            taskInstnstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "finishedTask")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "finishedTask", id: id)
        }
    }

    def allTaskDelete(Long id){
        def taskInstnstance = Task.findByIdAndCid(id,session.company.id)
        if (!taskInstnstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "allTask")
            return
        }

        try {
            taskInstnstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "allTask")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "allTask", id: id)
        }
    }
    //任务详情ajax
    def taskShow(){
        def taskInfo = Task.findByIdAndCid(params.id,session.company.id)
        def rs = [:]
        if(taskInfo){
            rs.msg = true
        }else{
            rs.msg = false
        }
        rs<<[taskInfo:taskInfo]
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

//    负责任务
    def fzTask(){
        def order = [sort:"dateCreate",order: "desc"]
        def fzFinishedTaskInstance = Task.findAllByCidAndFzuidAndStatus(session.company.id,session.user.id,1,order)
        def fzUnFinishedTaskInstance = Task.findAllByCidAndFzuidAndStatus(session.company.id,session.user.id,0,order)
        def fzAllTaskInstance = Task.findAllByCidAndFzuid(session.company.id,session.user.id,order)
        [fzAllTaskInstance: fzAllTaskInstance,fzUnFinishedTaskInstance: fzUnFinishedTaskInstance,fzFinishedTaskInstance: fzFinishedTaskInstance]
    }
    //参与任务
    def cyTask(){
        def order = [sort:"dateCreate",order: "desc"]
        def cyFinishedTaskInstance = Task.findAllByCidAndFzuidAndStatus(session.company.id,session.user.id,1,order)
        def cyUnFinishedTaskInstance = Task.findAllByCidAndFzuidAndStatus(session.company.id,session.user.id,0,order)
        def cyAllTaskInstance = Task.findAllByCidAndFzuid(session.company.id,session.user.id,order)
        [cyAllTaskInstance: cyAllTaskInstance,cyUnFinishedTaskInstance: cyUnFinishedTaskInstance,cyFinishedTaskInstance: cyFinishedTaskInstance]
    }
    def finishedTask(){
        def finishedTaskInstance = Task.findAllByCidAndPlayuidAndStatus(session.company.id,session.user.id,1)
        [finishedTaskInstance: finishedTaskInstance]
    }
    def allTask(){
        def allTaskInstance = Task.findAllByCidAndPlayuid(session.company.id,session.user.id,1)
        [allTaskInstance: allTaskInstance]
    }

}
