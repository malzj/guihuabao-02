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
        def inform=Inform.findById(1)
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
        def etime = time.format(calendar.getTime())
        def endedtargetlistsize=Target.countByCidAndFzuidAndStatusAndEtimeGreaterThanEqualsAndEtimeLessThanEquals(cid, uid, 0, date, etime)



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

        def unreadtaskreplylist=ReplyTask.countByBpuidAndCidAndStatus(uid,cid,0)

        def hasfinishedtasklistsize=Task.countByCidAndFzuidAndStatus(cid, uid, 1)

        def applylistsize=Apply.countByCidAndApplyuidAndRemindstatus(cid, uid,1)

        def unreadtasklistsize=Task.countByCidAndPlayuidAndLookstatus(cid, uid, 0)

        def applylistsize1=Apply.countByCidAndApprovaluidAndApplystatus(cid, uid,0)
        rs.endedtasklistsize=endedtasklistsize
        rs.endedtargetlistsize=endedtargetlistsize
        rs.unreadtaskreplylist=unreadtaskreplylist
        rs.hasfinishedtasklistsize=hasfinishedtasklistsize
        rs.hasfinishedtasklistsize=hasfinishedtasklistsize
        rs.applylistsize=applylistsize
        rs.unreadtasklistsize=unreadtasklistsize
        rs.applylistsize1=applylistsize1
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
            def userDir = new File(webRootDir, "img/target-img/")
            userDir.mkdirs()
           if( f.transferTo( new File( userDir, fileName))) {
               rs.result=true
               rs.fileName = fileName
               rs.msg="上传成功！"
           }else{
               rs.result=false
               rs.msg="上传失败！"
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