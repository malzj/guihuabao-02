package com.guihuabao

import grails.converters.JSON

import java.text.DateFormat
import java.text.SimpleDateFormat

class GhbotherapiController {

    def index() {}
    //我的申请
    def apply(){

        def rs=[:]
        def userId= params.userId
        def companyId = params.cid
        def selected = params.selected

        params.max = 5
        params<<[sort: "dateCreate",order: "desc"]
        def offset = 0

        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def applylist
        def applyInstanceTotal
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
        def offse = params.offset.toInteger()
        if(applyInstanceTotal>offse){
            if(applylist){
                rs.result = true
                rs.applylist = applylist
            }else{
                rs.result = false
                rs.msg = "已加载所有数据"
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
    //申请新增
    def applysave(){
        def rs=[:]
        def applyInstance  = new Apply(params)
//        applyInstance.applyuid= params.applyuid
        applyInstance.applyusername = CompanyUser.get(params.applyuid).name
        applyInstance.cid= params.cid
        applyInstance.approvalusername=CompanyUser.get(params.approvaluid).name
        applyInstance.status="未审核"
        Date currentTime = new Date();
        applyInstance.dateCreate=currentTime
        applyInstance.applystatus=0
        if(params.applysub=="1"){//判断是存草稿0还是提交1
            applyInstance.applystatuss=1
        }else{
            applyInstance.applystatuss=0
        }
        applyInstance.remindstatus = 0
        if (!applyInstance.save(flush: true)) {
            rs.result = false
            rs.msg = "新建申请失败！"
        }else{
            rs.result = true
            rs.msg = "新建申请成功！"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    //草稿箱列表
    def user_draft(){
        def rs = [:]
        params.max = 5
        def userId= params.userId
        def companyId = params.cid
        params<<[sort: "dateCreate",order: "desc"]
        def offset = 0
        def offse = params.offset.toInteger()
        if (offse>0){
            offset = offse
        }
        params<<[offset: offset]

        def applyInstanceTotal= Apply.countByApplyuidAndCidAndApplystatuss(userId,companyId,0)
        if(applyInstanceTotal>offse){
            def applylist= Apply.findAllByApplyuidAndCidAndApplystatuss(userId,companyId,0,params)
            if(applylist){
                rs.result = true
                rs.applylist = applylist
            }else{
                rs.result = false
                rs.msg = "已加载所有数据！"
            }
        }else{
            rs.result = false
            rs.msg = "已加载所有数据！"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //申请详情
    def applyShow(){
        def rs = [:]
        def id = params.id
        def userId = params.userId
        def companyId = params.cid
        def applyInctance = Apply.findByIdAndApplyuidAndCid(id,userId,companyId)
        if(applyInctance){
            rs.result = true
            rs.applyInctance = applyInctance
        }else{
            rs.result =false
            rs.msg="未找到申请"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //我的审批列表
    def user_approve(){
        def rs=[:]
        def userId= params.userId
        def companyId = params.cid
        def selected = params.selected

        params.max = 5
        params<<[sort: "dateCreate",order: "desc"]
        def offset = 0

        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def applylist
        def applyInstanceTotal
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
        def offse = params.offset.toInteger()
        if(applyInstanceTotal>offse){
            if(applylist){
                rs.result = true
                rs.applylist = applylist
            }else{
                rs.result = false
                rs.msg = "已加载所有数据"
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
    //审批状态修改
    def approveStatus(){
        def rs = [:]
        def id = params.id
        def companyId = params.cid
        def version = params.version.toInteger()
        def applystatus = params.applystatus
        def applyInstance = Apply.findByIdAndCid(id,companyId)
        if(!applyInstance){
            rs.result=false
            rs.msg = "审核失败"
        }else{
            rs.result=true
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
                rs.result=false
                rs.msg = "审核失败"
            }else{
                if(!applyInstance.save(flush: true)){
                    rs.result=false
                    rs.msg = "审核失败"
                }else{
                    rs.result=true
                    rs.msg = "审核成功"
                    rs.applyInstance = applyInstance
                }
            }
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //申请编辑
    def applyUpdate(){
        def rs = [:]
        def id = params.id
        def version = params.version.toInteger()
        def applyInstance  = Apply.get(id)
        if(applyInstance){//判断信息是否为空
            rs.result=true
            rs.msg="修改成功"
            if(params.applysub=="1"){//判断是存草稿0还是提交1
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
                    rs.result=false
                    rs.msg="修改失败"
                }else{
                    rs.result=true
                    rs.msg="修改成功"
                    if (!applyInstance.save(flush: true)) {
                        rs.result=false
                        rs.msg="修改失败"
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
    //删除申请
    def applyDelete(){
        def id= params.id
        def applyInstance = Apply.get(id)
        def rs = [:]
        if (!applyInstance) {
            rs.result = false
            rs.msg="没有找到对应申请"
        }else {
            applyInstance.delete(flush: true)
            rs.result = true
            rs.msg="删除成功"


        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    //公司公告列表
    def companyNoticeList(){
        def rs = [:]
        def cid = params.cid
        params.max = 5
        params<<[sort: 'dateCreate',order: 'desc']
        def offset = 0
        def offse = params.offset.toInteger()
        if(offse>0){
            offset = offse
        }
        params<<[offset: offset]
        def companyNoticeInstanceTotal = CompanyNotice.countByCid(cid)
        if(companyNoticeInstanceTotal>offset){
            def companyNoticeInstanceList = CompanyNotice.findAllByCid(cid,params)
            if(companyNoticeInstanceList){
                rs.result = true
                rs.companyNoticeInstanceList = companyNoticeInstanceList
            }else{
                rs.result = false
                rs.msg = "已加载所有数据"
            }
        }else{
            rs.result = false
            rs.msg = "已加载所有数据"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //公告详情
    def companyNoticeShow(){
        def rs = [:]
        def id = params.id
        def cid = params.cid
        def companyNoticeInstance = CompanyNotice.findByIdAndCid(id,cid)
        if (!companyNoticeInstance) {
            rs.result = false
            rs.msg = "未找到该公告"
        }else{
            rs.result = true
            rs.companyNoticeInstance = companyNoticeInstance
        }

        if(params.callback){
            render "${params.callback}(${rs as JSON})"
        }else
            render rs as JSON
    }
    //报告
    //我的报告
    def myReport(){
        def rs = [:]
        def date
        def n_year
        def n_month
        def n_week
        DateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");
        if(params.predate&&params.preyear&&params.premonth&&params.preweek){
            date = params.predate
            n_year=params.preyear
            n_month=params.premonth
            n_week=params.preweek
        }else{
            date = dayFormat.format(new Date())
            def month_week = weekJudge(date)
            n_year=month_week.year
            n_month=month_week.month
            n_week=month_week.nowweek
        }
        def i
        def uid = params.userId
        def cid = params.cid

        def myReportInfo =Zhoubao.findByUidAndCidAndYearAndMonthAndWeek(uid,cid,n_year,n_month,n_week)
        def replyInstance = ReplyReport.findAllByZhoubaoAndCidAndBpuid(myReportInfo,cid,uid,[sort: "date",order: "desc"])
        def ureadReply = ReplyReport.findAllByZhoubaoAndCidAndBpuidAndStatus(myReportInfo,cid,uid,0)
        for(i=0;i<ureadReply.size();i++){
            ureadReply[i].status=1
        }
        Calendar calendar = new GregorianCalendar();
        def day = dayFormat.parse(date)
        calendar.clear();
        calendar.setTime(day);
        calendar.add(Calendar.DATE,-7)
        def date1 = dayFormat.format(calendar.getTime())
        def pre_week = weekJudge(date1)
        rs.predate = date1
        rs.preyear = pre_week.year
        rs.premonth = pre_week.month
        rs.preweek = pre_week.nowweek
        if(myReportInfo){
            rs.result = true
            rs.myReportInfo = myReportInfo
            rs.replyInstance = replyInstance
        }else{
            rs.result = false
            rs.msg = "未找到报告"
        }

        if(params.callback){
            render "${params.callback}(${rs as JSON})"
        }else
            render rs as JSON
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

                if (i - 6 == 1) {
                    weekbegin =dayFormat.format(dayFormat.parse(date + "-" + 1))
                    count++;
                } else if(i - 6 > 1) {
                    weekbegin = dayFormat.format(dayFormat.parse(date + "-" + (i - 6)))
                    count++;
                }
                if(count!=0){
                    weekend = dayFormat.format(dayFormat.parse(date + "-" + i))
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
    //报告保存
    def reportSave(){
        def myReportInfo
        def rs =[:]
        def version = params.version.toInteger()
        def id = params.id
        def date
        DateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");
        if(params.reportweek){//预留如果不是本周报告，但可修改的话用
            date = params.reportweek
        }else{
            date = dayFormat.format(new Date())
        }

        def month_week = weekJudge(date)

        if (!id) {
            myReportInfo = new Zhoubao(params)
            myReportInfo.year = month_week.year
            myReportInfo.month = month_week.month
            myReportInfo.week = month_week.nowweek
            myReportInfo.dateCreate = new Date()
            myReportInfo.submit = 0
        }else {
            myReportInfo = Zhoubao.get(id)
        }

        if (version != null) {
            if (myReportInfo.version > version) {
                rs.result = false
                rs.msg = "周报保存失败"
            }else{
                params.username = CompanyUser.findById(params.uid).name
                myReportInfo.properties = params
                if (myReportInfo.save(flush: true)) {
                    rs.result = true
                    rs.msg = "周报保存成功"
                }else{
                    rs.result = false
                    rs.msg = "周报保存失败"
                }
            }
        }else{
            params.username = CompanyUser.findById(params.uid).name
            myReportInfo.properties = params
            if (myReportInfo.save(flush: true)) {
                rs.result = true
                rs.msg = "周报保存成功"
            }else{
                rs.result = false
                rs.msg = "周报保存失败"
            }
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //报告提交
    def reportUpdate(){
        def rs = [:]
        def id = params.id
        def cid = params.cid
        def version = params.version.toInteger()
        def myReportInfo = Zhoubao.findByIdAndCid(id,cid)
        if(myReportInfo){
            if (version != null) {
                if (myReportInfo.version > version) {
                    rs.result = false
                    rs.msg = "提交失败"
                }else{
                    myReportInfo.submit = 1
                    myReportInfo.properties = params
                    if (myReportInfo.save(flush: true)) {
                        rs.result = true
                        rs.msg = "提交成功"
                    }else{
                        rs.result = false
                        rs.msg = "提交失败"
                    }
                }
            }
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //回复新增
    def reportReplySave(){
        def rs = [:]
        def id = params.id
        def replyInstance = new ReplyReport(params)
        def zhoubao = Zhoubao.get(id)
        zhoubao.reply = 1
        replyInstance.zhoubao=  zhoubao

        def date = new Date()
        replyInstance.date = date
        replyInstance.status = 0
        if(!replyInstance.save(flush: true)){
            rs.result = false
            rs.msg = "回复失败"
        }else{
            rs.result = true
            rs.msg = "回复成功"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //未读回复
    def unreadTaskReply(){
        def rs = [:]
        def replyInfo = []
        def uid = params.uid
        def cid = params.cid
        def replyInstance = ReplyReport.findAllByBpuidAndCidAndStatus(uid, cid, 0, [sort: "date", order: "desc"])

        if(replyInstance){
            for (def i=0;i<replyInstance.size();i++){
                def info= [:]
                info.allInfo=replyInstance.get(i)
                info.year = replyInstance.get(i).zhoubao.year
                info.month = replyInstance.get(i).zhoubao.month
                info.week= replyInstance.get(i).zhoubao.week
                replyInfo<<info
            }

            rs.result = true
            rs.replyInfo = replyInfo
        }else{
            rs.result = false
            rs.msg = "没有未读回复"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    //回复状态修改
    def replyStatusUpdate(){
        def rs = [:]
        def id = params.id
        def uid = params.uid
        def cid = params.cid
        def i
        def zhoubao = Zhoubao.get(id)
        def replyInstance = ReplyReport.findAllByZhoubaoAndCidAndBpuidAndStatus(zhoubao,cid,uid,0,[sort: "date",order: "desc"])
        for(i=0;i<replyInstance.size();i++){
            replyInstance[i].status=1
        }

        if(replyInstance){
            rs.result = true
            rs.replyInstance = replyInstance
        }else{
            rs.result = false
            rs.msg = "没有未读回复"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //全部回复
    def allReply(){
        def rs = [:]
        def replyInfo = []
        def uid = params.uid
        def cid = params.cid
        def replyInstance = ReplyReport.findAllByBpuidAndCid(uid, cid, [sort: "date", order: "desc"])
        if(replyInstance){
            for (def i=0;i<replyInstance.size();i++){
                def info= [:]
                info.allInfo=replyInstance.get(i)
                info.year = replyInstance.get(i).zhoubao.year
                info.month = replyInstance.get(i).zhoubao.month
                info.week= replyInstance.get(i).zhoubao.week
                replyInfo<<info
            }

            rs.result = true
            rs.replyInfo = replyInfo
        }else{
            rs.result = false
            rs.msg = "没有回复"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    //何须助手知识列表
    def hxhelper(){


        def rs = [:]

        params.max = 8
        params<<[sort: 'dateCreate',order: 'desc']
        def offset = 0
        def offse = params.offset.toInteger()
        if(offse>0){
            offset = offse
        }
        params<<[offset: offset]

        def bookInstanceTotal = Book.count()
        if(bookInstanceTotal>offset){
            def bookInstanceList = Book.list(params)
            if(bookInstanceList){
                rs.result = true
                rs.bookInstanceList = bookInstanceList
            }else{
                rs.result = false
                rs.msg = "已加载所有数据"
            }
        }else{
            rs.result = false
            rs.msg = "已加载所有数据"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //知识大纲列表
    def syllabusList(){
        def rs = [:]
        def id = params.id

        params.max = 10
        params<<[sort:"id", order:"asc"]
        def offset = 0
        def offse = params.offset.toInteger()
        if(offse>0){
            offset = offse
        }
        params<<[offset: offset]

        def syllabusInfoTotal = Syllabus.countByBook(Book.get(id))
        if(syllabusInfoTotal>offset){
            def syllabusInfoList = Syllabus.findAllByBook(Book.get(id),params)
            if(syllabusInfoList){
                rs.result = true
                rs.syllabusInfoList = syllabusInfoList
            }else{
                rs.result = false
                rs.msg = "已加载所有数据"
            }
        }else{
            rs.result = false
            rs.msg = "已加载所有数据"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    //知识章节列表
    def chapterList(){
        def rs = [:]
        def id = params.id

        params.max = 10
        params<<[sort:"id", order:"asc"]
        def offset = 0
        def offse = params.offset.toInteger()
        if(offse>0){
            offset = offse
        }
        params<<[offset: offset]

        def chapterInfoTotal = Chapter.countBySyllabus(Syllabus.get(id))
        if(chapterInfoTotal>offset){
            def chapterInfoList = Chapter.findAllBySyllabus(Syllabus.get(id),params)
            if(chapterInfoList){
                rs.result = true
                rs.chapterInfoList = chapterInfoList
            }else{
                rs.result = false
                rs.msg = "已加载所有数据"
            }
        }else{
            rs.result = false
            rs.msg = "已加载所有数据"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //知识内容详情
    def knowcontent(){
        def rs = [:]
        def id = params.id

        params.max = 1
        params<<[sort:"id", order:"asc"]
        def offset = 0
        def offse = params.offset.toInteger()
        if(offse>0){
            offset = offse
        }
        params<<[offset: offset]

        def contentInfoTotal = Content.countByChapter(Chapter.get(id))
        if(contentInfoTotal>offset){
            def contentInfoList = Content.findAllByChapter(Chapter.get(id),params)
            if(contentInfoList){
                rs.result = true
                rs.contentInfoList = contentInfoList
            }else{
                rs.result = false
                rs.msg = "已加载所有数据"
            }
        }else{
            rs.result = false
            rs.msg = "已加载所有数据"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    //工具列表
    def toolList(){
        def rs = [:]

        params.max = 8
        params<<[sort: 'dateCreate',order: 'desc']
        def offset = 0
        def offse = params.offset.toInteger()
        if(offse>0){
            offset = offse
        }
        params<<[offset: offset]

        def toolInstanceTotal = HexuTool.countByStyle(1)
        if(toolInstanceTotal>offset){
            def toolInstanceList = HexuTool.findAllByStyle(1,params)
            if(toolInstanceList){
                rs.result = true
                rs.toolInstanceList = toolInstanceList
            }else{
                rs.result = false
                rs.msg = "已加载所有数据"
            }
        }else{
            rs.result = false
            rs.msg = "已加载所有数据"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //工具内容
    def toolContent(){
        def rs = [:]
        def id = params.id

        params.max = 1
        params<<[sort:"id", order:"asc"]
        def offset = 0
        def offse = params.offset.toInteger()
        if(offse>0){
            offset = offse
        }
        params<<[offset: offset]

        def toolContentInfoTotal = ToolContent.countByHexutools(HexuTool.get(id))
        if(toolContentInfoTotal>offset){
            def toolContentInfoList = ToolContent.findAllByHexutools(HexuTool.get(id),params)
            if(toolContentInfoList){
                rs.result = true
                rs.toolContentInfoList = toolContentInfoList
            }else{
                rs.result = false
                rs.msg = "已加载所有数据"
            }
        }else{
            rs.result = false
            rs.msg = "已加载所有数据"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //案例列表
    def exampleList(){
        def rs = [:]

        params.max = 8
        params<<[sort: 'dateCreate',order: 'desc']
        def offset = 0
        def offse = params.offset.toInteger()
        if(offse>0){
            offset = offse
        }
        params<<[offset: offset]

        def exampleInstanceTotal = HexuTool.countByStyle(2)
        if(exampleInstanceTotal>offset){
            def exampleInstanceList = HexuTool.findAllByStyle(2,params)
            if(exampleInstanceList){
                rs.result = true
                rs.exampleInstanceList = exampleInstanceList
            }else{
                rs.result = false
                rs.msg = "已加载所有数据"
            }
        }else{
            rs.result = false
            rs.msg = "已加载所有数据"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //案例内容
    def exampleContent(){
        def rs = [:]
        def id = params.id

        params.max = 1
        params<<[sort:"id", order:"asc"]
        def offset = 0
        def offse = params.offset.toInteger()
        if(offse>0){
            offset = offse
        }
        params<<[offset: offset]

        def exampleInstanceTotal = ToolContent.countByHexutools(HexuTool.get(id))
        if(exampleInstanceTotal>offset){
            def exampleInstanceList = ToolContent.findAllByHexutools(HexuTool.get(id),params)
            if(exampleInstanceList){
                rs.result = true
                rs.exampleInstanceList = exampleInstanceList
            }else{
                rs.result = false
                rs.msg = "已加载所有数据"
            }
        }else{
            rs.result = false
            rs.msg = "已加载所有数据"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
}
