package com.guihuabao

import grails.converters.JSON

import java.text.DateFormat
import java.text.SimpleDateFormat

class GhbotherapiController {

    //首页
    def index() {
        def rs=[:]
        def cid=params.cid
        def uid=params.uid

        params.max = 2
        params<<[sort:"dateCreate",order: "desc"]

        def current = new Date()
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd")
        def now = time.format(current)

        def targetlist = Target.findAllByFzuidAndCidAndStatus(uid, cid, 0, params)//目标列表
        def todayTaskList = Task.findAllByCidAndPlayuidAndLookstatusAndStatusAndBigentimeLessThanEqualsAndOvertimeGreaterThanEquals(cid,uid,2,0,now,now,params)//今日任务
        def applylist= Apply.findAllByApplyuidAndCidAndApplystatuss(uid,cid,1,params)//申请列表
        def companyNoticeInstanceList = CompanyNotice.findAllByCid(cid,params)//公告列表

        if(targetlist){
            rs.targetresult = true
            rs.targetlist = targetlist
        }else{
            rs.targetresult = false
            rs.targetmsg = "未找到目标"
        }

        if(todayTaskList){
            rs.todayTaskresult = true
            rs.todayTasklist = todayTaskList
        }else{
            rs.todayTaskresult = false
            rs.todayTaskmsg = "未找到任务"
        }

        if(applylist){
            rs.applyresult = true
            rs.applylist = applylist
        }else{
            rs.applyresult = false
            rs.applymsg = "未找到申请"
        }

        def a = companyNoticeInstanceList
        if(companyNoticeInstanceList){
            rs.companyNoticeresult = true
            rs.companyNoticelist = companyNoticeInstanceList
        }else{
            rs.companyNoticeresult = false
            rs.companyNoticemsg = "未找到公告"
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
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
        if(params.copyuid) {
            applyInstance.copyname = CompanyUser.get(params.copyuid).name
        }
        if(params.approvaluid) {
            applyInstance.approvalusername = CompanyUser.get(params.approvaluid).name
        }
        applyInstance.status="未审核"
//        Date currentTime = new Date();
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        def nowdate=new Date()
        def time1 = time.format(nowdate).toString()
//        def date = time.format(nowdate)
        applyInstance.dateCreate=time1
        applyInstance.applystatus=0
        if(params.applysub=="1"){//判断是存草稿0还是提交1
            applyInstance.applystatuss=1
        }else{
            applyInstance.applystatuss=0
        }
        applyInstance.copyremind = 0
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
    //审批人列表接口
    def approveperson(){
        def cid = params.cid
        def rs=[:]
        def userInfo = []
        def companyuserList= CompanyUser.findAllByCidAndPidLessThan(cid,3,[sort: "pid",order: "asc"])
        for(def i=0;i<companyuserList.size();i++){
            def companyuser = companyuserList.get(i)
            def bumenname = Bumen.findByCidAndId(cid,companyuser.bid).name
            def info=[:]
            info <<[userId: companyuser.id,bumenname: bumenname,username: companyuser.name]
            userInfo<<info
        }

        if(userInfo){
            rs.result=true
            rs.userInfo = userInfo
            rs.msg = "查找审批人成功"
        }else{
            rs.result = false
            rs.msg = "查找审批人失败"
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
        def applyInctance = Apply.findByIdAndCid(id,companyId)
        if(userId==applyInctance.applyuid&&applyInctance.applystatus!=0){
            applyInctance.remindstatus = 0
        }else if(userId == applyInctance.copyuid&&applyInctance.applystatus!=0){
            applyInctance.copyremind = 0
        }

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
                applyInstance.copyremind = 1
            } else if(applystatus=="2"){
                applyInstance.applystatus = 2
                applyInstance.status = "未通过"
                applyInstance.remindstatus = 1
            }
            applyInstance.properties = params
        }


        if(!applyInstance.save(flush: true)){
            rs.result=false
            rs.msg = "审核失败"
        }else{
            rs.result=true
            rs.msg = "审核成功"
            rs.applyInstance = applyInstance
        }


        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    //申请草稿编辑
    def applyUpdate(){
        def rs = [:]
        def id = params.id
        def applyInstance  = Apply.get(id)
        if(params.approvaluid) {
            applyInstance.approvalusername = CompanyUser.get(params.approvaluid).name
        }

        if(params.copyuid) {
            applyInstance.copyname = CompanyUser.get(params.copyuid).name
        }
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

            if (!applyInstance.save(flush: true)) {
                rs.result=false
                rs.msg="修改失败"
            }else {
                rs.result=true
                rs.msg="修改成功"
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

    //申请抄送我的
    def copyToMe(){

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
        if(selected == "1"){//未查看
            applylist= Apply.findAllByCopyuidAndCidAndApplystatusAndCopyremind(userId,companyId,1,1,params)
            applyInstanceTotal= Apply.countByCopyuidAndCidAndApplystatusAndCopyremind(userId,companyId,1,1)
        }else if(selected == "0"){//已查看
            applylist= Apply.findAllByCopyuidAndCidAndApplystatusAndCopyremind(userId,companyId,1,0,params)
            applyInstanceTotal= Apply.countByCopyuidAndCidAndApplystatusAndCopyremind(userId,companyId,1,0)
        }else{//全部
            applylist= Apply.findAllByCopyuidAndCidAndApplystatus(userId,companyId,1,params)
            applyInstanceTotal= Apply.countByCopyuidAndCidAndApplystatus(userId,companyId,1)
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

    //抄送提醒状态修改
    def copyRemindUpdate(){
        def rs = [:]
        def id= params.id
        def companyId = params.cid
        def applyInstance = Apply.findByIdAndCid(id,companyId)
        if(!applyInstance){
            rs.result = false
            rs.msg = "未找到相应申请"
        }else{
            rs.result = true
            rs.msg = "成功"
            applyInstance.copyremind = 0

            applyInstance.properties = params
        }

        if(!applyInstance.save(flush: true)){
            rs.result = false
            rs.msg = "保存失败"
        }else{
            rs.result = true
            rs.msg = "成功"
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
        def replyInfo = []
        def date
        def date1
        DateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");
        if(params.reportdate){
            date = params.reportdate
        }else{
            date = dayFormat.format(new Date())
        }
        def i
        def uid = params.userId
        def cid = params.cid
        def month_week = weekJudge(date)
        def n_year=month_week.year
        def n_month=month_week.month
        def n_week=month_week.nowweek

        def myReportInfo =Zhoubao.findByUidAndCidAndYearAndMonthAndWeek(uid,cid,n_year,n_month,n_week)
        def replyInstance = ReplyReport.findAllByZhoubaoAndCid(myReportInfo,cid,[sort: "date",order: "desc"])
        def ureadReply = ReplyReport.findAllByZhoubaoAndCidAndBpuidAndStatus(myReportInfo,cid,uid,0)
        for(i=0;i<ureadReply.size();i++){
            ureadReply[i].status=1
        }

        if(replyInstance){
            for (def n=0;n<replyInstance.size();n++){
                def allInfo=replyInstance.get(n)
                allInfo.img = CompanyUser.findByIdAndCid(allInfo.puid,cid).img
                replyInfo<<allInfo
            }
        }

        date1 = dayFormat.parse(date)

        Calendar calendar = new GregorianCalendar();
        def day = date1
        calendar.clear();
        calendar.setTime(day);
        calendar.add(Calendar.DATE,-7)
        rs.prevweek = dayFormat.format(calendar.getTime())

        if(myReportInfo){
            rs.result = true
            rs.myReportInfo = myReportInfo
            rs.replyInfo = replyInfo
        }else{
            rs.year = n_year
            rs.month = n_month
            rs.week = n_week
            rs.result = false
            rs.msg = "未保存报告"
        }

        if(params.callback){
            render "${params.callback}(${rs as JSON})"
        }else
            render rs as JSON
    }

    //下属报告
    def xsReport(){
        def rs = [:]
        def replyInfo = []
        def date
        def date1
        DateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");
        if(params.reportdate){
            date = params.reportdate
        }else{
            date = dayFormat.format(new Date())
        }
        def i
        def dluid = params.dluid
        def uid = params.userId
        def cid = params.cid
        def month_week = weekJudge(date)
        def n_year=month_week.year
        def n_month=month_week.month
        def n_week=month_week.nowweek

        def myReportInfo =Zhoubao.findByUidAndCidAndYearAndMonthAndWeek(uid,cid,n_year,n_month,n_week)
        def replyInstance = ReplyReport.findAllByZhoubaoAndCid(myReportInfo,cid,[sort: "date",order: "desc"])
        def ureadReply = ReplyReport.findAllByZhoubaoAndCidAndBpuidAndStatus(myReportInfo,cid,dluid,0)
        for(i=0;i<ureadReply.size();i++){
            ureadReply[i].status=1
        }

        if(replyInstance){
            for (def n=0;n<replyInstance.size();n++){
                def allInfo=replyInstance.get(n)
                allInfo.img = CompanyUser.findByIdAndCid(allInfo.puid,cid).img
                replyInfo<<allInfo
            }
        }

        date1 = dayFormat.parse(date)

        Calendar calendar = new GregorianCalendar();
        def day = date1
        calendar.clear();
        calendar.setTime(day);
        calendar.add(Calendar.DATE,-7)
        rs.prevweek = dayFormat.format(calendar.getTime())

        if(myReportInfo){
            if(myReportInfo.submit){
                rs.result = true
                rs.myReportInfo = myReportInfo
                rs.replyInfo = replyInfo
            }else{
                rs.year = n_year
                rs.month = n_month
                rs.week = n_week
                rs.result = false
                rs.msg = "未保存报告"
            }
        }else{
            rs.year = n_year
            rs.month = n_month
            rs.week = n_week
            rs.result = false
            rs.msg = "未保存报告"
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
        def myReportInfos
        def rs =[:]
        def id = params.id
        def date
        DateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");
        date = dayFormat.format(new Date())
        def month_week = weekJudge(date)

        myReportInfo = Zhoubao.findByUidAndCidAndYearAndMonthAndWeek(params.uid,params.cid,params.year.toString(),params.month.toString(),params.week.toString())
        if (!myReportInfo) {
            params.username = CompanyUser.findById(params.uid).name
            myReportInfos = new Zhoubao(params)
            myReportInfos.dateCreate = new Date()
            myReportInfos.submit = 0
            if(!myReportInfos.save(flush: true)){
                rs.result = false
                rs.msg = "保存失败"
            }else{
                rs.result = true
                rs.msg = "保存成功"
            }
        }else {
            params.username = CompanyUser.findById(params.uid).name
            myReportInfo.properties = params
            if (myReportInfo.save(flush: true)) {
                rs.result = true
                rs.msg = "保存成功"
            }else{
                rs.result = false
                rs.msg = "保存失败"
            }
        }

//        if (myReportInfo.save(flush: true)) {
//            rs.result = true
//            rs.msg = "周报保存成功"
//        }else{
//            rs.result = false
//            rs.msg = "周报保存失败"
//        }

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
        def myReportInfo = Zhoubao.findByIdAndCid(id,cid)
        if(myReportInfo){
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
                def allInfo=replyInstance.get(i)
                allInfo.reportuid=replyInstance.get(i).zhoubao.uid
                allInfo.reportdate= replyInstance.get(i).zhoubao.dateCreate
                allInfo.title= replyInstance.get(i).zhoubao.week
                allInfo.img = CompanyUser.findByIdAndCid(allInfo.puid,cid).img
                replyInfo<<allInfo
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
                def allInfo=replyInstance.get(i)
                allInfo.reportuid=replyInstance.get(i).zhoubao.uid
                allInfo.reportdate= replyInstance.get(i).zhoubao.dateCreate
                allInfo.title= replyInstance.get(i).zhoubao.week
                allInfo.img = CompanyUser.findByIdAndCid(allInfo.puid,cid).img
                replyInfo<<allInfo
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
        params<<[sort: 'id',order: 'asc']
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
        params<<[sort: 'id',order: 'asc']
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
        params<<[sort: 'id',order: 'asc']
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

    /*
    * 部门及人员列表
    * */
    def subordinateList(){
        def rs = [:]
        def cid = params.cid
        def bid = params.bid

        def bumen
        def bumenList
        def companyUserList

        def ssbumenName

        bumenList = Bumen.findAllByAffiliatedAndCid(bid,cid)
        companyUserList=CompanyUser.findAllByCidAndBid(cid,bid)
        bumen=Bumen.findById(bid);

        if(bumen.affiliated!=0) {
            ssbumenName = Bumen.findById(bumen.affiliated).name
        }
        rs.bumenList=bumenList
        rs.companyUserList=companyUserList

        rs.ssbname=ssbumenName
        rs.ssbid=bumen.affiliated
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
 }
