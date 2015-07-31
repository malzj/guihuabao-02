package com.guihuabao

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.web.multipart.MultipartFile

import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.logging.Logger

class FrontController {
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
    def frontIndex(){
        def uid = session.user.id
        def cid = session.company.id
        def current = new Date()
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd")
        def now = time.format(current)
        def order = [sort:"dateCreate",order: "desc"]
        def todayTaskInstance = Task.findAllByCidAndPlayuidAndStatusAndBigentimeLessThanEqualsAndOvertimeGreaterThanEquals(cid,uid,0,now,now,order)//今天任务
        def taskInstance = Task.findAllByCidAndPlayuidAndStatusAndOvertimeGreaterThanEquals(cid,uid,0,now,[sort:"overtime",order:"asc"])//即将到期
        def zhoubaoInstance = Zhoubao.findAllByCidAndUid(cid,uid,order)
        //公司公告
        def companyNoticeInstance = CompanyNotice.findAllByCid(cid,order)
        [todayTaskInstance: todayTaskInstance,taskInstance: taskInstance,zhoubaoInstance: zhoubaoInstance,companyNoticeInstance: companyNoticeInstance]
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
        yanzheng()
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
        c.setMinimalDaysInFirstWeek(7)
        def year = c.get(Calendar.YEAR)
        def month =c.get(Calendar.MONTH)
        def week = c.get(Calendar.DAY_OF_WEEK_IN_MONTH)
        def we = c.getActualMaximum(Calendar.DAY_OF_WEEK_IN_MONTH)
        Calendar q = Calendar.getInstance();
        q.set(Calendar.YEAR,year); // 2010年
        q.setMinimalDaysInFirstWeek(7)
        def ddd=0
        for(def s =0;s<12;s++){

            q.set(Calendar.MONTH, s); // 6 月
            c.set(Calendar.MONTH,s)
            c.set(Calendar.DATE,29)
            System.out.println("------------" + 2015 + "年" + (s + 1) + "月的天数和周数-------------");
            System.out.println("天数：" + q.getActualMaximum(Calendar.DAY_OF_MONTH));
            System.out.println("周数：" + c.get(Calendar.WEEK_OF_MONTH)+"第几周"+c.get(Calendar.DAY_OF_WEEK_IN_MONTH));
            def x = q.getActualMaximum(Calendar.WEEK_OF_MONTH)
            ddd=ddd+x
        }
        print(ddd+"-------------------")
        def i=0
        def n
        def mon
        def dateInfo = []

//        for(i;i<12;i++){
//            def weekInfo = []
//            c.set(Calendar.MONTH,i)
//            mon = c.getActualMaximum(Calendar.WEEK_OF_MONTH)
//            n=1
//            for(n;n<=mon;n++){
//                weekInfo<<n
//            }
//            dateInfo<<weekInfo
//        }

//        q.setFirstDayOfWeek(Calendar.MONDAY);
//      q.setMinimalDaysInFirstWeek(7);
//        for(def s =0;s<12;s++){
//
//            q.set(Calendar.MONTH, s); // 6 月
//            System.out.println("------------" + q.get(Calendar.YEAR,2015) + "年" + (s + 1) + "月的天数和周数-------------");
//            System.out.println("天数：" + q.getActualMaximum(Calendar.DAY_OF_MONTH));
//            System.out.println("周数：" + q.getActualMaximum(Calendar.WEEK_OF_MONTH));
//        }
//        def vv=[]
//        def size=0
//        Calendar q = Calendar.getInstance();
//            q.setFirstDayOfWeek(Calendar.MONDAY);
//        q.setMinimalDaysInFirstWeek(7);
//        q.set(Calendar.YEAR,c.get(Calendar.YEAR)); // 2010年
//        for(def s=0;s<12;s++){
//        def cc=[]
//
//
//            q.set(Calendar.MONTH,s); // 6 月
//            def ll = q.getActualMaximum(Calendar.WEEK_OF_MONTH)
//            System.out.println("周数：" + q.getActualMaximum(Calendar.WEEK_OF_MONTH));
//            size=size+ll
//
//            for (def d=0;d<ll;d++){
//
//                   cc<<d
//            }
//            vv<<cc
//        }
//        print(size+"----------------")
        def month1=["一","二","三","四","五","六","七","八","九","十","十一","十二"]
        def n_year=params.year.toInteger()
        def n_month=params.month.toInteger()
        def n_week=params.week.toInteger()
        if(n_year==year&&n_month==month&&n_week==week){
            redirect(action: "myReport")
            return
        }

        def myReportInfo =Zhoubao.findByUidAndCidAndYearAndMonthAndWeek(session.user.id.toLong(),session.company.id.toLong(),n_year,n_month,n_week)
        [myReportInfo: myReportInfo,year: n_year,month: n_month,week: n_week,month1:month1,dateInfo:dateInfo]
    }

