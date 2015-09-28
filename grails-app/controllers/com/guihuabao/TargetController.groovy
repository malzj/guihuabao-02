package com.guihuabao

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

import java.text.SimpleDateFormat

class TargetController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def myTargetList(){
        def rs=[:]
        def cid=params.cid
        def uid=params.uid

        params.max = 5
        params<<[sort:"dateCreate",order: "desc"]
        def offset = 0;
        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def targetsize=Target.countByFzuidAndCidAndStatus(uid,cid,0)
        def offse=params.offset.toInteger()
        if(targetsize>offse) {
            def targetlist = Target.findAllByFzuidAndCidAndStatus(uid, cid, 0, params)
            if (targetlist) {
                rs.result = true
                rs.targetlist = targetlist
            } else {
                rs.result = false
                rs.msg = "已加载所有数据!"
            }
        }else{
            rs.result = false
            rs.msg = "已加载所有数据!"
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def targetSave(){
        def rs=[:]
        def targetInstance=new Target(params)
        targetInstance.dateCreate=new Date()
        if(!params.img){
            targetInstance.img='add.png'
        }
        targetInstance.issubmit=0
        targetInstance.status=0
        targetInstance.percent=0
        targetInstance.isedit =0
        targetInstance.ischeck =0
        if(!targetInstance.save(flush: true)){
            rs.result=false
            rs.msg="保存失败"

        }else {
            rs.result=true
            rs.msg="保存成功"
            rs.target=targetInstance
            rs.tid=targetInstance.id
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON


    }
    def targetDelete(){
        def rs=[:]
        def id=params.id
        def cid=params.cid
        def targetInstance=Target.findByIdAndCid(id,cid)
        if (!targetInstance) {
            rs.result=false
            rs.msg='删除失败！'
            return
        }else {

            try {
                targetInstance.delete(flush: true)
                rs.result = true
                rs.msg = '删除成功！'
            }
            catch (DataIntegrityViolationException e) {
                rs.result = false
                rs.msg = '删除失败！'
            }
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def targetDetail(){
        def rs=[:]
        def id=params.id
        def cid=params.cid
        def targetInstance=Target.findByIdAndCid(id,cid)
        def sum=0
        if(!targetInstance){
            rs.result=false
            rs.msg="获取数据失败！"
        }else{
            rs.result=true
            rs.target=targetInstance
            def missionlist=targetInstance.mission
            rs.missionlist=missionlist
            for(def m in missionlist){
                sum+=m.percent
            }
            rs.r_per=100-sum
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def targetUpdate(){
        def rs=[:]
        def id=params.id
        def cid=params.cid
        def targetInstance=Target.findByIdAndCid(id,cid)
        if(!targetInstance){
            rs.result=false
            rs.msg="获取数据失败！"
        }else {
            targetInstance.properties = params
            if(!targetInstance.save(flush: true)){
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
    def missionSave(){
        def rs=[:]
        def tid=params.tid
        def targetInstance=Target.get(tid)
        def missionInstance=new Mission(params)
        missionInstance.status=0
        missionInstance.issubmit=0
        missionInstance.hasvisited=0
        missionInstance.dateCreate=new Date()
//        missionInstance.reply=0
        missionInstance.target=targetInstance
        if(!missionInstance.save(flush: true)){
            rs.result=false
            rs.msg="保存失败!"
        }else {
            rs.result=true
            rs.msg="保存成功!"
            rs.mission=missionInstance
            rs.tid=tid
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON


    }
    def missionDelete(){
        def rs=[:]
        def id=params.id
        def missionInstance=Mission.get(id)
        if (!missionInstance) {
            rs.result=false
            rs.msg='删除失败！'

        }else {

            try {
                missionInstance.delete(flush: true)
                rs.result = true
                rs.msg = '删除成功！'
                def tid=missionInstance.target.id
                rs.tid=tid
            }
            catch (DataIntegrityViolationException e) {
                rs.result = false
                rs.msg = '删除失败！'
            }
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def missionShow(){
        def rs=[:]
        def mid=params.mid
        def missionInstance=Mission.findById(mid)
        if(!missionInstance){
            rs.result=false
            rs.msg="获取数据失败！"
        }else{
            rs.result=true
            rs.mission=missionInstance
            rs.replys=ReplyMission.findAllByMission(missionInstance,[sort:'date',order:'desc'])
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def missionUpdate(){
        def rs=[:]
        def id=params.id
        def missionInstance=Mission.get(id)
        if (!missionInstance) {
            rs.result=false
            rs.msg='编辑失败！'

        }else{
            missionInstance.properties=params
            if(!missionInstance.save(flush: true)){
                rs.result=false
                rs.msg="编辑失败！"
            }else{
                rs.result=true
                rs.msg="编辑成功！"
                def tid=missionInstance.target.id
                rs.tid=tid
            }
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def missionComment(){
        def rs=[:]
        def mid=params.mid
        def missionInstance=Mission.get(mid)
        params<<[sort:"date",order: "desc"]
        if(!missionInstance){
            rs.result=false
            rs.msg="获取数据失败！"
        }else {
            def comments =ReplyMission.findAllByMission(missionInstance,params)
            rs.comments=comments
            rs.result=true

        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def commentSave(){
        def rs=[:]
        def mid=params.mid
        def missionInstance=Mission.get(mid)
        if(!missionInstance){
            rs.result=false
            rs.msg="保存失败！"
        }else {
            def replymissionInstance = new ReplyMission(params)
            replymissionInstance.status = 0
            SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
            replymissionInstance.date=time.format(new Date())
//            missionInstance.reply = 1
            replymissionInstance.mission = missionInstance
            if (!replymissionInstance.save(flush: true)) {
                rs.result = false
                rs.msg = "保存失败!"
            } else {
                rs.result = true
                rs.msg = "保存成功!"
                rs.replymission=replymissionInstance

            }
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def join_mission(){
        def rs=[:]
        def uid=params.uid
        params.max = 5
        params<<[sort:"dateCreate",order: "desc"]
        def offset = 0;
        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def joinmissionsize=Mission.countByPlayuidAndIssubmitAndStatus(uid,1,0)
        def offse=params.offset.toInteger()
        if(joinmissionsize>offse) {
            def joinmissionlist = Mission.findAllByPlayuidAndIssubmitAndStatus(uid,1,0, params)
            if(joinmissionlist){
                rs.result=true
                rs.joinmissionlist=joinmissionlist
            }else{
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
    def hasFinishedTarget(){
        def rs=[:]
        def cid=params.cid
        def uid=params.uid

        params.max = 5
        params<<[sort:"dateCreate",order: "desc"]
        def offset = 0;
        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def targetsize=Target.countByFzuidAndCidAndStatus(uid,cid,1)
        def offse=params.offset.toInteger()
        if(targetsize>offse) {
            def targetlist = Target.findAllByFzuidAndCidAndStatus(uid, cid, 1, params)
            if (targetlist) {
                rs.result = true
                rs.targetlist = targetlist
            } else {
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
    def hasFinishedMission(){
        def rs=[:]
        def uid=params.uid
        params.max = 5
        params<<[sort:"dateCreate",order: "desc"]
        def offset = 0;
        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def hasfinishedmissionsize=Mission.countByPlayuidAndStatus(uid,1)
        def offse=params.offset.toInteger()
        if(hasfinishedmissionsize>offse) {
            def hasfinishedmissionlist = Mission.findAllByPlayuidAndStatus(uid, 1, params)
            if(hasfinishedmissionlist){
                rs.result=true
                rs.hasfinishedmissionlist=hasfinishedmissionlist
            }else{
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
    def allTarget(){
        def rs=[:]
        def cid=params.cid
        def uid=params.uid

        params.max = 5
        params<<[sort:"dateCreate",order: "desc"]
        def offset = 0;
        if (params.offset.toInteger()>0){
            offset =params.offset.toInteger()
        }
        params<<[offset:offset]
        def targetsize=Target.countByFzuidAndCid(uid,cid)
        def offse=params.offset.toInteger()
        if(targetsize>offse) {
            def targetlist = Target.findAllByFzuidAndCidAnd(uid, cid, params)
            if (targetlist) {
                rs.result = true
                rs.targetlist = targetlist
            } else {
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
    def unreadComment(){
        def rs=[:]

        def uid=params.uid
        def cid=params.cid
        def replyInfo = []
        params<<[sort:"date",order: "desc"]
            def unreadcomment = ReplyMission.findAllByBpuidAndStatus(uid,0,params)
            if(!unreadcomment){
                rs.result=false
                rs.msg="已加载所有数据！"
            }else {
                for (def i=0;i<unreadcomment.size();i++){
                    def info= [:]
                    def allInfo=unreadcomment.get(i)
                    info.allInfo=allInfo
                    info.plimg = CompanyUser.findById(allInfo.puid).img
                    replyInfo<<info
                }
                rs.replyInfo = replyInfo
                rs.mission=unreadcomment.mission
                rs.result = true
            }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def changeCommentStatus(){
        def rs=[:]
        def mid=params.mid
        def uid=params.uid
        def missionInstance=Mission.get(mid)
        if(!missionInstance){
            rs.result=false
            rs.msg="获取数据失败！"
        }else {
            def unreadcomment = ReplyMission.findAllByMissionAndBpuidAndStatus(missionInstance,uid,0,params)
            if(!unreadcomment){
                rs.result=false
                rs.msg="获取数据失败！"
            }else {
               for(def r in unreadcomment){
                   r.status=1
               }
                rs.result = true
            }
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def sign_mission_hasvisited(){
        def rs=[:]
        def mid=params.mid
        def missionInstance=Mission.get(mid)
        if(!missionInstance){
            rs.result=false
            rs.msg='获取数据失败！'
        }else{
            missionInstance.hasvisited=1
            if(!missionInstance.save(flush: true)){
                rs.result=false
                rs.msg='获取数据失败！'
            }else{
                rs.result=true
                rs.msg='任务已查看！'
            }
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def sign_mission_accepted(){
        def rs=[:]
        def mid=params.mid
        def missionInstance=Mission.get(mid)
        if(!missionInstance){
            rs.result=false
            rs.msg='获取数据失败！'
        }else{
            missionInstance.hasvisited=2
            if(!missionInstance.save(flush: true)){
                rs.result=false
                rs.msg='获取数据失败！'
            }else{
                rs.result=true
                rs.msg='任务已接受！'
            }
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def sign_mission_hasfinished(){
        def rs=[:]
        def mid=params.mid
        def missionInstance=Mission.get(mid)
        if(!missionInstance){
            rs.result=false
            rs.msg='获取数据失败！'
        }else{
            missionInstance.status=1
            missionInstance.target.percent+=missionInstance.percent
            if(!missionInstance.save(flush: true)){
                rs.result=false
                rs.msg='获取数据失败！'
            }else{

                rs.result=true
                rs.msg='任务标记完成！'
            }
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def sign_target_submit(){
        def rs=[:]
        def tid=params.tid
        def targetInstance=Target.get(tid)
        if(!targetInstance){
            rs.result=false
            rs.msg='获取数据失败！'
        }else{
            targetInstance.issubmit=1
            def missionlist=targetInstance.mission
            for(def m in missionlist){
                m.issubmit=1
            }
            if(!targetInstance.save(flush: true)){
                rs.result=false
                rs.msg='获取数据失败！'
            }else{
                rs.result=true
                rs.msg='目标下发成功！'
            }
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
}
