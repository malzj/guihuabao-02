package com.guihuabao

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.web.multipart.MultipartFile


import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.logging.Logger
class FrontController {
    static allowedMethods = [save: "POST", update: "POST", delete: "POST",missionSave: "POST"]

    private  Logger logger
    def yanzheng(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
    }


    def index() {
        def msg =""
       msg= params.msg
        [msg:msg]
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
                redirect(action: "frontIndex")
            }else {
                flash.message ="您的公司账号已过期"
                redirect(action: "index",msg:"您的公司账号已过期")
                return
            }
        }

    }

    def logout(){
        session.user = ""
        session.company = ""
        redirect(action: "index")
    }

    def frontIndex(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def uid = session.user.id
        def cid = session.company.id
        def current = new Date()
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd")
        def now = time.format(current)
        def order = [sort:"dateCreate",order: "desc"]
        def targetInstance = Target.findAllByCidAndFzuidAndStatus(cid,uid,0,[max: 3,sort:"dateCreate",order: "desc"])
        def todayTaskInstance = Task.findAllByCidAndPlayuidAndStatusAndBigentimeLessThanEqualsAndOvertimeGreaterThanEquals(cid,uid,0,now,now,order)//今天任务
        def taskInstance = Task.findAllByCidAndPlayuidAndStatusAndOvertimeGreaterThanEquals(cid,uid,0,now,[sort:"overtime",order:"asc"])//即将到期
        def applyInstance = Apply.findAllByApplyuidAndCidAndApplystatuss(uid,cid,1,[max: 3,sort:"dateCreate",order: "desc"])
        def zhoubaoInstance = Zhoubao.findAllByCidAndUid(cid,uid,order)
        //公司公告
        def companyNoticeInstance = CompanyNotice.findAllByCid(cid,order)
        [targetInstance: targetInstance,todayTaskInstance: todayTaskInstance,taskInstance: taskInstance,zhoubaoInstance: zhoubaoInstance,applyInstance: applyInstance,companyNoticeInstance: companyNoticeInstance]
    }
    def companyUserCreate() {
        yanzheng()
        def bumenList = Bumen.findAllByCid(session.company.id)
        [companyUserInstance: new CompanyUser(params), bumenList: bumenList]
    }
    def companyUserSave(){
        yanzheng()
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
        yanzheng()
        params.max = Math.min(max ?: 10, 100)
        [companyUserInstanceList: CompanyUser.list(params), companyUserInstanceTotal: CompanyUser.count()]
    }
    def companyUserShow(Long id) {
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def companyUserInstance = CompanyUser.get(id)
        if (!companyUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'companyUser.label', default: 'CompanyUser'), id])
            redirect(action: "companyUserList")
            return
        }

        [companyUserInstance: companyUserInstance]
    }
    def companyUserEdit(Long id) {
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        [bumenInstanceList:Bumen.list(params), bumenInstanceTotal: Bumen.count()]
    }
    def bumenCreate(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        [bumenInstance: new Bumen(params)]
    }
    def bumenSave(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def bumenInstance = new Bumen(params)
        if (!bumenInstance.save(flush: true)) {
            render(view: "bumenCreate", model: [bumenInstance: bumenInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'bumen.label', default: 'companyUser'), bumenInstance.id])
        redirect(action: "bumenShow", id: bumenInstance.id)
    }
    def bumenShow(Long id) {
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def bumenInstance = Bumen.get(id)
        if (!bumenInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bumen.label', default: 'Bumen'), id])
            redirect(action: "bumenList")
            return
        }

        [bumenInstance: bumenInstance]
    }
    def bumenEdit(Long id) {
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def bumenInstance = Bumen.get(id)
        if (!bumenInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bumen.label', default: 'Bumen'), id])
            redirect(action: "bumenList")
            return
        }

        [bumenInstance: bumenInstance]
    }
    def bumenUpdate(Long id, Long version) {
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        [companyRoleInstanceList: CompanyRole.list(params), companyRoleInstanceTotal: CompanyRole.count()]
    }
    def companyRoleCreate(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        [companyRoleInstance: new CompanyRole(params)]
    }
    def companyRoleSave(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        [bookInstanceList: Book.list(params), bookInstanceTotal: Book.count()]
    }
    def book(Integer max,Long id){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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

        [bookInstance: bookInstance,syllabusInstanceList: syll,content:content,content1:content1,contentsize:contentsize,bookId:id,offset: offset,syllabus:syllabus,chapter:chapter]
    }
    def chapterBook(Integer max,Long id){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        [bookInstance: bookInstance,content:content,content1:content1,contentsize:contentsize,syllabusInstanceList:syllabusInstanceList,bookId: chapter.id,offset: offset,syllabus:syllabus,chapter:chapter]
    }
    //系统设置

    //功能介绍
    def funIntroduction(Long id){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def userInstance = CompanyUser.get(session.user.id)
        def bumen = Bumen.findByCidAndId(session.company.id,session.user.bid)
        def role = Role.findById(session.user.pid)
        if(!userInstance){
            redirect(action: "login")
        }
        [userInstance: userInstance,bumen: bumen,role: role]
    }
    def personalUpdate(Long id, Long version){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def companyUserInstance = CompanyUser.get(id)
        def filePath
        def fileName
        MultipartFile f = request.getFile('file1')
        if(!f.empty) {
            def date= new Date().getTime()
            Random random =new Random()
            def x = random.nextInt(100)
            def str =f.originalFilename
            String [] strs = str.split("[.]")


            fileName=date.toString()+x.toString()+"."+strs[1]
            def webRootDir = servletContext.getRealPath("/")
            println webRootDir
            def userDir = new File(webRootDir, "/images/")
            userDir.mkdirs()
            f.transferTo( new File( userDir, fileName))
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        DateFormat dateFormat = new SimpleDateFormat("yyyy");
        DateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");
        def dateyear = dateFormat.format(new Date())
        def date = dayFormat.format(new Date())
        def dateInfo = xuanran(dateyear)
        def month_week = weekJudge(date)
        def year = month_week.year
        def month = month_week.month
        def week = month_week.nowweek
        def month1=["一","二","三","四","五","六","七","八","九","十","十一","十二"]
        def userId= session.user.id
        def companyId= session.company.id


//        def myReportInfo =Zhoubao.findByUidAndCidAndYearAndMonthAndWeek(userId,companyId,year,month,week)
        def myReportInfo =Zhoubao.findByUidAndCidAndYearAndMonthAndWeek(userId,companyId,year.toString(),month.toString(),week.toString())
        [myReportInfo: myReportInfo,year: year,month: month,week: week,month1:month1,dateInfo: dateInfo]
    }
    def reportShow(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        DateFormat dateFormat = new SimpleDateFormat("yyyy");
        DateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");
        def year = dateFormat.format(new Date())
        def date = dayFormat.format(new Date())
        def dateInfo = xuanran(year)
        def month_week = weekJudge(date)
        def month1=["一","二","三","四","五","六","七","八","九","十","十一","十二"]
        def n_year=params.year.toInteger()
        def n_month=params.month.toInteger()
        def n_week=params.week.toInteger()
        def uid = session.user.id.toLong()
        def cid = session.company.id.toLong()
        if(n_year==month_week.year&&n_month==month_week.month&&n_week==month_week.nowweek){
            redirect(action: "myReport")
            return
        }

        def myReportInfo =Zhoubao.findByUidAndCidAndYearAndMonthAndWeek(uid,cid,n_year,n_month,n_week)
        [myReportInfo: myReportInfo,year: n_year,month: n_month,week: n_week,month1:month1,dateInfo:dateInfo]
    }

    //每月周数(年月同时)传入形式（yyyy-MM）
    def weekOfMonth(String date){
        def dateInfo = []
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
        DateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");
//        def date = dateFormat.format(new Date())
        def time = date
        Date date1 = dateFormat.parse(date);
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date1);
        int days = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
//        System.out.println("days:" + days);
        int count = 0;
        for (int i = 1; i <= days; i++) {
            Date date2 = dayFormat.parse(date + "-" + i);
            calendar.clear();
            calendar.setTime(date2);
            def weekbegin
            def weekend
            int k = new Integer(calendar.get(Calendar.DAY_OF_WEEK));
            if (k == 1) {// 若当天是周日

//                System.out.println("-----------------------------------");
                if (i - 6 == 1) {
                    weekbegin =dayFormat.format(dayFormat.parse(date + "-" + 1))
//                    System.out.println("本周开始日期:" + weekbegin);
                    count++;
                } else if(i - 6 > 1) {
                    weekbegin = dayFormat.format(dayFormat.parse(date + "-" + (i - 6)))
//                    System.out.println("本周开始日期:" + weekbegin);
                    count++;
                }
                if(count!=0){
                    weekend = dayFormat.format(dayFormat.parse(date + "-" + i))
//                    System.out.println("本周结束日期:" + weekend);
//                    System.out.println("第" + count + "周");
//                    System.out.println("-----------------------------------");
                    dateInfo<<[count: count,weekbegin: weekbegin,weekend: weekend]
                }
            }
            if (k != 1 && i == days) {// 若是本月后一天，且不是周日
                count++;
//                System.out.println("-----------------------------------");
                def day = dayFormat.parse(date + "-" + (i - k + 2))
                calendar.clear();
                calendar.setTime(day);
                calendar.add(Calendar.DATE,6)//开始日期加6天
                weekbegin = dayFormat.format(dayFormat.parse(date + "-" + (i - k + 2)))
                weekend = dayFormat.format(calendar.getTime())
//                System.out.println("本周开始日期:" + weekbegin);
//                System.out.println("本周结束日期:" + weekend);
//                System.out.println("第" + count + "周");
//                System.out.println("-----------------------------------");
                dateInfo<<[count: count,weekbegin: weekbegin,weekend: weekend]
            }
        }
        return dateInfo
    }
    //传入日期（yyyy-MM-dd）判断是哪一年第几月第几月第几周[year: year,month: month,nowweek: nowweek]
    def weekJudge(String time){
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
        DateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");

        def date3 = time
        Calendar calendar = new GregorianCalendar();
        Date date1 = dayFormat.parse(date3);
        def date = dateFormat.format(date1)
        def sdate = dayFormat.format(date1);
        calendar.setTime(date1);
        int n = new Integer(calendar.get(Calendar.DAY_OF_MONTH));
        int a = new Integer(calendar.get(Calendar.MONTH));
        def month_week = [:]
        def nowweek
        def judeDay
        if(n<7){
            for(def i=1;i<7;i++){
                def date2 = dayFormat.parse(date+"-"+i)
                calendar.clear();
                calendar.setTime(date2);
                int k = new Integer(calendar.get(Calendar.DAY_OF_WEEK));
                def f=k-1
                if(k-1==i){//判断如果一号为星期一跳出循环
                    month_week.year=new Integer(calendar.get(Calendar.YEAR))
                    month_week.month=new Integer(calendar.get(Calendar.MONTH))+1
                    judeDay = dateFormat.format(calendar.getTime())
                    break
                }
                if(k==1){
                    if(n<=i){
                        calendar.add(Calendar.MONTH,-1)
                        month_week.year=new Integer(calendar.get(Calendar.YEAR))
                        month_week.month=new Integer(calendar.get(Calendar.MONTH))+1
                    }else{
                        month_week.year=new Integer(calendar.get(Calendar.YEAR))
                        month_week.month=new Integer(calendar.get(Calendar.MONTH))+1
                    }
                    judeDay = dateFormat.format(calendar.getTime())
                }
            }
        }else{
            month_week.year=new Integer(calendar.get(Calendar.YEAR))
            month_week.month=new Integer(calendar.get(Calendar.MONTH))+1
            judeDay = dateFormat.format(calendar.getTime())
        }

        def allweeks = xuanran(month_week.year.toString())
        def weekInfo = weekOfMonth(judeDay)
        for(def j=0;j<weekInfo.size();j++){
            if(sdate>=weekInfo[j].weekbegin&&sdate<=weekInfo[j].weekend){
                nowweek=weekInfo[j].count
            }
        }
        def j=0
        def omonth = month_week.month-1
        for(j;j<=allweeks[omonth].size();j++){
            if(j+1==nowweek){
                month_week.nowweek = allweeks[omonth][j]
            }
        }
        return month_week
    }

    //周报渲染日期函数（传入年份）返回形式[[week,n],[week,n].....]
    def xuanran(String year){
        DateFormat dateFormat = new SimpleDateFormat("yyyy");
        def date
        def i
        def week=1
        def dateInfo
        def datearr = []
        if(!year){
            date = dateFormat.format(new Date())
        }else{
            date=year
        }
        for(i=1;i<=12;i++){
            dateInfo = weekOfMonth(date+"-"+i)
            def weekInfo = []
            for(def n=0;n<dateInfo.size();n++){
                weekInfo<<week++    //[week++,n+1]
            }
            datearr<<weekInfo
        }

        return datearr
    }

    def reportUpdate(Long id, Long cid, Long version){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        DateFormat dateFormat = new SimpleDateFormat("yyyy");
        DateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");
        def dateyear = dateFormat.format(new Date())
        def date = dayFormat.format(new Date())
        def dateInfo = xuanran(dateyear)
        def month_week = weekJudge(date)
        def year = month_week.year
        def month = month_week.month
        def week = month_week.nowweek
        def uid = params.uid
        def cid = params.cid
        def month1=["一","二","三","四","五","六","七","八","九","十","十一","十二"]
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

        def myReportInfo =Zhoubao.findByUidAndCidAndYearAndMonthAndWeekAndSubmit(uid,cid,n_year,n_month,n_week,1)
        [myReportInfo: myReportInfo,uid: uid,cid: cid,year: n_year,month: n_month,week: n_week,month1:month1,dateInfo: dateInfo]
    }
    //周报回复保存
    def replySave(Long id){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def uid = session.user.id
        def cid = session.company.id
        DateFormat dateFormat = new SimpleDateFormat("yyyy");
        DateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");
        def date = dayFormat.format(new Date())
        def month_week = weekJudge(date)
        def year = month_week.year
        def month = month_week.month
        def week = month_week.nowweek
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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

    //申请
    //申请列表
    def apply(Integer max){
//        yanzheng()
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        params<<[sort: "dateCreate",order: "desc"]
        def userId= session.user.id
        def companyId = session.company.id
        def selected = params.selected
        def applylist
        def applyInstanceTotal
        def companyuserList= CompanyUser.findAllByCidAndPidLessThan(companyId,3)
        if(selected == "1"){//已通过
            applylist= Apply.findAllByApplyuidAndCidAndApplystatussAndApplystatus(userId,companyId,1,1,params)
            applyInstanceTotal= Apply.countByApplyuidAndCidAndApplystatus(userId,companyId,1)
        }else if(selected == "2"){//未通过
            applylist= Apply.findAllByApplyuidAndCidAndApplystatussAndApplystatus(userId,companyId,1,2,params)
            applyInstanceTotal= Apply.countByApplyuidAndCidAndApplystatus(userId,companyId,2)
        }else if(selected == "0"){//未审核
            applylist= Apply.findAllByApplyuidAndCidAndApplystatussAndApplystatus(userId,companyId,1,0,params)
            applyInstanceTotal= Apply.countByApplyuidAndCidAndApplystatus(userId,companyId,0)
        }else{//全部
            applylist= Apply.findAllByApplyuidAndCidAndApplystatuss(userId,companyId,1,params)
            applyInstanceTotal= Apply.countByApplyuidAndCid(userId,companyId)
        }

        [applylist:applylist,applyInstanceTotal:applyInstanceTotal,companyuserList:companyuserList]
    }

    //申请保存
    def applySave(){

        def applyInstance  = new Apply(params)
        applyInstance.applyuid= session.user.id
        applyInstance.applyusername = session.user.name
        applyInstance.cid= session.company.id
        applyInstance.approvalusername=CompanyUser.get(params.approvaluid).name
        applyInstance.status="未审核"
        Date currentTime = new Date();
//        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//        String dateString = formatter.format(currentTime);
        applyInstance.dateCreate=currentTime
        applyInstance.applystatus=0
        applyInstance.applystatuss=1
        applyInstance.remindstatus = 0
        if (!applyInstance.save(flush: true)) {
            return
        }

        def rs=[:]
        rs<<[msg:true]
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    //申请ajax保存
    def applySave1(){

        yanzheng()
        def applyInstance  = new Apply(params)
        applyInstance.applyuid= session.user.id
        applyInstance.applyusername = session.user.name
        applyInstance.cid= session.company.id
        applyInstance.approvalusername=CompanyUser.get(params.approvaluid).name
        applyInstance.status="未审核"
        Date currentTime = new Date();
//        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//        String dateString = formatter.format(currentTime);
        applyInstance.dateCreate=currentTime
        applyInstance.applystatus=0
        applyInstance.applystatuss=0
        applyInstance.remindstatus = 0
        if (!applyInstance.save(flush: true)) {
            return
        }
        def rs=[:]
        rs<<[msg:true]
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //申请更新（草稿0、提交1）
    def applyUpdate(Long id, Long version){
        def rs=[:]
        def applyInstance  = Apply.get(id)
        def a = params.applysub
        if(applyInstance){//判断信息是否为空
            rs.msg=true
            if(params.applysub=="1"){//判断是存草稿还是提交
                applyInstance.applystatuss=1
            }else{
                applyInstance.applystatuss=0
            }
            if(params.applyremind=="1"){
                applyInstance.remindstatus=0
            }
            applyInstance.properties = params
            if(version != null){
                if (applyInstance.version > version) {
                    rs.msg=false
                }else{
                    if (!applyInstance.save(flush: true)) {
                        rs.msg=false
                    }
                }
            }
        }else{
            rs.msg=false
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    //申请提醒状态更新
    def applyRemindUpdate(Long id, Long version){
        def rs=[:]
        def applyInstance  = Apply.get(id)
        if(applyInstance){//判断信息是否为空
            rs.msg = true
            if(params.applyremind=="1"){
                applyInstance.remindstatus=0
            }
            applyInstance.properties = params
            if(version != null){
                if (applyInstance.version > version) {
                    rs.msg=false
                }else{
                    if (!applyInstance.save(flush: true)) {
                        rs.msg=false
                    }
                }
            }
        }else{
            rs.msg=false
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    //草稿箱
    def user_draft(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        def userId= session.user.id
        def companyId = session.company.id
        params<<[sort: "dateCreate",order: "desc"]
        def companyuserList= CompanyUser.findAllByCidAndPidLessThan(companyId,3)
        def applylist= Apply.findAllByApplyuidAndCidAndApplystatuss(userId,companyId,0,params)
        def applyInstanceTotal= Apply.countByApplyuidAndCidAndApplystatuss(userId,companyId,0)
        [applylist:applylist,applyInstanceTotal:applyInstanceTotal,companyuserList:companyuserList]

    }
    //草稿删除
    def applyDelete(Long id){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def applyInstance = Apply.get(id)
        if (!applyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'apply.label', default: 'Apply'), id])
            redirect(action: "user_draft")
            return
        }

        try {
            applyInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'apply.label', default: 'Apply'), id])
            redirect(action: "user_draft")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'apply.label', default: 'Apply'), id])
            redirect(action: "user_draft", id: id)
        }
    }
    //我的审核
    def user_approve(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?:10, 100)
        def userId= session.user.id
        def companyId = session.company.id
        def selected = params.selected
        def applylist
        def applyInstanceTotal
        params<<[sort: "dateCreate",order: "desc"]

        if(selected == "1"){//已通过
            applylist= Apply.findAllByApprovaluidAndCidAndApplystatussAndApplystatus(userId,companyId,1,1,params)
            applyInstanceTotal= Apply.countByApprovaluidAndCidAndApplystatus(userId,companyId,1)
        }else if(selected == "2"){//未通过
            applylist= Apply.findAllByApprovaluidAndCidAndApplystatussAndApplystatus(userId,companyId,1,2,params)
            applyInstanceTotal= Apply.countByApprovaluidAndCidAndApplystatus(userId,companyId,2)
        }else if(selected == "0"){//未审核
            applylist= Apply.findAllByApprovaluidAndCidAndApplystatussAndApplystatus(userId,companyId,1,0,params)
            applyInstanceTotal= Apply.countByApprovaluidAndCidAndApplystatus(userId,companyId,0)
        }else{//全部
            applylist= Apply.findAllByApprovaluidAndCidAndApplystatuss(userId,companyId,1,params)
            applyInstanceTotal= Apply.countByApprovaluidAndCid(userId,companyId)
        }
        [applylist:applylist,applyInstanceTotal:applyInstanceTotal]
    }
    //审核状态修改ajax
    def approveStatus(){
        def rs = [:]
        def id = params.id
        def companyId = session.company.id
        def version = params.version.toInteger()
        def applystatus = params.applystatus
        def applyInstance = Apply.findByIdAndCid(id,companyId)
        if(!applyInstance){
            rs.msg=false
        }else{
            rs.msg=true
            if(applystatus=="1"){
                applyInstance.applystatus = 1
                applyInstance.status = "已通过"
                applyInstance.remindstatus = 1
            } else if(applystatus=="2"){
                applyInstance.applystatus = 2
                applyInstance.status = "未通过"
                applyInstance.remindstatus = 1
            }
            applyInstance.properties = params
        }

        if (version != null) {
            if (applyInstance.version > version) {
                rs.msg=false
            }else{
                if(!applyInstance.save(flush: true)){
                    rs.msg=false
                }else{
                    rs.msg=true
                }
            }
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    //任务
    def taskCreate(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def pid= session.user.pid
        def current = new Date()
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd")
        def now = time.format(current)
        def tomorrow = time.format(new Date(current.getTime()+1*24*60*60*1000))
        def bumenInstance = Bumen.findAllByCid(session.company.id)
        def order = [sort:"dateCreate",order: "desc"]
        def todayTaskInstance = Task.findAllByCidAndPlayuidAndLookstatusAndStatusAndBigentimeLessThanEqualsAndOvertimeGreaterThanEquals(session.company.id,session.user.id,2,0,now,now,order)
        def todayFinishedTaskInstance = Task.findAllByCidAndPlayuidAndLookstatusAndStatusAndBigentimeLessThanEqualsAndOvertimeGreaterThanEquals(session.company.id,session.user.id,2,1,now,now,order)
        def tomorrowTaskInstance = Task.findAllByCidAndPlayuidAndLookstatusAndStatusAndBigentimeLessThanEqualsAndOvertimeGreaterThanEquals(session.company.id,session.user.id,2,0,tomorrow,tomorrow,order)
        def taskInstance = Task.findAllByCidAndPlayuidAndLookstatusAndStatusAndOvertimeGreaterThanEquals(session.company.id,session.user.id,2,0,now,[sort:"overtime",order:"asc"])
        [taskInstance: taskInstance,todayTaskInstance: todayTaskInstance,todayFinishedTaskInstance: todayFinishedTaskInstance,tomorrowTaskInstance: tomorrowTaskInstance,bumenInstance: bumenInstance]
    }

    def taskSave(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def taskInstance = new Task(params)
        def overdate = params.overtime.split(" ")
        def uid = session.user.id
        taskInstance.cid = session.company.id
        taskInstance.fzuid = uid
        taskInstance.fzname = session.user.name
        taskInstance.overtime = overdate[0]
        taskInstance.overhour = overdate[1]
        taskInstance.status = 0
        if(params.playuid==uid.toString()){
            taskInstance.lookstatus = 2
        }else{
            taskInstance.lookstatus = 0
        }
        taskInstance.remindstatus = 0

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
        def rs = [:]
        if (!taskInstance) {
            rs.msg=false
        }else{
            if (version != null) {
                if (taskInstance.version > version) {
                    rs.msg = false
                }else{
                    rs.msg = true
                    taskInstance.properties = params
                    taskInstance.status = 1
                    taskInstance.remindstatus = 1

                    if (!taskInstance.save(flush: true)) {
                        rs.msg = false
                    }
                }
            }
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    def taskDelete(Long id){
        def taskInstnstance = Task.findByIdAndCid(id,session.company.id)
        def rs = [:]
        if (!taskInstnstance) {
            rs.msg = false
        }else {
            try {
                taskInstnstance.delete(flush: true)
                rs.msg = true
            }
            catch (DataIntegrityViolationException e) {
                rs.msg = false
            }

        }


        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    //任务详情ajax
    def taskShow(){
        def taskInfo = Task.findByIdAndCid(params.id,session.company.id)
        def uid = session.user.id
        def rs = [:]
        def version = params.version
        if(version){
            version = version.toLong()
        }
        if(taskInfo){
            rs.msg = true

            if(taskInfo.lookstatus.toInteger()!=2){

                if(params.accept=='1'){//更改接受状态
                    taskInfo.lookstatus = 2
                }else if(uid==taskInfo.playuid.toLong()){
                    taskInfo.lookstatus = 1
                }

                if (version != null) {
                    if (taskInfo.version > version) {
                        rs.msg = false
                    }else{
                        if (taskInfo.save(flush: true)) {
                            rs.msg=true
                        }
                    }
                }
            }

        }else{
            rs.msg = false
        }
        def replyTask = ReplyTask.findAllByTasksAndCid(taskInfo,session.company.id,[sort: "date",order: "desc"])

        rs<<[replyTask:replyTask]
        rs<<[taskInfo:taskInfo]

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    //任务评论反馈
    def tReplyTaskSave(Long id){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        def replyTaskInstance = new ReplyTask(params)
        def taskInstance = Task.get(id)
        taskInstance.reply = 1
        replyTaskInstance.tasks = taskInstance
        replyTaskInstance.date = time.format(new Date())
        replyTaskInstance.status = 0
        if (!replyTaskInstance.save(flush: true)) {
            render(view: "unreadTaskReply", model: [id: params.id])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'task.label', default: 'Task'), taskInstance.id])
        redirect(action: "unreadTaskReply", id: params.id)
    }

    //任务评论反馈ajax
    def replyTaskSave(){
        def rs = [:]
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        def now = new Date()
        def replyTaskInstance = new ReplyTask(params)
        def taskInstance = Task.get(params.id)
        taskInstance.reply = 1
        replyTaskInstance.tasks = taskInstance
        replyTaskInstance.date = time.format(now)
        replyTaskInstance.cid = session.company.id
        replyTaskInstance.status = 0
        if(!params.content){
            rs.msg = false
        }else {
            if (!replyTaskInstance.save(flush: true)) {
                rs.msg = false
            } else {
                rs.msg = true
            }
        }


        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

//    负责任务
    def fzTask(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        def current = new Date()
            SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd")
        def now = time.format(current)
        def cid = session.company.id
        def uid = session.user.id
        def selected = params.selected
        params<<[sort:"dateCreate",order: "desc"]
        def fzTaskInstance
        def fzTaskInstanceTotal
        def infos=[:]
        infos.yq = Task.countByCidAndFzuidAndStatusAndOvertimeLessThan(cid,uid,0,now)
        infos.finished = Task.countByCidAndFzuidAndStatus(cid,uid,1)
        infos.unfinished = Task.countByCidAndFzuidAndStatus(cid,uid,0)

        if(selected=="1"){//已完成
            fzTaskInstance = Task.findAllByCidAndFzuidAndStatus(cid,uid,1,params)
            fzTaskInstanceTotal = infos.finished
        }else if(selected=="2"){//未完成
            fzTaskInstance = Task.findAllByCidAndFzuidAndStatus(cid,uid,0,params)
            fzTaskInstanceTotal = infos.unfinished
        }else if(selected=="3"){//延期任务
            fzTaskInstance = Task.findAllByCidAndFzuidAndStatusAndOvertimeLessThan(cid,uid,0,now,params)
            fzTaskInstanceTotal = infos.yq
        }else{//全部负责任务
            fzTaskInstance = Task.findAllByCidAndFzuid(cid,uid,params)
            fzTaskInstanceTotal = Task.countByCidAndFzuid(cid,uid)
        }
        [fzTaskInstance: fzTaskInstance,fzTaskInstanceTotal: fzTaskInstanceTotal,selected: selected,infos: infos]
    }
    //参与任务
    def cyTask(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        def current = new Date()
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd")
        def now = time.format(current)
        def cid = session.company.id
        def uid = session.user.id
        def selected = params.selected
        params<<[sort:"dateCreate",order: "desc"]
        def cyTaskInstance
        def cyTaskInstanceTotal
        def infos=[:]
        infos.yq = Task.countByCidAndPlayuidAndLookstatusAndStatusAndOvertimeLessThan(cid,uid,2,0,now)
        infos.finished = Task.countByCidAndPlayuidAndLookstatusAndStatus(cid,uid,2,1)
        infos.unfinished = Task.countByCidAndPlayuidAndLookstatusAndStatus(cid,uid,2,0)
        if(selected=="1"){//已完成
            cyTaskInstance = Task.findAllByCidAndPlayuidAndLookstatusAndStatus(cid,uid,2,1,params)
            cyTaskInstanceTotal = infos.finished
        }else if(selected=="2"){//未完成
            cyTaskInstance = Task.findAllByCidAndPlayuidAndLookstatusAndStatus(cid,uid,2,0,params)
            cyTaskInstanceTotal = infos.unfinished
        }else if(selected=="3"){//延期任务
            cyTaskInstance = Task.findAllByCidAndPlayuidAndLookstatusAndStatusAndOvertimeLessThan(cid,uid,2,0,now,params)
            cyTaskInstanceTotal = infos.yq
        }else{//全部参与任务
            cyTaskInstance = Task.findAllByCidAndPlayuidAndLookstatus(cid,uid,2,params)
            cyTaskInstanceTotal = Task.countByCidAndPlayuidAndLookstatus(cid,uid,2)
        }
        [cyTaskInstance: cyTaskInstance,cyTaskInstanceTotal: cyTaskInstanceTotal,selected: selected,infos: infos]
    }
    def finishedTask(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def finishedTaskInstance = Task.findAllByCidAndPlayuidAndStatus(session.company.id,session.user.id,1)
        [finishedTaskInstance: finishedTaskInstance]
    }

    def allTask(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        def current = new Date()
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd")
        def now = time.format(current)
        def cid = session.company.id
        def uid = session.user.id
        def selected = params.selected
        params<<[sort:"dateCreate",order: "desc"]
        def allTaskInstance
        def allTaskInstanceTotal
        def infos=[:]
        infos.uid = uid
        infos.cid = cid
        infos.yq = Task.countByCidAndPlayuidAndStatusAndOvertimeLessThan(cid,uid,0,now)
        infos.finished = Task.countByCidAndPlayuidAndStatus(cid,uid,1)
        infos.unfinished = Task.countByCidAndPlayuidAndStatus(cid,uid,0)
        if(selected=="1"){
            allTaskInstance = Task.findAllByCidAndPlayuidAndPlaystatus(cid,uid,1,params)
            allTaskInstanceTotal = Task.countByCidAndPlayuidAndPlaystatus(cid,uid,1)
        }else if(selected=="2"){
            allTaskInstance = Task.findAllByCidAndPlayuidAndPlaystatus(cid,uid,2,params)
            allTaskInstanceTotal = Task.countByCidAndPlayuidAndPlaystatus(cid,uid,2)
        }else if(selected=="3"){
            allTaskInstance = Task.findAllByCidAndPlayuidAndPlaystatus(cid,uid,3,params)
            allTaskInstanceTotal = Task.countByCidAndPlayuidAndPlaystatus(cid,uid,3)
        }else if(selected=="4"){
            allTaskInstance = Task.findAllByCidAndPlayuidAndPlaystatus(cid,uid,4,params)
            allTaskInstanceTotal = Task.countByCidAndPlayuidAndPlaystatus(cid,uid,4)
        }else{
            allTaskInstance = Task.findAllByCidAndPlayuid(cid,uid,params)
            allTaskInstanceTotal = Task.countByCidAndPlayuid(cid,uid)
        }
        [allTaskInstance: allTaskInstance,allTaskInstanceTotal: allTaskInstanceTotal,selected: selected,infos: infos]
    }

    //未读任务
    def unreadTask(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        def unreadTaskInstance
        def unreadTaskInstanceTotal
        def selected = params.selected
        if(selected=="1"){
            unreadTaskInstance = Task.findAllByCidAndPlayuidAndLookstatusAndStatus(session.company.id,session.user.id,0,1,params)//已完成
            unreadTaskInstanceTotal= Task.countByCidAndPlayuidAndLookstatusAndStatus(session.company.id,session.user.id,0,1)
        }else if(selected=="2"){
            unreadTaskInstance = Task.findAllByCidAndPlayuidAndLookstatusAndStatus(session.company.id,session.user.id,0,0,params)//未完成
            unreadTaskInstanceTotal= Task.countByCidAndPlayuidAndLookstatusAndStatus(session.company.id,session.user.id,0,0)
        }else{
            unreadTaskInstance = Task.findAllByCidAndPlayuidAndLookstatus(session.company.id,session.user.id,0,params)
            unreadTaskInstanceTotal= Task.countByCidAndPlayuidAndLookstatus(session.company.id,session.user.id,0)
        }
        [unreadTaskInstance: unreadTaskInstance,unreadTaskInstanceTotal:unreadTaskInstanceTotal,selected: selected]
    }

    //未接受任务
    def unacceptTask(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        def unacceptTaskInstance = Task.findAllByCidAndPlayuidAndLookstatus(session.company.id,session.user.id,1,params)
        def unacceptTaskInstanceTotal = Task.countByCidAndPlayuidAndLookstatus(session.company.id,session.user.id,1)

        [unacceptTaskInstance: unacceptTaskInstance,unacceptTaskInstanceTotal:unacceptTaskInstanceTotal]
    }

    //未读任务回复
    def unreadTaskReply(Long id) {
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def uid = session.user.id
        def cid = session.company.id
        def task
        def i
        def replyInstance = ReplyTask.findAllByBpuidAndCidAndStatus(uid, cid, 0, [sort: "date", order: "desc"])
        def count = replyInstance?.size()
        if (!id && count != 0) {
            task = replyInstance[0].tasks
        } else if (!id && count == 0) {

        } else {
            task = Task.get(id)
        }
        def allReplyInfo = ReplyTask.findAllByTasksAndCid(task, cid, [sort: "date", order: "desc"])
        def myReplyInfo = ReplyTask.findAllByTasksAndCidAndBpuid(task, cid, uid, [sort: "date", order: "desc"])
        for (i = 0; i < myReplyInfo.size(); i++) {
            myReplyInfo[i].status = 1
        }

        [replyInstance: replyInstance, allReplyInfo: allReplyInfo, count: count]
    }

    //下属任务
    def xsTask(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def upid = session.user.pid
        def ubid = session.user.bid
        def ucid = session.user.cid
        def bumenInfo
        if(upid==1){
            bumenInfo = Bumen.findAllByCid(ucid)
            render(view: "taskBumenList", model: [bumenInfo: bumenInfo])
        }else if(upid==2){
            redirect(action: "taskUserList",params: [bid: ubid,cid: ucid])
            return
        }
    }


    def taskUserList(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def companyUserInstance = CompanyUser.findAllByBidAndCid(params.bid,params.cid)
        [companyUserInstance: companyUserInstance]
    }

    //下属任务列表
    def xsTaskList(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        def current = new Date()
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd")
        def now = time.format(current)
        def cid = params.cid
        def uid = params.uid
        def selected = params.selected
        def order = [sort:"dateCreate",order: "desc"]
        def xsTaskInstance
        def xsTaskInstanceTotal
        def infos=[:]
        infos.uid = uid
        infos.cid = cid
        infos.yq = Task.countByCidAndPlayuidAndStatusAndOvertimeLessThan(cid,uid,0,now)
        infos.finished = Task.countByCidAndPlayuidAndStatus(cid,uid,1)
        infos.unfinished = Task.countByCidAndPlayuidAndStatus(cid,uid,0)
        if(selected=="1"){
            xsTaskInstance = Task.findAllByCidAndPlayuidAndStatus(cid,uid,1,params,order)
            xsTaskInstanceTotal = Task.countByCidAndPlayuidAndStatus(cid,uid,1,order)
        }else if(selected=="2"){
            xsTaskInstance = Task.findAllByCidAndPlayuidAndStatus(cid,uid,0,params,order)
            xsTaskInstanceTotal = Task.countByCidAndPlayuidAndStatus(cid,uid,0,order)
        }else{
            xsTaskInstance = Task.findAllByCidAndPlayuid(cid,uid,params,order)
            xsTaskInstanceTotal = Task.countByCidAndPlayuid(cid,uid,order)
        }
        [xsTaskInstance: xsTaskInstance,xsTaskInstanceTotal: xsTaskInstanceTotal,selected: selected,infos: infos]
    }

    //公司公告
    def companyNoticeList(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def cid = session.company.id
        params.max = Math.min(max ?: 10, 100)
        def companyNoticeInstanceList = CompanyNotice.findAllByCid(cid,params,[sort: "dateCreate",order: "desc"])
        def companyNoticeInstanceTotal = CompanyNotice.countByCid(cid)
        [companyNoticeInstanceList: companyNoticeInstanceList, companyNoticeInstanceTotal: companyNoticeInstanceTotal]
    }

    def companyNoticeCreate(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        [companyNoticeInstance: new CompanyNotice(params)]
    }

    def companyNoticeSave() {
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.cid = session.company.id
        params.dateCreate = new Date()
        def companyNoticeInstance = new CompanyNotice(params)
        if (!companyNoticeInstance.save(flush: true)) {
            render(view: "companyNoticeCreate", model: [companyNoticeInstance: companyNoticeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'companyNotice.label', default: 'CompanyNotice'), companyNoticeInstance.id])
        redirect(action: "companyNoticeShow", id: companyNoticeInstance.id)
    }

    def companyNoticeShow(Long id,Long version){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def cid = session.company.id
        def companyNoticeInstance = CompanyNotice.findByIdAndCid(id,cid)
        if (!companyNoticeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'companyNotice.label', default: 'CompanyNotice'), id])
            redirect(action: "companyNoticeList")
            return
        }

        [companyNoticeInstance: companyNoticeInstance]
    }

    def companyNoticeEdit(Long id){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def cid = session.company.id
        def companyNoticeInstance = CompanyNotice.findByIdAndCid(id,cid)
        if (!companyNoticeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'companyNotice.label', default: 'CompanyNotice'), id])
            redirect(action: "list")
            return
        }

        [companyNoticeInstance: companyNoticeInstance]
    }

    def companyNoticeUpdate(Long id, Long version) {
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def cid = session.company.id
        def companyNoticeInstance = CompanyNotice.findByIdAndCid(id,cid)
        if (!companyNoticeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'companyNotice.label', default: 'CompanyNotice'), id])
            redirect(action: "companyNoticeList")
            return
        }

        if (version != null) {
            if (companyNoticeInstance.version > version) {
                companyNoticeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'companyNotice.label', default: 'CompanyNotice')] as Object[],
                        "Another user has updated this CompanyNotice while you were editing")
                render(view: "companyNoticeEdit", model: [companyNoticeInstance: companyNoticeInstance])
                return
            }
        }

        companyNoticeInstance.properties = params

        if (!companyNoticeInstance.save(flush: true)) {
            render(view: "companyNoticeEdit", model: [companyNoticeInstance: companyNoticeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'companyNotice.label', default: 'CompanyNotice'), companyNoticeInstance.id])
        redirect(action: "companyNoticeShow", id: companyNoticeInstance.id)
    }

    def companyNoticeDelete(Long id) {
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def companyNoticeInstance = CompanyNotice.get(id)
        if (!companyNoticeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'companyNotice.label', default: 'CompanyNotice'), id])
            redirect(action: "companyNoticeList")
            return
        }

        try {
            companyNoticeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'companyNotice.label', default: 'CompanyNotice'), id])
            redirect(action: "companyNoticeList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'companyNotice.label', default: 'CompanyNotice'), id])
            redirect(action: "companyNoticeShow", id: id)
        }
    }
    //用户查看公告页面
    def companyNoticeIndex(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def cid = session.company.id
        params.max = Math.min(max ?: 10, 100)
        def companyNoticeInstanceList = CompanyNotice.findAllByCid(cid,params,[sort: "dateCreate",order: "desc"])
        def companyNoticeInstanceTotal = CompanyNotice.countByCid(cid)
        [companyNoticeInstanceList: companyNoticeInstanceList, companyNoticeInstanceTotal: companyNoticeInstanceTotal]
    }
    //公告ajaxshow
    def companyNoticeAjaxShow(){
        def companyNoticeInstance = CompanyNotice.findByIdAndCid(params.id,session.company.id)
        def rs = [:]
        if(companyNoticeInstance){
            rs.msg = true
         }else{
            rs.msg = false
        }



        rs<<[companyNoticeInstance:companyNoticeInstance]

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    def targetSave(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def targetInstance = new Target(params)
        targetInstance.cid = session.company.id
        targetInstance.img = '1.png'
        targetInstance.status = '0'
        targetInstance.percent = 0
        targetInstance.issubmit='0'

        targetInstance.dateCreate = new Date()


        if (!targetInstance.save(flush: true)) {
            render(model: [targetInstance: targetInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'target.label', default: 'Target'), targetInstance.id])
        redirect(action: "user_target", id: targetInstance.id)
    }
    //目标保存并分解
    def targetSaveAndSplit() {
        def rs = [:]
        def targetInstance = new Target(params)
        targetInstance.cid = session.company.id
        targetInstance.img = '1.png'
        targetInstance.status = '0'
        targetInstance.percent = 0
        targetInstance.dateCreate = new Date()


        if (!targetInstance.save(flush: true)) {
            render(model: [targetInstance: targetInstance])
            return
        } else {
            rs.target = targetInstance
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def targetDelete(Long id) {
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def targetInstance = Target.get(id)
        if (!targetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'target.label', default: 'Target'), id])
//            redirect(action: "targetEdit")
            return
        }

        try {
            targetInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'target.label', default: 'Target'), id])
            redirect(action: "user_target")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'target.label', default: 'Target'), id])
            redirect(action: "user_target", id: id)
        }
    }
    def user_target(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        def cid =session.user.cid
        def fzuid = session.user.id
        def selected = params.selected
//        def order1 = [sort:"begintime",order: "desc"]
//        def order2 = [sort:"dateCreate",order: "desc"]
        def bumenInstance = Bumen.findAllByCid(session.company.id)
        def targetInstance
        def targetInstanceTotal
        if(selected=="1"){
            params<<[sort:"etime",order: "desc"]
            targetInstance = Target.findAllByCidAndFzuidAndStatus(cid,fzuid,0,params)
            targetInstanceTotal = Target.countByCidAndFzuidAndStatus(cid,fzuid,0)
        }else if(selected=="2"){
            params<<[sort:"dateCreate",order: "desc"]
            targetInstance = Target.findAllByCidAndFzuidAndStatus(cid,fzuid,0,params)
            targetInstanceTotal = Target.countByCidAndFzuidAndStatus(cid,fzuid,0)
        }else{
            targetInstance = Target.findAllByCidAndFzuidAndStatus(cid,fzuid,0,params)
            targetInstanceTotal = Target.countByCidAndFzuidAndStatus(cid,fzuid,0)
        }
        [targetInstance: targetInstance,targetInstanceTotal: targetInstanceTotal,bumenInstance: bumenInstance,selected: selected]
    }
    def hasfinished_target(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        def cid =session.user.cid
        def fzuid = session.user.id
        def selected = params.selected
//        def order1 = [sort: "etime", order: "desc"]
//        def order2 = [sort: "dateCreate", order: "desc"]
        def targetInstance
        def targetInstanceTotal
        if(selected=="1"){
            params<<[sort:"etime",order: "desc"]
            targetInstance = Target.findAllByCidAndFzuidAndStatus(cid,fzuid,1,params)
            targetInstanceTotal = Target.countByCidAndFzuidAndStatus(cid,fzuid,1)
        }else if(selected=="2"){
            params<<[sort:"dateCreate",order: "desc"]
            targetInstance = Target.findAllByCidAndFzuidAndStatus(cid,fzuid,1,params)
            targetInstanceTotal = Target.countByCidAndFzuidAndStatus(cid,fzuid,1)
        }else{
            targetInstance = Target.findAllByCidAndFzuidAndStatus(cid,fzuid,1,params)
            targetInstanceTotal = Target.countByCidAndFzuidAndStatus(cid,fzuid,1)
        }
        [targetInstance: targetInstance,targetInstanceTotal: targetInstanceTotal,selected: selected]
    }
    def all_user_target(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        def cid =session.user.cid
        def fzuid = session.user.id
        def selected = params.selected

        def targetInstance
        def targetInstanceTotal
        if(selected=="1"){
            params<<[sort:"etime",order: "desc"]
            targetInstance = Target.findAllByCidAndFzuid(cid,fzuid,params)
            targetInstanceTotal = Target.countByCidAndFzuid(cid,fzuid)
        }else if(selected=="2"){
            params<<[sort:"dateCreate",order: "desc"]
            targetInstance = Target.findAllByCidAndFzuid(cid,fzuid,params)
            targetInstanceTotal = Target.countByCidAndFzuid(cid,fzuid)
        }else{
            targetInstance = Target.findAllByCidAndFzuid(cid,fzuid,params)
            targetInstanceTotal = Target.countByCidAndFzuid(cid,fzuid)
        }
        [targetInstance: targetInstance,targetInstanceTotal: targetInstanceTotal,selected: selected]
    }
    def missionSave() {
        def rs = [:]
        def mission = new Mission(params)
        mission.hasvisited='0'
        mission.issubmit='0'

        def targetInstance = Target.get(params.target_id)

        mission.target = targetInstance
        mission.save()
        def missionlist=targetInstance.mission
        def sum=0
        for(def m in missionlist){
           println(m.percent)
           sum+=m.percent.toInteger()
        }
        def r_per=100-sum
        if (!mission.save(flush: true)) {

            rs.msg = false
        } else {
            mission.dateCreate=new Date();

            mission.dateCreate = new Date()
            rs.msg=true
            rs.target=targetInstance
            rs.mission=mission
            rs.r_per=r_per
        }


        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON

    }
   def maccept(){
       def rs = [:]
       def mission=Mission.get(params.mid)
       if(!mission){
           rs.msg=false
       }else{
           mission.hasvisited='2'
       }
       if (params.callback) {
           render "${params.callback}(${rs as JSON})"
       } else
           render rs as JSON

   }
   def  issubmit(){
       def rs = [:]
       def target=Target.get(params.target_id)
       if(!target){
           rs.msg=false
       }else {
           target.issubmit = '1'
           def missionlist = target.mission
           for (def mission in missionlist) {
               mission.issubmit = '1'
           }
       }
       if (params.callback) {
           render "${params.callback}(${rs as JSON})"
       } else
           render rs as JSON
   }
    def tshow() {
        def rs = [:]
        def tid = params.target_id
        def targetInstance = Target.get(tid)
        def fzname=com.guihuabao.CompanyUser.findById(targetInstance.fzuid).name
        rs.target=targetInstance
        rs.mission=targetInstance.mission
        rs.fzname=fzname
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def mshow(){
        def rs=[:]
        def mid= params.mid
        def mission = Mission.get(mid)
        def target = mission.target
        def fzname=com.guihuabao.CompanyUser.findById(target.fzuid).name
        rs.mission = mission
        rs.target = target
        rs.fzname=fzname
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def mdelete(){
        def rs=[:]
        def mid=params.mid
        def missionInstance = Mission.get(mid)
        def targetInstance=missionInstance.target

        try {
            missionInstance.delete(flush: true)
            if(missionInstance.status==1) {
                targetInstance.percent-= missionInstance.percent
            }
            def missionlist=targetInstance.mission
            def sum=0
            for(def m in missionlist){
                println(m.percent)
                sum+=m.percent.toInteger()
            }
            def r_per=100-sum
            rs.msg="删除任务成功！"
            rs.target=targetInstance
            rs.mission=missionInstance
            rs.r_per=r_per
        }
        catch (DataIntegrityViolationException e) {
           rs.msg="删除失败！"
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    def mupdate() {
        def rs = [:]
        def mid = params.mid

        def mission = Mission.get(mid)
        def target = mission.target

        if(mission.status=='0') {
            mission.properties = params
            if(mission.status=='1'){
                target.percent+=mission.percent
            }
        }else{
            target.percent-=mission.percent
            mission.properties = params
            mission.save()
            if(mission.status=='1'){
                target.percent+=mission.percent
            }
        }

        def missionlist = target.mission
        def sum=0
        for(def m in missionlist){
            println(m.percent)
            sum+=m.percent.toInteger()
        }
        def r_per=100-sum
        if (target.percent == 100) {
            target.status = '1'
        }else{
            target.status = '0'
        }
        rs.msg = true
        rs.target = target
        rs.mission = missionlist
        rs.missionSize = mission.target.mission.size()
        rs.r_per=r_per
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    //消息未读任务
    def messageTask(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)

        def messageTaskInstance = Task.findAllByCidAndPlayuidAndLookstatusAndStatus(session.company.id,session.user.id,0,0,params)//未完成
        def messageTaskInstanceTotal= Task.countByCidAndPlayuidAndLookstatusAndStatus(session.company.id,session.user.id,0,0)
        [messageTaskInstance: messageTaskInstance,messageTaskInstanceTotal:messageTaskInstanceTotal]
    }
    //消息任务到期
    def messageTaskOver(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        def date = time.format(new Date())
        Calendar calendar = new GregorianCalendar();
        Date date1 = time.parse(date)
        calendar.setTime(date1);
        calendar.add(Calendar.HOUR,6)
        def etime = time.format(calendar.getTime())
        def timearr = etime.split(" ")
        def timearr1 = date.split(" ")
        def enddate = timearr[0]
        def endtime = timearr[1]
        def nowdate = timearr1[0]
        def nowtime = timearr1[1]

        def messageTaskInstance = Task.findByCidAndPlayuidAndOvertimeAndOverhourLessThanEqualsAndOvertimeGreaterThanEqualsAndOverhourGreaterThanEqualsAndLookstatusAndStatus(session.company.id,session.user.id,enddate,endtime,nowdate,nowtime,2,0)
        def messageTaskInstanceTotal = Task.countByCidAndPlayuidAndOvertimeAndOverhourLessThanEqualsAndOvertimeGreaterThanEqualsAndOverhourGreaterThanEqualsAndLookstatusAndStatus(session.company.id,session.user.id,enddate,endtime,nowdate,nowtime,2,0)
        [messageTaskInstance: messageTaskInstance,messageTaskInstanceTotal:messageTaskInstanceTotal]
    }

    //消息目标到期
    def messageTargetOver(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        def date = time.format(new Date())
        Calendar calendar = new GregorianCalendar();
        Date date1 = time.parse(date)
        calendar.setTime(date1);
        calendar.add(Calendar.HOUR,6)
        def etime = time.format(calendar.getTime())

        def messageTargetInstance = Target.findByCidAndFzuidAndEtimeAndEtimeGreaterThanEqualsAndStatus(session.company.id,session.user.id,etime,date,0)
        def messageTargetInstanceTotal = Target.countByCidAndFzuidAndEtimeAndEtimeGreaterThanEqualsAndStatus(session.company.id,session.user.id,etime,date,0)
        [messageTargetInstance: messageTargetInstance,messageTargetInstanceTotal:messageTargetInstanceTotal]
    }
    def messageTaskF(Integer max){
        params.max = Math.min(max ?: 10, 100)
        def messageTaskFInstance = Task.findAllByCidAndFzuidAndLookstatusAndStatusAndRemindstatus(session.company.id,session.user.id,2,1,1,params)//已完成
        def messageTaskFInstanceTotal = Task.countByCidAndFzuidAndLookstatusAndStatusAndRemindstatus(session.company.id,session.user.id,2,1,1)
        [messageTaskFInstance: messageTaskFInstance,messageTaskFInstanceTotal:messageTaskFInstanceTotal]
    }

    //下属完成任务消息ajax
    def messageTaskShow(){
        def taskInfo = Task.findByIdAndCid(params.id,session.company.id)
        def rs = [:]
        def version = params.version
        if(version){
            version = version.toLong()
        }
        if(taskInfo){
            rs.msg = true

            if(taskInfo.remindstatus.toInteger()!=2){

                taskInfo.remindstatus = 2
                if (version != null) {
                    if (taskInfo.version > version) {
                        rs.msg = false
                    }else{
                        if (taskInfo.save(flush: true)) {
                            rs.msg=true
                        }
                    }
                }
            }

        }else{
            rs.msg = false
        }



        rs<<[taskInfo:taskInfo]

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    //参与的任务
    def join_mission(Integer max) {
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
//        def cid=company.id
        def playname = session.user.name

        def selected = params.selected
//        def order1 = [sort: "overtime", order: "desc"]
//        def order2 = [sort: "dateCreate", order: "desc"]
        def missionInstance
        def missionInstanceTotal
        if (selected == "1") {
            params<<[sort:"overtime",order: "desc"]
            missionInstance = Mission.findAllByPlaynameAndStatus(playname,'0' , params)
            missionInstanceTotal = Mission.countByPlaynameAndStatus(playname, 0)
        } else if (selected == "2") {
            params<<[sort:"dateCreate",order: "desc"]
            missionInstance = Mission.findAllByPlaynameAndStatus(playname, 0, params)
            missionInstanceTotal = Mission.countByPlaynameAndStatus(playname, 0)
        } else {
            missionInstance = Mission.findAllByPlaynameAndStatus( playname, '0', params)
            missionInstanceTotal = Mission.countByPlaynameAndStatus( playname, 0)
      }
        [missionInstance:missionInstance,missionInstanceTotal:missionInstanceTotal, selected: selected]
    }
   def targetzjSave(){
       def rs = [:]
       def tid = params.target_id
       def targetInstance = Target.get(tid)
       targetInstance.targetzj=params.targetzj
       if (params.callback) {
           render "${params.callback}(${rs as JSON})"
       } else
           render rs as JSON
   }
    def mhasvisited() {
        def rs = [:]
        def mid = params.mid
        def mission = Mission.get(mid)
        if(!mission){
            rs.msg=false
        }else {
            def target = mission.target
            def replymission=mission.replymission
            mission.hasvisited='1'
            def fzname = com.guihuabao.CompanyUser.findById(target.fzuid).name

            for(def r in replymission){
                if(r.bpuname==fzname) {
                    r.status = 1
                }
            }
            rs.mission = mission
            rs.target = target
            rs.fzname = fzname
            rs.replymission=replymission

        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def mcomment(){
        def rs = [:]
        def mid = params.mid
        def mission = Mission.get(mid)
        if(!mission){
            rs.msg=false
        }else {
            def target = mission.target
            def replymission=mission.replymission
//            mission.hasvisited='1'
            def fzname = com.guihuabao.CompanyUser.findById(target.fzuid).name

            for(def r in replymission){
                if(r.bpuname==fzname) {
                    r.status = 1
                }
            }
            rs.mission = mission
            rs.target = target
            rs.fzname = fzname
            rs.replymission=replymission

        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //下属目标
    def xsTarget() {
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def upid = session.user.pid
        def ubid = session.user.bid
        def ucid = session.user.cid
        def bumenInfo
        if (upid == 1) {
            bumenInfo = Bumen.findAllByCid(ucid)
            render(view: "targetBumenList", model: [bumenInfo: bumenInfo])
        } else if (upid == 2) {
            redirect(action: "targetUserList", params: [bid: ubid, cid: ucid])
            return
        }
    }
    def xsTargetList(Integer max) {
        def user = User.findById(params.uid)
        def company = Company.findById(params.cid)
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        def cid = params.cid
        def fzuid = params.uid
        def selected = params.selected
        def order1 = [sort: "etime", order: "desc"]
        def order2 = [sort: "dateCreate", order: "desc"]
        def bumenInstance = Bumen.findAllByCid(session.company.id)
        def targetInstance
        def targetInstanceTotal
        if (selected == "1") {
            targetInstance = Target.findAllByCidAndFzuidAndStatus(cid, fzuid, 0, params, order1)
            targetInstanceTotal = Target.countByCidAndFzuidAndStatus(cid, fzuid, 0, order1)
        } else if (selected == "2") {
            targetInstance = Target.findAllByCidAndFzuidAndStatus(cid, fzuid, 0, params, order2)
            targetInstanceTotal = Target.countByCidAndFzuidAndStatus(cid, fzuid, 0, order2)
        } else {
            targetInstance = Target.findAllByCidAndFzuidAndStatus(cid, fzuid, 0, params)
            targetInstanceTotal = Target.countByCidAndFzuidAndStatus(cid, fzuid, 0)
        }
        [targetInstance: targetInstance, targetInstanceTotal: targetInstanceTotal, bumenInstance: bumenInstance, selected: selected]
    }

    def TargetUserList() {
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def companyUserInstance = CompanyUser.findAllByBidAndCid(params.bid, params.cid)
        [companyUserInstance: companyUserInstance]
    }
    //参与的已完成任务
    def join_hasfinished_mission(Integer max) {
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
//        def cid=company.id
        def playname = session.user.name

        def selected = params.selected
//        def order1 = [sort: "overtime", order: "desc"]
//        def order2 = [sort: "dateCreate", order: "desc"]
        def missionInstance
        def missionInstanceTotal
        if (selected == "1") {
            params<<[sort:"overtime",order: "desc"]
            missionInstance = Mission.findAllByPlaynameAndStatus(playname,'1' , params)
            missionInstanceTotal = Mission.countByPlaynameAndStatus(playname, '1')
        } else if (selected == "2") {
            params<<[sort:"dateCreate",order: "desc"]
            missionInstance = Mission.findAllByPlaynameAndStatus(playname, '1', params)
            missionInstanceTotal = Mission.countByPlaynameAndStatus(playname, '1')
        } else {
            missionInstance = Mission.findAllByPlaynameAndStatus( playname, '1', params)
            missionInstanceTotal = Mission.countByPlaynameAndStatus( playname, '1')
        }
        [missionInstance:missionInstance,missionInstanceTotal:missionInstanceTotal, selected: selected]
    }
    def mfinished(){
        def rs=[:]
        def mid=params.id
        def mission=Mission.get(mid)

        if(!mission){
            rs.msg=false
        }else{
            rs.msg=true
            def target=mission.target
            mission.status=1
            target.percent+=mission.percent
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def replyMissionSave(){
        def rs = [:]
        def replyMissionInstance = new ReplyMission(params)
        def missionInstance = Mission.get(params.mid)
        missionInstance.reply ='1'
        replyMissionInstance.mission = missionInstance
        replyMissionInstance.date = new Date()
        replyMissionInstance.cid = session.company.id
        replyMissionInstance.status =0
        if(!params.content){
            rs.msg = false
        }else {
            if (!replyMissionInstance.save(flush: true)) {
                rs.msg = false
            } else {
                rs.msg = true
                rs.replymission=replyMissionInstance
            }
        }


        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def unread_comment(Integer max){
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        def bpuname=user.name
        def replymission
        def replymissionTotal
        params<<[sort:"date",order: "desc"]
        replymission=ReplyMission.findAllByBpunameAndStatus(bpuname,0,params)
        for(def r in replymission){
            r.status=1
        }
        replymissionTotal=ReplyMission.countByBpunameAndStatus(bpuname,0)
        [replymissionlist:replymission,replymissionTotal:replymissionTotal]
    }
    def uploadImg(){
        def rs=[:]
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
//        def companyUserInstance = CompanyUser.get(id)
        def filePath
        def fileName
        def a = params
        MultipartFile f = request.getFile('file1')

        if(!f.empty) {
            def date= new Date().getTime()
            Random random =new Random()
            def x = random.nextInt(100)
            def str =f.originalFilename
            String [] strs = str.split("[.]")
            fileName=date.toString()+x.toString()+"."+strs[1]
            def webRootDir = servletContext.getRealPath("/")
            println webRootDir
            def userDir = new File(webRootDir, "img/target-img/")
            userDir.mkdirs()
            f.transferTo( new File( userDir, fileName))


            println(filePath)
            rs.fileName=fileName

        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON

        }
    def selectImg(){
        def rs = [:]
        def tid = params.target_id
        def targetInstance = Target.get(tid)
        targetInstance.img=params.img
        rs.target=targetInstance
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def showImg(){
        def rs = [:]
        def tid = params.target_id
        def targetInstance = Target.get(tid)
        rs.img=targetInstance.img
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
   def hxtools(){}
    def hxexample(){}
    def tool(){}
    def example(){}
}