    //判断时间是第几周(年月同时)
    def weekJudge(){
        Calendar c = Calendar.getInstance()
        def year = c.get(Calendar.YEAR)
        def date = new Date()
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
        Date date1 = dateFormat.parse(date);
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date1);
        int days = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        System.out.println("days:" + days);
        int count = 0;
        for (int i = 1; i <= days; i++) {
            DateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
            Date date2 = dateFormat1.parse(date + "-" + i);
            calendar.clear();
            calendar.setTime(date2);
            int k = new Integer(calendar.get(Calendar.DAY_OF_WEEK));
            if (k == 1) {// 若当天是周日
                count++;
                System.out.println("-----------------------------------");
                System.out.println("第" + count + "周");
                if (i - 6 <= 1) {
                    System.out.println("本周开始日期:" + date + "-" + 1);
                } else {
                    System.out.println("本周开始日期:" + date + "-" + (i - 6));
                }
                System.out.println("本周结束日期:" + date + "-" + i);
                System.out.println("-----------------------------------");
            }
            if (k != 1 && i == days) {// 若是本月最好一天，且不是周日
                count++;
                System.out.println("-----------------------------------");
                System.out.println("第" + count + "周");
                System.out.println("本周开始日期:" + date + "-" + (i - k + 2));
                System.out.println("本周结束日期:" + date + "-" + i);
                System.out.println("-----------------------------------");
            }
        }
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
        def pid= session.user.pid
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
        taskInstance.lookstatus = 0
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

    def apply(Integer max){
//        yanzheng()
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        def userId= session.user.id
        def companyId = session.company.id
        def companyuserList= CompanyUser.findAllByCidAndPidLessThan(companyId,3)

        def applylist= Apply.findAllByApplyuidAndCidAndApplystatuss(userId,companyId,1,params)
       def applyInstanceTotal= Apply.countByApplyuidAndCid(userId,companyId)
        [applylist:applylist,applyInstanceTotal:applyInstanceTotal,companyuserList:companyuserList]
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
    }

