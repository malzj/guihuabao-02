package com.guihuabao

import grails.converters.JSON
import org.springframework.web.multipart.MultipartFile

import java.text.SimpleDateFormat

class MyController {
    def targetRemind(){
        def rs=[:]
        def uid=params.uid
        def cid=params.cid
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        def date = time.format(new Date())
        Calendar calendar = new GregorianCalendar()
        Date date1 = time.parse(date)
        calendar.setTime(date1)
        calendar.add(Calendar.HOUR,6)
        def etime = time.format(calendar.getTime())
        params.max = 5
        params<<[sort:"dateCreate",order: "desc"]
        def offset = 0;
        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def endedtargetlistsize=Target.countByCidAndFzuidAndStatusAndEtimeGreaterThanEqualsAndEtimeLessThanEquals(cid, uid, 0, date, etime)
        def offse=params.offset.toInteger()
        if(endedtargetlistsize>offse) {
            def endedtargetlist = Target.findAllByCidAndFzuidAndStatusAndEtimeGreaterThanEqualsAndEtimeLessThanEquals(cid, uid, 0, date, etime,params)
            if (endedtargetlist) {
                rs.result = true
                rs.endedtargetlist = endedtargetlist
            } else {
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
    def taskRemind(){
        def rs=[:]
        def uid=params.uid
        def cid=params.cid
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        def nowdate=new Date()
        def date = time.format(nowdate)
        Calendar calendar = new GregorianCalendar()
        Date date1 = time.parse(date)
        calendar.setTime(date1)
        def hour=nowdate.getHours()


        switch (hour){
            case 19: calendar.add(Calendar.HOUR,4); break;
            case 20: calendar.add(Calendar.HOUR,3); break;
            case 21: calendar.add(Calendar.HOUR,2); break;
            case 22: calendar.add(Calendar.HOUR,1); break;
            case 23: calendar.add(Calendar.HOUR,0); break;
            default: calendar.add(Calendar.HOUR,6); break;
        }
        def etime = time.format(calendar.getTime())
        def timearr = etime.split(" ")
        def timearr1 = date.split(" ")
        def enddate = timearr[0]
        def endtime = timearr[1]
        def nowday = timearr1[0]
        def nowtime = timearr1[1]
        params.max = 5
        params<<[sort:"dateCreate",order: "desc"]
        def offset = 0;
        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def endedtasklistsize=Task.countByCidAndPlayuidAndOvertimeAndOverhourLessThanEqualsAndOverhourGreaterThanEqualsAndLookstatusAndStatus(cid,uid,nowday,endtime,nowtime,2,0)
        def offse=params.offset.toInteger()
        if(endedtasklistsize>offse) {
            def endedtasklist = Task.findAllByCidAndPlayuidAndOvertimeAndOverhourLessThanEqualsAndOverhourGreaterThanEqualsAndLookstatusAndStatus(cid, uid, nowday, endtime, nowtime, 2, 0,params)
            if(endedtasklist){
                rs.result=true
                rs.endedtasklist=endedtasklist
            }else{
                rs.result=false
                rs.msg="已加载所有数据！"
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
    def taskReplyRemind(){
        def rs=[:]
        def uid=params.uid
        def cid=params.cid
        def unreadtaskreplylist=ReplyTask.findAllByBpuidAndCidAndStatus(uid,cid,0)
        if(!unreadtaskreplylist){
            rs.result=false
            rs.msg="没有未读回复！"
        }else{
            rs.result=true
            rs.unreadtaskreplylist=unreadtaskreplylist
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def hasFinishedTaskRemind(){
        def rs=[:]
        def uid=params.uid
        def cid=params.cid
        params.max = 5
        params<<[sort:"dateCreate",order: "desc"]
        def offset = 0;
        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def hasfinishedtasklistsize=Task.countByCidAndFzuidAndStatus(cid, uid, 1)
        def offse=params.offset.toInteger()
        if(hasfinishedtasklistsize>offse) {
            def hasfinishedtasklist=Task.findAllByCidAndFzuidAndStatus(cid, uid, 1,params)
            if(hasfinishedtasklist){
                rs.result=true
                rs.hasfinishedtasklist=hasfinishedtasklist
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
    def applyResultRemind(){
        def rs=[:]
        def uid=params.uid
        def cid=params.cid
        params.max = 5
        params<<[sort:"dateCreate",order: "desc"]
        def offset = 0;
        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def applylistsize=Apply.countByCidAndApplyuidAndRemindstatus(cid, uid,1)
        def offse=params.offset.toInteger()
        if(applylistsize>offse) {
            def applylist=Apply.findAllByCidAndApplyuidAndRemindstatus(cid,uid,1,params)
            if(applylist){
                rs.result=true
                rs.applylist=applylist
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
    def unreadTask(){
        def rs=[:]
        def uid=params.uid
        def cid=params.cid
        params.max = 5
        params<<[sort:"dateCreate",order: "desc"]
        def offset = 0;
        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def unreadtasklistsize=Task.countByCidAndPlayuidAndLookstatus(cid, uid, 0)
        def offse=params.offset.toInteger()
        if(unreadtasklistsize>offse) {
            def unreadtasklist=Task.findAllByCidAndPlayuidAndLookstatus(cid, uid, 0,params)
            if(unreadtasklist){
                rs.result=true
                rs.unreadtasklist=unreadtasklist
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
    def applyRemind(){
        def rs=[:]
        def uid=params.uid
        def cid=params.cid
        params.max = 5
        params<<[sort:"dateCreate",order: "desc"]
        def offset = 0;
        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def applylistsize=Apply.countByCidAndApprovaluidAndApplystatus(cid, uid,0)
        def offse=params.offset.toInteger()
        if(applylistsize>offse) {
            def applylist=Apply.findAllByCidAndApprovaluidAndApplystatus(cid,uid,0,params)
            if(applylist){
                rs.result=true
                rs.applylist=applylist
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
    def uReplyMissionRemind(){
        def rs=[:]
        def uid=params.uid
        def cid=params.cid
        params.max = 5
        params<<[sort:"date",order: "desc"]
        def offset = 0;
        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def uReplyMissionsize=ReplyMission.countByBpuidAndCidAndStatus(uid,cid,0)
        def offse=params.offset.toInteger()
        if(uReplyMissionsize>offse) {
            def uReplyMissions=ReplyMission.findAllByBpuidAndCidAndStatus(uid,cid,0,params)
            if(uReplyMissions){
                rs.result=true
                rs.uReplyMissions=uReplyMissions
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
    def uReplyReportRemind(){
        def rs=[:]
        def uid=params.uid
        def cid=params.cid
        params.max = 5
        params<<[sort:"date",order: "desc"]
        def offset = 0;
        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def uReplyReportsize=ReplyReport.countByBpuidAndCidAndStatus(uid,cid,0)
        def offse=params.offset.toInteger()
        if(uReplyReportsize>offse) {
            def uReplyReports=ReplyReport.findAllByBpuidAndCidAndStatus(uid,cid,0,params)
            if(uReplyReports){
                rs.result=true
                rs.uReplyReports=uReplyReports
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
    def uMissionRemind(){
        def rs=[:]
        def uid=params.uid

        params.max = 5
        params<<[sort:"dateCreate",order: "desc"]
        def offset = 0;
        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def uMissionsize=Mission.countByPlayuidAndHasvisited(uid,0)
        def offse=params.offset.toInteger()
        if(uMissionsize>offse) {
            def uMissions=Mission.findAllByPlayuidAndHasvisited(uid,0,params)
            if(uMissions){
                rs.result=true
                rs.uMissions=uMissions
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
    def hasfinishedTargetRemind(){
        def rs=[:]
        def uid=params.uid

        params.max = 5
        params<<[sort:"dateCreate",order: "desc"]
        def offset = 0;
        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def hasfinishedTargetsize=Target.countByFzuidAndStatusAndIscheck(uid,1,0)
        def offse=params.offset.toInteger()
        if(hasfinishedTargetsize>offse) {
            def hasfinishedTargets=Target.findAllByFzuidAndStatusAndIscheck(uid,1,0,params)
            if(hasfinishedTargets){
                rs.result=true
                rs.hasfinishedTargets=hasfinishedTargets
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
    def chaosongRemind(){
        def rs=[:]
        def uid=params.uid
        def cid=params.cid
        params.max = 5
        params<<[sort:"date",order: "desc"]
        def offset = 0;
        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def chaosongsize=Apply.countByCopyuidAndCidAndApplystatusAndCopyremind(uid,cid,1,1)
        def offse=params.offset.toInteger()
        if(chaosongsize>offse) {
            def chaosongs=Apply.findAllByCopyuidAndCidAndApplystatusAndCopyremind(uid,cid,1,1,params)
            if(chaosongs){
                rs.result=true
                rs.chaosongs=chaosongs
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

    def funIntroduction(){
        def rs=[:]
        def funIntroduction=FunIntroduction.findById(1)
        if(!funIntroduction){
            rs.result=false
            rs.msg="获取数据失败！"
        }else{
            rs.result=true
            rs.funIntroduction=funIntroduction
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def inform(){
        def rs=[:]
        def inform=Inform.list()
        if(!inform){
            rs.result=false
            rs.msg="获取数据失败！"
        }else{
            rs.result=true
            rs.inform=inform
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def informInstance(){
        def rs=[:]
        def id=params.id
        def informInstance=Inform.get(id)
        if(!informInstance){
            rs.result=false
            rs.msg='获取数据失败！'

        }else{
            rs.result=true
            rs.informInstance=informInstance
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def feedback(){
        def rs=[:]
        def uid=params.uid
        def content=params.content
        def uname=params.uname
        def feedbackInstance=new Feedback(params)

        if(!feedbackInstance.save(flush: true)){
            rs.result=false
            rs.msg="保存失败！"
        }else{
            rs.result=true
            rs.feedbackInstance=feedbackInstance
            rs.msg="保存成功！"
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def version(){
        def rs=[:]
        def version=Banben.findById(1)
        if(!version){
            rs.result=false
            rs.msg="获取数据失败！"
        }else{
            rs.result=true
            rs.version=version
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def clause(){
        def rs=[:]
        def clause=Clause.findById(1)
        if(!clause){
            rs.result=false
            rs.msg="获取数据失败！"
        }else{
            rs.result=true
            rs.clause=clause
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def messages(){
        def rs=[:]
        def uid=params.uid
        def cid=params.cid
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        def date = time.format(new Date())
        Calendar calendar = new GregorianCalendar()
        Date date1 = time.parse(date)
        calendar.setTime(date1)
        calendar.add(Calendar.HOUR,6)
        def sum=0
        def etime = time.format(calendar.getTime())
        def endedtargetlistsize=Target.countByCidAndFzuidAndStatusAndEtimeGreaterThanEqualsAndEtimeLessThanEquals(cid, uid, 0, date, etime)
//        sum+=endedtargetlistsize


        def nowdate=new Date()
        def date2 = time.format(nowdate)
        Calendar calendar1 = new GregorianCalendar()
        Date date3 = time.parse(date2)
        calendar1.setTime(date3)
        def hour=nowdate.getHours()


        switch (hour){
            case 19: calendar1.add(Calendar.HOUR,4); break;
            case 20: calendar1.add(Calendar.HOUR,3); break;
            case 21: calendar1.add(Calendar.HOUR,2); break;
            case 22: calendar1.add(Calendar.HOUR,1); break;
            case 23: calendar1.add(Calendar.HOUR,0); break;
            default: calendar1.add(Calendar.HOUR,6); break;
        }
        def etime1 = time.format(calendar1.getTime())
        def timearr = etime1.split(" ")
        def timearr1 = date.split(" ")
        def enddate = timearr[0]
        def endtime = timearr[1]
        def nowday = timearr1[0]
        def nowtime = timearr1[1]
        def endedtasklistsize=Task.countByCidAndPlayuidAndOvertimeAndOverhourLessThanEqualsAndOverhourGreaterThanEqualsAndLookstatusAndStatus(cid,uid,nowday,endtime,nowtime,2,0)
//        sum+=endedtasklistsize
        def unreadtaskreplylist=ReplyTask.countByBpuidAndCidAndStatus(uid,cid,0)
        sum+=unreadtaskreplylist
        def hasfinishedtasklistsize=Task.countByCidAndFzuidAndStatusAndRemindstatus(cid, uid, 1,1)
//        sum+=hasfinishedtasklistsize
        def applylistsize=Apply.countByCidAndApplyuidAndRemindstatus(cid, uid,1)
        sum+=applylistsize
        def unreadtasklistsize=Task.countByCidAndPlayuidAndLookstatus(cid, uid, 0)
        sum+=unreadtasklistsize
        def applylistsize1=Apply.countByCidAndApprovaluidAndApplystatus(cid, uid,0)
        sum+=applylistsize1
        def chaosongsize=Apply.countByCopyuidAndCidAndApplystatusAndCopyremind(uid,cid,1,1)
        sum+=chaosongsize
        def hasfinishedTargetsize=Target.countByFzuidAndStatusAndIscheck(uid,1,0)
        sum+=hasfinishedTargetsize
        def uMissionsize=Mission.countByPlayuidAndHasvisitedAndIssubmit(uid,0,1)
        sum+=uMissionsize
        def uReplyMissionsize=ReplyMission.countByBpuidAndCidAndStatus(uid,cid,0)
        sum+=uReplyMissionsize
        def uReplyReportsize=ReplyReport.countByBpuidAndCidAndStatus(uid,cid,0)
        sum+=uReplyReportsize
        if(sum>0){
            rs.sign=1
        }else{
            rs.sign=0
        }
        rs.endedtasklistsize=endedtasklistsize
        rs.endedtargetlistsize=endedtargetlistsize
        rs.unreadtaskreplylist=unreadtaskreplylist
        rs.hasfinishedtasklistsize=hasfinishedtasklistsize
        rs.hasfinishedtasklistsize=hasfinishedtasklistsize
        rs.applylistsize=applylistsize
        rs.unreadtasklistsize=unreadtasklistsize
        rs.applylistsize1=applylistsize1
        rs.chaosongsize=chaosongsize
        rs.hasfinishedTargetsize=hasfinishedTargetsize
        rs.uMissionsize=uMissionsize
        rs.uReplyMissionsize=uReplyMissionsize
        rs.uReplyReportsize=uReplyReportsize
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def userShow(){
        def rs=[:]
        def uid=params.uid
        def cid=params.cid
        def companyuserInstance=CompanyUser.findByIdAndCid(uid,cid)

        if(!companyuserInstance){
            rs.result=false
            rs.msg="获取数据失败！"
        }else{

            def bumen=Bumen.findById(companyuserInstance.bid).name
            def pname=Persona.findById(companyuserInstance.pid).name
            rs.result=true
            rs.user=companyuserInstance
            rs.bumen=bumen
            rs.pname=pname

        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def personalset(){
        def rs=[:]
        def uid=params.uid
        def cid=params.cid
        def companyuserInstance=CompanyUser.findByIdAndCid(uid,cid)
        if(!companyuserInstance){
            rs.result=false
            rs.msg="获取数据失败！"
        }else{
            companyuserInstance.properties=params
            if(!companyuserInstance.save(flush: true)){
                rs.result=false
                rs.msg="编辑失败！"
            }else{
                rs.result=true
                rs.msg="编辑成功！"
            }
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def passwordEdit(){
        def rs=[:]
        def uid=params.uid
        def cid=params.cid
        def oldpassword=params.oldpassword
        def newpassword=params.newpassword
        def companyuserInstance=CompanyUser.findByIdAndCid(uid,cid)
        if(!companyuserInstance){
            rs.result=false
            rs.msg="获取数据失败！"
        }else{
            if(companyuserInstance.password==oldpassword){
                companyuserInstance.password=newpassword
                if(!companyuserInstance.save(flush: true)){
                    rs.result=false
                    rs.msg="修改密码失败！"
                }else{
                    rs.result=true
                    rs.msg="修改密码成功！"
                }
            }else{
                rs.result=false
                rs.msg="旧密码错误！"

            }
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def uploadImg(){
        def rs=[:]
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
            def userDir = new File(webRootDir, "uploadfile/target-img/")
            userDir.mkdirs()
            def s=f.transferTo( new File( userDir, fileName))

               rs.result=true
               rs.fileName = fileName
               rs.msg="上传成功！"


        }else{
            rs.result=false
            rs.msg="上传失败！"
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def uploadImg1(){
        def rs=[:]
        def uid=params.uid
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
            def userDir = new File(webRootDir, "uploadfile/images/")
            userDir.mkdirs()
            def s=f.transferTo( new File( userDir, fileName))
            def user=CompanyUser.findById(uid)
            if(!user){
                rs.result=false
                rs.msg='无此用户！'
            }else{
                user.img=fileName
                if(!user.save()){
                    rs.result=false
                    rs.msg='保存失败！'
                }else{
                    rs.result=true
                    rs.fileName = fileName
                    rs.msg="上传成功！"
                }
            }




        }else{
            rs.result=false
            rs.msg="上传失败！"
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
}