    def applySave(){



        def applyInstance  = new Apply(params)
        applyInstance.applyuid= session.user.id
        applyInstance.applyusername = session.user.name
        applyInstance.cid= session.company.id
        applyInstance.approvalusername=CompanyUser.get(params.approvaluid).name
        applyInstance.status="未审核"
        Date currentTime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String dateString = formatter.format(currentTime);
        applyInstance.dateCreate=dateString
        applyInstance.applystatus=0
        applyInstance.applystatuss=1
        if (!applyInstance.save(flush: true)) {
            return
        }

        def rs=[:]
        rs<<[msg:true]

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
        def version = params.version
        if(taskInfo){
            rs.msg = true
            if(taskInfo.lookstatus.toInteger()==0){
                taskInfo.lookstatus = 1
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

    def applySave1(){

        yanzheng()
        def applyInstance  = new Apply(params)
        applyInstance.applyuid= session.user.id
        applyInstance.applyusername = session.user.name
        applyInstance.cid= session.company.id
        applyInstance.approvalusername=CompanyUser.get(params.approvaluid).name
        applyInstance.status="未审核"
        Date currentTime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String dateString = formatter.format(currentTime);
        applyInstance.dateCreate=dateString
        applyInstance.applystatus=0
        applyInstance.applystatuss=0
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
//    负责任务
    def fzTask(Integer max){
        params.max = Math.min(max ?: 10, 100)
        def current = new Date()
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd")
        def now = time.format(current)
        def cid = session.company.id
        def uid = session.user.id
        def selected = params.selected
        def order = [sort:"dateCreate",order: "desc"]
        def fzTaskInstance
        def fzTaskInstanceTotal
        def infos=[:]
        infos.yq = Task.countByCidAndFzuidAndStatusAndOvertimeLessThan(cid,uid,0,now)
        infos.finished = Task.countByCidAndFzuidAndStatus(cid,uid,1)
        infos.unfinished = Task.countByCidAndFzuidAndStatus(cid,uid,0)

        if(selected=="1"){//已完成
            fzTaskInstance = Task.findAllByCidAndFzuidAndStatus(cid,uid,1,params,order)
            fzTaskInstanceTotal = infos.finished
        }else if(selected=="2"){//未完成
            fzTaskInstance = Task.findAllByCidAndFzuidAndStatus(cid,uid,0,params,order)
            fzTaskInstanceTotal = infos.unfinished
        }else if(selected=="3"){//延期任务
            fzTaskInstance = Task.findAllByCidAndFzuidAndStatusAndOvertimeLessThan(cid,uid,0,now,params,order)
            fzTaskInstanceTotal = infos.yq
        }else{//全部负责任务
            fzTaskInstance = Task.findAllByCidAndFzuid(cid,uid,params,order)
            fzTaskInstanceTotal = Task.countByCidAndFzuid(cid,uid)
        }
        [fzTaskInstance: fzTaskInstance,fzTaskInstanceTotal: fzTaskInstanceTotal,selected: selected,infos: infos]
    }
    //参与任务
    def cyTask(Integer max){
        params.max = Math.min(max ?: 10, 100)
        def current = new Date()
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd")
        def now = time.format(current)
        def cid = session.company.id
        def uid = session.user.id
        def selected = params.selected
        def order = [sort:"dateCreate",order: "desc"]
        def cyTaskInstance
        def cyTaskInstanceTotal
        def infos=[:]
        infos.yq = Task.countByCidAndPlayuidAndStatusAndOvertimeLessThan(cid,uid,0,now)
        infos.finished = Task.countByCidAndPlayuidAndStatus(cid,uid,1)
        infos.unfinished = Task.countByCidAndPlayuidAndStatus(cid,uid,0)
        if(selected=="1"){//已完成
            cyTaskInstance = Task.findAllByCidAndPlayuidAndStatus(cid,uid,1,params,order)
            cyTaskInstanceTotal = infos.finished
        }else if(selected=="2"){//未完成
            cyTaskInstance = Task.findAllByCidAndPlayuidAndStatus(cid,uid,0,params,order)
            cyTaskInstanceTotal = infos.unfinished
        }else if(selected=="3"){//延期任务
            cyTaskInstance = Task.findAllByCidAndPlayuidAndStatusAndOvertimeLessThan(cid,uid,0,now,params,order)
            cyTaskInstanceTotal = infos.yq
        }else{//全部负责任务
            cyTaskInstance = Task.findAllByCidAndPlayuid(cid,uid,params,order)
            cyTaskInstanceTotal = Task.countByCidAndPlayuid(cid,uid)
        }
        [cyTaskInstance: cyTaskInstance,cyTaskInstanceTotal: cyTaskInstanceTotal,selected: selected,infos: infos]
    }
    def finishedTask(){
        def finishedTaskInstance = Task.findAllByCidAndPlayuidAndStatus(session.company.id,session.user.id,1)
        [finishedTaskInstance: finishedTaskInstance]
    }
    def allTask(Integer max){
        params.max = Math.min(max ?: 10, 100)
        def current = new Date()
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd")
        def now = time.format(current)
        def cid = session.company.id
        def uid = session.user.id
        def selected = params.selected
        def order = [sort:"dateCreate",order: "desc"]
        def allTaskInstance
        def allTaskInstanceTotal
        def infos=[:]
        infos.uid = uid
        infos.cid = cid
        infos.yq = Task.countByCidAndPlayuidAndStatusAndOvertimeLessThan(cid,uid,0,now)
        infos.finished = Task.countByCidAndPlayuidAndStatus(cid,uid,1)
        infos.unfinished = Task.countByCidAndPlayuidAndStatus(cid,uid,0)
        if(selected=="1"){
            allTaskInstance = Task.findAllByCidAndPlayuidAndPlaystatus(cid,uid,1,params,order)
            allTaskInstanceTotal = Task.countByCidAndPlayuidAndPlaystatus(cid,uid,1,order)
        }else if(selected=="2"){
            allTaskInstance = Task.findAllByCidAndPlayuidAndPlaystatus(cid,uid,2,params,order)
            allTaskInstanceTotal = Task.countByCidAndPlayuidAndPlaystatus(cid,uid,2,order)
        }else if(selected=="3"){
            allTaskInstance = Task.findAllByCidAndPlayuidAndPlaystatus(cid,uid,3,params,order)
            allTaskInstanceTotal = Task.countByCidAndPlayuidAndPlaystatus(cid,uid,3,order)
        }else if(selected=="4"){
            allTaskInstance = Task.findAllByCidAndPlayuidAndPlaystatus(cid,uid,4,params,order)
            allTaskInstanceTotal = Task.countByCidAndPlayuidAndPlaystatus(cid,uid,4,order)
        }else{
            allTaskInstance = Task.findAllByCidAndPlayuid(cid,uid,params,order)
            allTaskInstanceTotal = Task.countByCidAndPlayuid(cid,uid,order)
        }
        [allTaskInstance: allTaskInstance,allTaskInstanceTotal: allTaskInstanceTotal,selected: selected,infos: infos]
    }

    //未读任务
    def unreadTask(Integer max){
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
    //下属任务
    def xsTask(){
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
        def companyUserInstance = CompanyUser.findAllByBidAndCid(params.bid,params.cid)
        [companyUserInstance: companyUserInstance]
    }
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
        def companyuserList= CompanyUser.findAllByCidAndPidLessThan(companyId,3)
        def applylist= Apply.findAllByApplyuidAndCidAndApplystatuss(userId,companyId,0,params)
        def applyInstanceTotal= Apply.countByApplyuidAndCid(userId,companyId)
        [applylist:applylist,applyInstanceTotal:applyInstanceTotal,companyuserList:companyuserList]

    }
    def user_approve(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
    }

    //下属任务列表
    def xsTaskList(Integer max){
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
<<<<<<< HEAD

=======
>>>>>>> 0b535667704c176b2f327badcc4296b32200eb06
    //公司公告
    def companyNoticeList(Integer max){
        def cid = session.company.id
        params.max = Math.min(max ?: 10, 100)
        def companyNoticeInstanceList = CompanyNotice.findAllByCid(cid,params,[sort: "dateCreate",order: "desc"])
        def companyNoticeInstanceTotal = CompanyNotice.countByCid(cid)
        [companyNoticeInstanceList: companyNoticeInstanceList, companyNoticeInstanceTotal: companyNoticeInstanceTotal]
    }

    def companyNoticeCreate(){
        [companyNoticeInstance: new CompanyNotice(params)]
    }

    def companyNoticeSave() {
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

    //目标
    def user_target(){
        def uid=session.user.id;
        def cid=session.user.cid;
        def targetInstance;

    }
    def targetCreate() {
        [targetInstance: new Target(params)]
    }
    def targetSave(){
        def targetInstance = new Target(params)
        targetInstance.cid = session.company.id
        targetInstance.fzuid = session.user.id
        targetInstance.status = 0
        targetInstance.percent=0
        targetInstance.ctime = new Date()


        if (!targetInstance.save(flush: true)) {
            render(view: "targetCreate", model: [targetInstance: targetInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'target.label', default: 'Target'), targetInstance.id])
        redirect(action: "targetShow", id: targetInstance.id)
    }
    def targetShow(Long id) {
        def targetInstance = Target.get(id)
        if (!targetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'target.label', default: 'Target'), id])
            redirect(action: "targetList")
            return
        }

        [targetInstance: targetInstance]
    }

    def targEtedit(Long id) {
        def targetInstance = Target.get(id)
        if (!targetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'target.label', default: 'Target'), id])
            redirect(action: "targetList")
            return
        }

        [targetInstance: targetInstance]
    }

    def targetupdate(Long id, Long version) {
        def targetInstance = Target.get(id)
        if (!targetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'target.label', default: 'Target'), id])
            redirect(action: "targetList")
            return
        }

        if (version != null) {
            if (targetInstance.version > version) {
                targetInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'target.label', default: 'Target')] as Object[],
                        "Another user has updated this Target while you were editing")
                render(view: "targetEdit", model: [targetInstance: targetInstance])
                return
            }
        }

        targetInstance.properties = params

        if (!targetInstance.save(flush: true)) {
            render(view: "targetEdit", model: [targetInstance: targetInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'target.label', default: 'Target'), targetInstance.id])
        redirect(action: "targetShow", id: targetInstance.id)
    }

    def targetdelete(Long id) {
        def targetInstance = Target.get(id)
        if (!targetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'target.label', default: 'Target'), id])
            redirect(action: "targetEdit")
            return
        }

        try {
            targetInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'target.label', default: 'Target'), id])
            redirect(action: "targetEdit")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'target.label', default: 'Target'), id])
            redirect(action: "targetEdit", id: id)
        }
    }
    def targetList(Integer max){
        params.max = Math.min(max ?: 10, 100)
        def cid =session.user.cid
        def fzuid = session.user.id
        def selected = params.selected
        def order = [sort:"dateCreate",order: "desc"]
        def targetInstance
        def targetInstanceTotal
        def infos=[:]
        infos.uid = uid
        infos.cid = cid
        infos.yq = Target.findByCidAndFzuidAndStatus(cid,fzuid,0)
        if(selected=="1"){
            targetInstance = Task.findAllByCidAndPlayuidAndStatus(cid,uid,1,params,order)
            targetInstanceTotal = Task.countByCidAndPlayuidAndStatus(cid,uid,1,order)
        }else if(selected=="2"){
            xsTaskInstance = Task.findAllByCidAndPlayuidAndStatus(cid,uid,0,params,order)
            xsTaskInstanceTotal = Task.countByCidAndPlayuidAndStatus(cid,uid,0,order)
        }
        [targetInstance: targetInstance,targetInstanceTotal: targetInstanceTotal,selected: selected,infos: infos]
    }
    def missionSave(Long id) {
        def missionInstance = new Mission(params)
        missionInstance.target = Target.get(id)
        missionInstance.bid =
                missionInstance.dateCreate = new Date()
        missionInstance.
                status(nullable: true)
        tid(nullable: true)
        title(nullable: true)
        content(nullable: true)
        playuid(nullable: true)
        cid(nullable: true)
        bid(nullable: true)
        begintime(nullable: true)
        overtime(nullable: true)
        overhour(nullable: true)
        dateCreate(nullable: true)
    }

    //目标列表
//    def user_target(){
//        params.max = Math.min(max ?: 10, 100)
//        def cid = session.company.id
//        def selected = params.selected
//        def targetInstanceList
//        def targetInstanceTotal
//        if(selected=="1"){
//            targetInstanceList = Target.findAllByCid(cid,params,[sort: "etime",order: "asc"])
//            targetInstanceTotal = Target.countByCid(cid)
//        }else if(selected=="2"){
//            targetInstanceList = Target.findAllByCid(cid,params,[sort: "dateCreate",order:'desc'])
//            targetInstanceTotal = Target.countByCid(cid)
//        }
//
//        [targetInstanceList: targetInstanceList, targetInstanceTotal: targetInstanceTotal]
//
//    }
}