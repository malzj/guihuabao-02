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
        def uname = session.user.name
        def current = new Date()
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd")
        def now = time.format(current)
        def order = [sort:"dateCreate",order: "desc"]
        def targetInstance = Target.findAllByCidAndFzuidAndStatus(cid,uid,0,[max: 4,sort:"dateCreate",order: "desc"])
        def missionInstance = Mission.findAllByPlaynameAndStatus(uname, '0', [max: 3,sort:"dateCreate",order: "desc"])
        def todayTaskInstance = Task.findAllByCidAndPlayuidAndStatusAndBigentimeLessThanEqualsAndOvertimeGreaterThanEquals(cid,uid,0,now,now,order)//今天任务
        def taskInstance = Task.findAllByCidAndPlayuidAndStatusAndOvertimeGreaterThanEquals(cid,uid,0,now,[sort:"overtime",order:"asc"])//即将到期
        def applyInstance = Apply.findAllByApplyuidAndCidAndApplystatuss(uid,cid,1,[max: 3,sort:"dateCreate",order: "desc"])
        def zhoubaoInstance = Zhoubao.findAllByCidAndUid(cid,uid,order)
        //公司公告
        def companyNoticeInstance = CompanyNotice.findAllByCid(cid,order)
        [targetInstance: targetInstance,missionInstance: missionInstance,todayTaskInstance: todayTaskInstance,taskInstance: taskInstance,zhoubaoInstance: zhoubaoInstance,applyInstance: applyInstance,companyNoticeInstance: companyNoticeInstance]
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
//                render(view: "companyUserEdit", model: [companyUserInstance: companyUserInstance])
                redirect(action: "companyUserEdit",id: id)
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
        def affiliatedList=Bumen.findAllByCid(company.id)

        [bumenInstance: new Bumen(params),affiliatedList: affiliatedList]
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
        def affiliatedList=Bumen.findAllByCid(company.id)
        if (!bumenInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'bumen.label', default: 'Bumen'), id])
            redirect(action: "bumenList")
            return
        }

        [bumenInstance: bumenInstance,affiliatedList: affiliatedList]
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
//        if (params.offset>0){
//            offset =params.offset
//        }
        if(params.offset) {
            offset = params.offset.toLong()
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
        def charpterId
        def syllabusInfo
        if(!contentlist&&chapter&&syllabus){

            if(offset>0){ //判断是向前翻页，还是向后翻页
                 //向后翻页 下一页
                charpterId = Chapter.findByIdGreaterThan(chapter.id,[sort: "id",order: "asc"])?.id //向后翻页时获得后一个章节的id
                if(charpterId){
                    redirect(action: "chapterBook",params: [id: charpterId])
                    return
                }else{//如果没有后一章节，则查找后一大纲的第一章节
                    syllabusInfo = Syllabus.findByIdGreaterThanAndBook(syllabus.id,bookInstance,[sort: "id",order: "asc"]) //获得后一个大纲
                    if(syllabusInfo){//如果后一大纲存在，则获取第一章节id
                        charpterId = Chapter.findBySyllabus(syllabusInfo,[sort: "id",order: "asc"])
                        redirect(action: "chapterBook",params: [id: charpterId])
                        return
                    }else{//如果前一大纲不存在，则返回第一页
                        redirect(action: "book",params: [id: id])
                        return
                    }
                }
            }
        }else if(contentlist&&chapter&&syllabus){
            if(offset<0) { //判断是向前翻页，还是向后翻页 上一页
                charpterId = Chapter.findByIdLessThanAndSyllabus(chapter.id, syllabus, [sort: "id", order: "desc"])?.id
                //向前翻页时获得前一个章节的id
                if (charpterId) {
                    redirect(action: "chapterBook", params: [id: charpterId])
                    return
                } else {//如果没有前一章节，则查找前一大纲的最后一章节
                    syllabusInfo = Syllabus.findByIdLessThanAndBook(syllabus.id, bookInstance, [sort: "id", order: "desc"])
                    //获得前一个大纲
                    if (syllabusInfo) {//如果前一大纲存在，则获取最后一章节id
                        charpterId = Chapter.findBySyllabus(syllabusInfo, [sort: "id", order: "desc"])
                        redirect(action: "chapterBook", params: [id: charpterId])
                        return
                    } else {//如果前一大纲不存在，则返回第一页
                        redirect(action: "book", params: [id: id])
                        return
                    }
                }
            }
        }

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
        if (params.offset){
            offset =params.offset.toLong()
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
        def charpterId
        def syllabusInfo

        if(!contentlist&&chapter&&syllabus){

            if(offset>0){ //判断是向前翻页，还是向后翻页
                //向后翻页 下一页
                charpterId = Chapter.findByIdGreaterThan(chapter.id,[sort: "id",order: "asc"])?.id //向后翻页时获得后一个章节的id
                if(charpterId){
                    redirect(action: "chapterBook",params: [id: charpterId])
                    return
                }else{//如果没有后一章节，则查找后一大纲的第一章节
                    syllabusInfo = Syllabus.findByIdGreaterThanAndBook(syllabus.id,bookInstance,[sort: "id",order: "asc"]) //获得后一个大纲
                    if(syllabusInfo){//如果后一大纲存在，则获取第一章节id
                        charpterId = Chapter.findBySyllabus(syllabusInfo,[sort: "id",order: "asc"])
                        redirect(action: "chapterBook",params: [id: charpterId])
                        return
                    }else{//如果前一大纲不存在，则返回第一页
                        redirect(action: "book",params: [id: bookId])
                        return
                    }
                }
            }
        }else if(contentlist&&chapter&&syllabus){
            if(offset<0) { //判断是向前翻页，还是向后翻页 上一页
                offset = 0
                charpterId = Chapter.findByIdLessThanAndSyllabus(chapter.id, syllabus, [sort: "id", order: "desc"])?.id
                //向前翻页时获得前一个章节的id
                if (charpterId) {
                    redirect(action: "chapterBook", params: [id: charpterId])
                    return
                } else {//如果没有前一章节，则查找前一大纲的最后一章节
                    syllabusInfo = Syllabus.findByIdLessThanAndBook(syllabus.id, bookInstance, [sort: "id", order: "desc"])
                    //获得前一个大纲
                    if (syllabusInfo) {//如果前一大纲存在，则获取最后一章节id
                        charpterId = Chapter.findBySyllabus(syllabusInfo, [sort: "id", order: "desc"])
                        redirect(action: "chapterBook", params: [id: charpterId])
                        return
                    } else {//如果前一大纲不存在，则返回第一页
                        redirect(action: "book", params: [id: bookId])
                        return
                    }
                }
            }
        }

        if(contentlist.size()>0){
            content= contentlist.get(0).introduction
            if (contentlist.size()>1){
                content1=contentlist.get(1).introduction
            }
        }
        [bookInstance: bookInstance,content:content,content1:content1,contentsize:contentsize,syllabusInstanceList:syllabusInstanceList,bookId: chapter.id,offset: offset,syllabus:syllabus,chapter:chapter]
    }

    //案例列表
    def hxexample(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        def exampleInstanceList = HexuTool.findAllByStyle(2,params)
        def exampleInstanceTotal = HexuTool.countByStyle(2)
        [exampleInstanceList: exampleInstanceList, exampleInstanceTotal: exampleInstanceTotal]
    }
    //案例内容
    def example(Integer max,Long id){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 1, 100)
        params<<[sort: "id",order: "asc"]
        def offset = 0;
        if (params.offset>0){
            offset =params.offset
        }
        params<<[offset:offset]
        params<<[sort:"id", order:"asc"]
        def hxtool = HexuTool.findByIdAndStyle(id,2)
        def contentlist = ToolContent.findAllByHexutools(hxtool,params)
        def contentsize= ToolContent.countByHexutools(hxtool)
        def content=""

        if(contentlist.size()>0){
            content= contentlist.get(0).introduction
        }
        if(!hxtool){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tool.label', default: 'Tool'), id])
            redirect(action: "hxtools")
            return
        }

        [content:content,contentsize:contentsize,toolId:id,offset: offset]
    }
    //工具列表
    def hxtools(Integer max){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 10, 100)
        def toolInstanceList = HexuTool.findAllByStyle(1,params)
        def toolInstanceTotal = HexuTool.countByStyle(1)
        [toolInstanceList: toolInstanceList, toolInstanceTotal: toolInstanceTotal]
    }
    //工具内容
    def tool(Integer max,Long id){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        params.max = Math.min(max ?: 1, 100)
        params<<[sort: "id",order: "asc"]
        def offset = 0;
        if (params.offset>0){
            offset =params.offset
        }
        params<<[offset:offset]
        params<<[sort:"id", order:"asc"]
        def hxtool = HexuTool.findByIdAndStyle(id,1)
        def contentlist = ToolContent.findAllByHexutools(hxtool,params)
        def contentsize= ToolContent.countByHexutools(hxtool)
        def content=""

        if(contentlist.size()>0){
            content= contentlist.get(0).introduction

        }
        if(!hxtool){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tool.label', default: 'Tool'), id])
            redirect(action: "hxtools")
            return
        }

        [content:content,contentsize:contentsize,toolId:id,offset: offset]
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
    def inform(Integer max){
        params.max = Math.min(max ?: 10, 100)
        def informList = Inform.list(sort: "dateCreate",order: "desc")
        [informList: informList]
    }
    def informShow(Long id){
        def informInstance=Inform.get(id)
        if(!informInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'inform.label', default: 'Inform'), id])
            redirect(action: "inform")
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
        def clauseInstance = Clause.get(id)
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
            def userDir = new File(webRootDir, "/uploadfile/images/")
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
    def reportSave(Long version){
        def myReportInfo
        def myReportInfos
        def rs =[:]
        def a = params
        myReportInfo = Zhoubao.findByUidAndCidAndYearAndMonthAndWeek(params.uid,params.cid,params.year.toString(),params.month.toString(),params.week.toString())
        if (!myReportInfo) {
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
            if (version != null) {
                if (myReportInfo.version > version) {
                    rs.result = false
                    rs.msg = "保存失败"
                }else{
                    myReportInfo.properties = params
                    if (myReportInfo.save(flush: true)) {
                        rs.result = true
                        rs.msg = "保存成功"
                    }else{
                        rs.result = false
                        rs.msg = "保存失败"
                    }
                }
            }
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
    //下属报告(删)
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
    /*
    * 下属部门及人员列表
    * 参数bid，cid
    * */
    def reportSubordinate(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def bid = (params.bid)?params.bid:session.user.bid
        def cid = (params.cid)?params.cid:session.user.cid
        def unfirst =(params.bid)?true:false
        def bumenList
        def companyUserList
        bumenList = Bumen.findAllByAffiliatedAndCid(bid,cid)
        companyUserList=CompanyUser.findAllByCidAndBid(cid,bid)

        [bumenList: bumenList,companyUserList: companyUserList,unfirst: unfirst]
    }
//    (删)
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

        [replyInstance: replyInstance,allReplyInfo: allReplyInfo,zhoubao: zhoubao,count: count]
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
        def companyuserList= CompanyUser.findAllByCidAndPidLessThan(companyId,3,[sort: "pid",order: "asc"])
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
        if(params.approvaluid) {
            applyInstance.approvalusername = CompanyUser.get(params.approvaluid).name
        }
        def a = params.copyuid
        if(params.copyuid) {
            applyInstance.copyname = CompanyUser.get(params.copyuid).name
        }
        applyInstance.status="未审核"
        Date currentTime = new Date();
//        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//        String dateString = formatter.format(currentTime);
        applyInstance.dateCreate=currentTime
        applyInstance.applystatus=0
        applyInstance.applystatuss=1
        applyInstance.copyremind=0
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
        if(params.approvaluid) {
            applyInstance.approvalusername = CompanyUser.get(params.approvaluid).name
        }
        if(params.copyuid) {
            applyInstance.copyname = CompanyUser.get(params.copyuid).name
        }
        applyInstance.status="未审核"
        Date currentTime = new Date();
//        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//        String dateString = formatter.format(currentTime);
        applyInstance.dateCreate=currentTime
        applyInstance.applystatus=0
        applyInstance.applystatuss=0
        applyInstance.copyremind=0
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

        if(applyInstance){//判断信息是否为空
            rs.msg=true
            if(params.approvaluid) {
                applyInstance.approvalusername = CompanyUser.get(params.approvaluid).name
            }

            if(params.copyuid) {
                applyInstance.copyname = CompanyUser.get(params.copyuid).name
            }
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
        def companyuserList= CompanyUser.findAllByCidAndPidLessThan(companyId,3,[sort: "pid",order: "asc"])
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
    //申请删除
    def napplyDelete(Long id){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def applyInstance = Apply.get(id)
        if (!applyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'apply.label', default: 'Apply'), id])
            redirect(action: "apply")
            return
        }

        try {
            applyInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'apply.label', default: 'Apply'), id])
            redirect(action: "apply")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'apply.label', default: 'Apply'), id])
            redirect(action: "apply", id: id)
        }
    }
    //抄送我的
    def copyToMe(Integer max){
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

        [applylist:applylist,applyInstanceTotal:applyInstanceTotal,companyuserList:companyuserList]
    }
    //抄送提醒修改
    def copyRemindUpdate(){
        def rs = [:]
        def id = params.id
        def companyId = session.company.id
        def version = params.version.toInteger()
        def applyInstance = Apply.findByIdAndCid(id,companyId)
        if(!applyInstance){
            rs.msg=false
        }else{
            rs.msg=true

            applyInstance.copyremind = 0

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
            applyInstanceTotal= Apply.countByApprovaluidAndCidAndApplystatuss(userId,companyId,1)
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
                applyInstance.copyremind=1
            } else if(applystatus=="2"){
                applyInstance.applystatus = 2
                applyInstance.status = "未通过"
                applyInstance.remindstatus = 1
                applyInstance.copyremind=0
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
    //任务信息修改
    def taskInfoUpdate(Long id, Long version){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def taskInfoInstance = Task.get(id)

        if (!taskInfoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
            redirect(action: "fzTask")
            return
        }

        if (version != null) {
            if (taskInfoInstance.version > version) {
                taskInfoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'task.label', default: 'Task')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "fzTask", model: [companyUserInstance: taskInfoInstance])
                return
            }
        }

        taskInfoInstance.properties = params
        def overdate = params.overtime.split(" ")
        def uid = session.user.id
        taskInfoInstance.cid = session.company.id
        taskInfoInstance.fzuid = uid
        taskInfoInstance.fzname = session.user.name
        taskInfoInstance.overtime = overdate[0]
        taskInfoInstance.overhour = overdate[1]
        taskInfoInstance.status = 0
        if(params.playuid==uid.toString()){
            taskInfoInstance.lookstatus = 2
        }
        taskInfoInstance.remindstatus = 0

        taskInfoInstance.dateCreate = new Date()

        if (!taskInfoInstance.save(flush: true)) {
            render(view: "fzTask", model: [companyUserInstance: taskInfoInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'task.label', default: 'Task'), taskInfoInstance.id])
        redirect(action: "fzTask")
    }
    //任务状态修改
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

        def bumenInstance = Bumen.findAllByCid(session.company.id)

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
        [fzTaskInstance: fzTaskInstance,fzTaskInstanceTotal: fzTaskInstanceTotal,bumenInstance: bumenInstance,selected: selected,infos: infos]
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

    //下属任务(删)
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
        def companyUserList
        if(upid==1){
            bumenInfo = Bumen.findAllByCid(ucid)
            companyUserList=CompanyUser.findAllByCidAndBid(company.id,0)
            render(view: "taskBumenList", model: [bumenInfo: bumenInfo,companyUserList: companyUserList])
        }else if(upid==2){
            redirect(action: "taskUserList",params: [bid: ubid,cid: ucid])
            return
        }
    }

    /*
    * 下属部门及人员列表
    * 参数bid，cid
    * */
    def taskSubordinate(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def bid = (params.bid)?params.bid:session.user.bid
        def cid = (params.cid)?params.cid:session.user.cid
        def unfirst =(params.bid)?true:false
        def bumenList
        def companyUserList
        bumenList = Bumen.findAllByAffiliatedAndCid(bid,cid)
        companyUserList=CompanyUser.findAllByCidAndBid(cid,bid)

        [bumenList: bumenList,companyUserList: companyUserList,unfirst: unfirst]
    }
//    (删)
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

    def companyNoticeShow(Long id){
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
        def rs=[:]
        def msg
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def targetInstance = new Target(params)
        targetInstance.cid = session.company.id

        targetInstance.status = '0'
        targetInstance.percent = 0
        targetInstance.issubmit = '0'
        targetInstance.isedit = '0'
        targetInstance.ischeck ='0'
        targetInstance.dateCreate = new Date()
        if(!params.img){
            targetInstance.img='add.png'
        }


        if (!targetInstance.save(flush: true)) {
            render(model: [targetInstance: targetInstance])
            msg=false
            return
        }else{
             msg=true
        }


        flash.message = message(code: 'default.created.message', args: [message(code: 'target.label', default: 'Target'), targetInstance.id])
        redirect(action: "user_target",params:[id: targetInstance.id,msg:msg])

    }
    //目标保存并分解
    def targetSaveAndSplit() {
        def rs = [:]
        def targetInstance = new Target(params)
        targetInstance.cid = session.company.id

        targetInstance.status = '0'
        targetInstance.ischeck='0'
        targetInstance.percent = 0
        targetInstance.issubmit = '0'
        targetInstance.isedit = '0'
        targetInstance.ischeck ='0'
        targetInstance.dateCreate = new Date()
        if(!params.img){
            targetInstance.img='add.png'
        }

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
    def targetDelete() {
        def rs=[:]
        def tid=params.target_id

        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def targetInstance = Target.get(tid)
        if (!targetInstance) {
           rs.msg=false
            println('a')
           return
        }

            try {

                targetInstance.delete()

                rs.msg=true
                println('b')
            }
            catch (DataIntegrityViolationException e) {
                rs.msg = false

            }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
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
//        def bumenPerson=CompanyUser.findAllByBidAndCid(user.bid,cid);
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
            params<<[sort:"dateCreate",order: "desc"]
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
            params<<[sort:"dateCreate",order: "desc"]
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
        def uid=session.user.id
        mission.status='0'
        if(mission.playuid.toLong()==uid){
            mission.hasvisited=2
        }else {
            mission.hasvisited = '0'
        }
        mission.issubmit='0'

        def targetInstance = Target.get(params.target_id)
        if(targetInstance.issubmit=='1'){
            mission.issubmit='1'
        }
        if(mission.playuid==uid){
            mission.hasvisited=2
        }

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
           rs.msg=true
           mission.hasvisited=2
           if(!mission.save()){
               rs.msg=false
           }else {
               def target = mission.target
               def missionlist = target.mission
               def size=missionlist.size()
                def sum1=0
               def sum = 0
               for (def m in missionlist) {
                   sum1+=m.percent.toInteger()
                   if (m.hasvisited =='2') {

                       sum += 1
                   }
               }

               if (sum == size&&sum1==100) {
                   target.isedit = 1
               }
           }
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
    def ischeck(){
        def rs = [:]
        def tid = params.target_id
        def targetInstance = Target.get(tid)
        if(!targetInstance){
            rs.msg=false
        }else {
            def fzname = com.guihuabao.CompanyUser.findById(targetInstance.fzuid).name
            targetInstance.ischeck=1
            if(!targetInstance.save(flush: true)){
                rs.msg=false
            }else {
                rs.msg=true
                rs.target = targetInstance
                rs.mission = targetInstance.mission
                rs.fzname = fzname
            }
        }
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
        println(targetInstance.percent)
        try {
            missionInstance.delete(flush: true)
            if(missionInstance.status=='1') {
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
        def uid=session.user.id
        def mission = Mission.get(mid)
        def target = mission.target

        if(mission.status=='0') {
            mission.properties = params
            if(mission.playuid==uid){
                mission.hasvisited=2
            }
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
            target.status = 1
        }else{
            target.status = 0
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
        def uid=session.user.id
        def cid=session.company.id
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

        def messageTaskInstance = Task.findAllByCidAndPlayuidAndOvertimeAndOverhourLessThanEqualsAndOverhourGreaterThanEqualsAndLookstatusAndStatus(cid, uid, nowday, endtime, nowtime, 2, 0,params)
        def messageTaskInstanceTotal = Task.countByCidAndPlayuidAndOvertimeAndOverhourLessThanEqualsAndOverhourGreaterThanEqualsAndLookstatusAndStatus(cid,uid,nowday,endtime,nowtime,2,0)
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
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
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
        def playuid = session.user.id

        def selected = params.selected
//        def order1 = [sort: "overtime", order: "desc"]
//        def order2 = [sort: "dateCreate", order: "desc"]
        def missionInstance
        def missionInstanceTotal
        if (selected == "1") {
            params<<[sort:"overtime",order: "desc"]
            missionInstance = Mission.findAllByPlayuidAndStatus(playuid,'0' , params)
            missionInstanceTotal = Mission.countByPlayuidAndStatus(playuid, 0)
        } else if (selected == "2") {
            params<<[sort:"dateCreate",order: "desc"]
            missionInstance = Mission.findAllByPlayuidAndStatus(playuid, 0, params)
            missionInstanceTotal = Mission.countByPlayuidAndStatus(playuid, 0)
        } else {
            params<<[sort:"dateCreate",order: "desc"]
            missionInstance = Mission.findAllByPlayuidAndStatus( playuid, '0', params)
            missionInstanceTotal = Mission.countByPlayuidAndStatus( playuid, 0)
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
            if(mission.hasvisited!='2') {
                mission.hasvisited = '1'
            }
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
    //下属目标(删)
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
    /*
    * 目标下属部门及人员列表
    * 参数bid，cid
    * */
    def targetSubordinate(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def bid = (params.bid)?params.bid:session.user.bid
        def cid = (params.cid)?params.cid:session.user.cid
        def unfirst =(params.bid)?true:false
        def bumenList
        def companyUserList
        bumenList = Bumen.findAllByAffiliatedAndCid(bid,cid)
        companyUserList=CompanyUser.findAllByCidAndBid(cid,bid)

        [bumenList: bumenList,companyUserList: companyUserList,unfirst: unfirst]
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
            targetInstance = Target.findAllByCidAndFzuidAndStatus(cid, fzuid, 0, params,order2)
            targetInstanceTotal = Target.countByCidAndFzuidAndStatus(cid, fzuid, 0)
        }
        [targetInstance: targetInstance, targetInstanceTotal: targetInstanceTotal, bumenInstance: bumenInstance,uid:fzuid,cid:cid, selected: selected]
    }
//    用户列表(删)
    def targetUserList() {
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
        def playuid = session.user.id

        def selected = params.selected
//        def order1 = [sort: "overtime", order: "desc"]
//        def order2 = [sort: "dateCreate", order: "desc"]
        def missionInstance
        def missionInstanceTotal
        if (selected == "1") {
            params<<[sort:"overtime",order: "desc"]
            missionInstance = Mission.findAllByPlayuidAndStatus(playuid,'1' , params)
            missionInstanceTotal = Mission.countByPlayuidAndStatus(playuid, '1')
        } else if (selected == "2") {
            params<<[sort:"dateCreate",order: "desc"]
            missionInstance = Mission.findAllByPlayuidAndStatus(playuid, '1', params)
            missionInstanceTotal = Mission.countByPlayuidAndStatus(playuid, '1')
        } else {
            missionInstance = Mission.findAllByPlayuidAndStatus( playuid, '1', params)
            missionInstanceTotal = Mission.countByPlayuidAndStatus( playuid, '1')
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
            if(target.percent==100){
                target.status=1
            }else{
                target.status=0
            }
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

        replyMissionInstance.mission = missionInstance
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        replyMissionInstance.date =time.format(new Date())
        replyMissionInstance.cid = session.company.id
        replyMissionInstance.status = 0
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
    def unread_comment(Long id){
        def user = session.user
        def company = session.company

        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def uid=user.id
        def cid=company.id
        def bpuname=user.name
        def replymission


        replymission=ReplyMission.findAllByBpunameAndStatus(bpuname,0,[sort:"date",order: "desc"])
        def count=replymission?.size()
        def mission
        if (!id&&count!=0 ) {
            mission = replymission[0].mission
        }else if (!id && count == 0) {

        }else {
            mission = Mission.get(id)
        }
        def allReplyInfo = ReplyMission.findAllByMission(mission, [sort: "date", order: "desc"])
        def myReplyInfo = ReplyMission.findAllByMissionAndCidAndBpuid(mission, cid, uid, [sort: "date", order: "desc"])
        for(def i=0;i<myReplyInfo.size();i++){
            myReplyInfo[i].status=1
        }
        [replymissionlist:replymission,allReplyInfo: allReplyInfo,mission:mission]
    }
    def unreadMissionReply(Long id) {
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def uid = session.user.id
        def cid = session.company.id
        def mission
        def i
        def replyInstance = ReplyMission.findAllByBpuidAndCidAndStatus(uid, cid, 0, [sort: "date", order: "desc"])
        def count = replyInstance?.size()
        if (!id && count != 0) {
            mission = replyInstance[0].mission
        } else if (!id && count == 0) {

        } else {
            mission = Mission.get(id)
        }
        def allReplyInfo = ReplyMission.findAllByMissionAndCid(mission, cid, [sort: "date", order: "desc"])
        def myReplyInfo = ReplyMission.findAllByMissionAndCidAndBpuid(mission, cid, uid, [sort: "date", order: "desc"])
        for (i = 0; i < myReplyInfo.size(); i++) {
            myReplyInfo[i].status = 1
        }

        [replyInstance: replyInstance, allReplyInfo: allReplyInfo, count: count]
    }
    def tReplyMissionSave(Long id){

        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        def replyMissionInstance = new ReplyMission(params)

        def missionInstance = Mission.get(id)

        replyMissionInstance.mission = missionInstance
        replyMissionInstance.date = time.format(new Date());
        replyMissionInstance.status = 0
        if (!replyMissionInstance.save(flush: true)) {
            render(view: "unread_comment", model: [id: id])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'mission.label', default: 'Mission'), missionInstance.id])
        redirect(action: "unread_comment", id: id)
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
            def userDir = new File(webRootDir, "uploadfile/target-img/")
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

    def show_app(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def uid=session.user.id
        def cid=session.user.cid
        def showapps=ShowApp.findAllByUidAndCid(uid,cid,[sort:'num',order:'asc'])

        def companyAppList=CompanyApps.findAllByCid(cid,[sort:'buydate',order:'desc'])
        [companyAppList:companyAppList,showapps:showapps]
    }
    def addApp(){
        def rs=[:]
        def user=session.user
        def company=session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def aid=params.aid
        def cid=session.user.cid
        def uid=session.user.id
        def companyapp=CompanyApps.findById(aid)
        def showapps=ShowApp.findAllByUidAndCid(uid,cid,[sort:'num',order:'asc'])
         if(!companyapp){
            rs.result=false
            rs.msg='获取数据失败！'
        }else {
             def hasshowapp = ShowApp.findByUidAndCidAndCompanyApp(uid, cid, companyapp)
             if (hasshowapp) {
                 rs.result = false
                 rs.msg = '已经显示该应用！'
             } else {
                 def showappsize = showapps.size()
                 println(showappsize)
//                 companyapp.showApp
                 def showapp = new ShowApp(params)
                 showapp.buydate = new Date()
                 showapp.cid = companyapp.cid
                 showapp.enddate = companyapp.enddate
                 showapp.img = companyapp.img
                 showapp.name = companyapp.name
                 showapp.uid = uid
//                 showapp.appurl = companyapp.appurl
                 if(showappsize==0){
                     showapp.num =1
                 }else {
                     def show = showapps.get(showappsize-1)
                     println(show.num)
                     showapp.num = show.num + 1
                 }
                 showapp.companyApp = companyapp
                 if (!showapp.save(flush: true)) {
                     rs.result = false
                     rs.msg = '添加失败！'
                 } else {
                     rs.result = true
                     rs.msg = '添加成功！'

                 }
             }
         }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def upApp(){
        def rs=[:]
        def user=session.user
        def company=session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def showappInstance=ShowApp.get(params.aid)
        if(!showappInstance){
            rs.result=false
            rs.msg='获取数据失败1！'
        }else{
            if(showappInstance.num==1){
                rs.result=false
                rs.msg='该app已经排在第一位了！'
            }else{
                def num1=showappInstance.num-1
                def showapp1=ShowApp.findByUidAndCidAndNum(user.id,company.id,num1)
                showappInstance.num-=1
                showapp1.num+=1
                if(!showappInstance.save(flush: true)&&!showapp1.save(flash:true)){
                    rs.result=false
                    rs.msg='向上调整失败！'
                }else{
                    rs.result=true
                    rs.msg='向上调整成功！'
                }
            }
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def downApp(){
        def rs=[:]
        def user=session.user
        def company=session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def showappInstance=ShowApp.get(params.aid)
        def showapps=ShowApp.findAllByUidAndCid(user.id,company.id)
        if(!showappInstance){
            rs.result=false
            rs.msg='获取数据失败1！'
        }else{
            if(showappInstance.num==showapps.size()){
                rs.result=false
                rs.msg='该app已经排在最后一位了！'
            }else{
                def num1=showappInstance.num+1
                def showapp1=ShowApp.findByUidAndCidAndNum(user.id,company.id,num1)
                showappInstance.num+=1
                showapp1.num-=1
                if(!showappInstance.save(flush: true)&&!showapp1.save(flash:true)){
                    rs.result=false
                    rs.msg='向上调整失败！'
                }else{
                    rs.result=true
                    rs.msg='向上调整成功！'
                }
            }
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def deleteApp(){
        def rs=[:]
        def user=session.user
        def company=session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def showapps=ShowApp.findAllByUidAndCid(user.id,company.id)
        def showappInstance=ShowApp.get(params.aid)
        if(!showappInstance){
            rs.result=false
            rs.msg='获取数据失败1！'
        }else{

            def bshowapps=ShowApp.findAllByUidAndCidAndNumGreaterThan(user.id,company.id,showappInstance.num)
            try {
                if(showappInstance.num==showapps.size()){
                    showappInstance.delete(flush: true)
                }else {
                    for (def b in bshowapps) {
                        b.num -= 1
                        b.save(flush: true)
                    }
                    showappInstance.delete(flush: true)
                }

                rs.result= true
                rs.msg='删除成功！'
            }
            catch (DataIntegrityViolationException e) {
                rs.result = false
                rs.msg='删除异常！'
            }


        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def companyBumen(){
        def user=session.user
        def company=session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
    }
//    公司架构
    def companyStructure(){
        def rs=[:]
        def company=session.company

        def cid=company.id
        def bumenList=findBumen(0,cid)
        rs.bumenList=bumenList

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON

    }
    /*
    * 递归查询部门
    * */
    def findBumen(Long subordinateId,Long cid){
        def subordinateList=[];
        def bumenList=Bumen.findAllByAffiliatedAndCid(subordinateId,cid)
        if(bumenList){
            for(def bumenInfo in bumenList){
                def arr=[:]
                def subordinate=findBumen(bumenInfo.id,cid)
                arr.id=bumenInfo.id
                arr.name=bumenInfo.name
                arr.cid=bumenInfo.cid
                arr.subordinate=subordinate
                subordinateList<<arr
            }
            return subordinateList
        }else{
            return false
        }
    }
//    部门成员
    def bumenMemberList(){
        def rs=[:]
        def bumenId=params.id
        def cid=params.cid
        def bumenMemberList=CompanyUser.findAllByCidAndBid(cid,bumenId,[sort: 'pid',order: 'asc'])
        if(bumenMemberList){
            rs.result=true
            rs.bumenMemberList=bumenMemberList
        }else{
            rs.result=false
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
//    部门信息
    def bumenInfo(){
        def rs=[:]
        def bumenId=params.id
        def cid=params.cid
        def bumenInfo=Bumen.findByCidAndId(cid,bumenId)
        if(bumenInfo){
            rs.result=true
            rs.bumenInfo=bumenInfo
        }else{
            rs.result=false
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
//  规划
    def programme(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def doneTest=DonePaper.findByCidAndUid(company.id,user.id)
        if(doneTest){
            redirect(action: "startProgramme")
            return
        }
        redirect(action: "programmeModule")
    }
    def startProgramme(){

    }
    def programmeModule(){

    }
//    测试
    /*
    * 测试试卷
    * 测试试卷id为1（手动定义）
    * */
    def testPaper(){
        def testPaperId=1

        [testPaperId:testPaperId]
    }

    /*
    * 字符串拼接
    * 参数 arr (要转换成字符串的数组)
    * */
    def strImplode(ArrayList arr){
        StringBuilder str = new StringBuilder();
        int offset = arr.size() - 1;
        for( int i = 0; i < offset; i++ )
        {
            str.append(arr[i]).append("|||||");
        }
        str.append(arr[offset]);
        return  str.toString();
    }

     /*
    * 测试结果
    * 保存所做题目及结果分数
    * */
    def testEvaluate(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
//        def doneTest=DonePaper.findByCidAndUid(company.id,user.id)
//        if(doneTest){
//            redirect(action: "startProgramme")
//            return
//        }
        def testPaperId=params.testPaperId
        def testPaperInstance=TestPaper.findById(testPaperId)
        def questionInstancList=Questions.findAllByTestPapers(testPaperInstance)
        def totalScore=0
        for(def info in questionInstancList){
            //实例化用户评测表
            def userEvaluate=new Evaluate()
            userEvaluate.cid=company.id
            userEvaluate.uid=user.id
            userEvaluate.testPaperId=testPaperInstance.id
            userEvaluate.questionId=info.id
            userEvaluate.type=info.type
            def formInfo=params.list("infos["+info.id+"]")
            if(info.type==1){
                if(info.id==54){
                    userEvaluate.letters=formInfo.get(0)+','+params["infos[54].area"]
                }else{
                    userEvaluate.letters=formInfo.get(0)
                }
                //计算分数
                def result=Options.findByQuestionsAndLetter(info,formInfo.get(0))
                if(info.id!=24) {
                    if(result){
                        totalScore += result.score
                    }else{
                        totalScore += 3
                    }
                }
            }else if(info.type==2) {
                def count = formInfo.size()
                if (info.id == 31) {
                    if (count == 1) {
                        totalScore += 1
                    } else if (count >= 2 && count <= 4) {
                        totalScore += 2
                    } else if (count > 4) {
                        totalScore += 3
                    }
                }
                if (info.id == 39) {
                    if (count == 1) {
                        totalScore += 0
                    } else if (count==2) {
                        totalScore += 1
                    } else if (count > 2 && count <= 4) {
                        totalScore += 2
                    } else if (count > 4) {
                        totalScore += 3
                    }
                }
            }else if(info.type==3){
                userEvaluate.letters=formInfo
                //计算分数
                if(info.id==30||info.id==40||info.id==41){
                    if(formInfo.get(0)){
                        totalScore+=3
                    }
                }else if(info.id==32){
                    totalScore+=4
                }else if(info.id==33){
                    def sj=Float.parseFloat(formInfo.get(0))
                    if(sj<0){
                        totalScore+=-1
                    }else{
                        def bs=Math.ceil(sj/Float.parseFloat(params['infos[32]']))
                        if(bs<=1){
                            totalScore+=2
                        }else if(bs>1&&bs<=3){
                            totalScore+=3
                        }else{
                            totalScore+=4
                        }
                    }
                }else if(info.id==34){
                    def sj=Float.parseFloat(formInfo.get(0))
                    def bs=Math.ceil(sj/Float.parseFloat(params['infos[32]']))
                    if(bs<=1){
                        totalScore+=1
                    }else if(bs>1&&bs<=2){
                        totalScore+=2
                    }else if(bs>2&&bs<=5){
                        totalScore+=3
                    }else if(bs>5){
                        totalScore+=4
                    }
                }else if(info.id==35||info.id==36){
                    totalScore+=4
                }else if(info.id==48){
                    def yye=formInfo.get(0)
                    yye=  Float.parseFloat(yye)
                    if(yye>3){
                        totalScore+=4
                    }else if(yye<=3&&yye>1.5){
                        totalScore+=3
                    }else if(yye>1&&yye<=1.5){
                        totalScore+=2
                    }else if(yye>0.5&&yye<=1){
                        totalScore+=1
                    }else if(yye<=0.5){
                        totalScore+=0.5
                    }
                }else if(info.id==49){
                    def mlr=Float.parseFloat(formInfo.get(0))
                    if(mlr>60){
                        totalScore+=4
                    }else if(mlr>50&&mlr<=60){
                        totalScore+=3
                    }else if(mlr>40&&mlr<=50){
                        totalScore+=2
                    }else if(mlr<=40){
                        totalScore+=1
                    }
                }else if(info.id==50){
                    def jlr=Float.parseFloat(formInfo.get(0))
                    if(jlr>20){
                        totalScore+=4
                    }else if(jlr>15&&jlr<=20){
                        totalScore+=3
                    }else if(jlr>10&&jlr<=15){
                        totalScore+=2
                    }else if(jlr<=10){
                        totalScore+=1
                    }
                }else if(info.id==51){
                    def dc=Float.parseFloat(formInfo.get(0))
                    if(dc>300){
                        totalScore+=4
                    }else if(dc>200&&dc<=300){
                        totalScore+=3
                    }else if(dc>100&&dc<=200){
                        totalScore+=2
                    }else if(dc<=100){
                        totalScore+=1
                    }
                }
            }
            //保存评测结果
            userEvaluate.save(flush: true)
        }
        def userDoneTest=new DonePaper()
        userDoneTest.cid=company.id
        userDoneTest.uid=user.id
        userDoneTest.paperId=testPaperInstance.id
        userDoneTest.totalScore=totalScore
        userDoneTest.dateCreate= new Date()
        if (!userDoneTest.save(flush: true)) {
            redirect(action: "programme")
            return
        }
        redirect(action: "testResult")
    }
    /*
    * 测试结果展示页面
    * */
    def testResult(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def doneTest=DonePaper.findByCidAndUid(company.id,user.id)
        [doneTest:doneTest]
    }
//    组织架构
    def framework(){
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def tradeInstance=Evaluate.findByTestPaperIdAndQuestionIdAndCidAndUid(1,24,company.id,user.id)
        if(!tradeInstance){
            redirect(action: 'testPaper', params: [msg: "您还没有完成规划测试！"])
            return
        }
        def frameworkImgList=FrameworkImg.findAllByTrade(tradeInstance.letters)
        if(!frameworkImgList){
            frameworkImgList=FrameworkImg.findAllByTrade('F')
        }
        [frameworkImgList:frameworkImgList]
    }
    /*
    * 选择架构部门
    * */
    def selectDepartment(){
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def selectDepartmentList=SelectDepartment.findAllByCidAndUid(company.id,user.id)
        if(selectDepartmentList){
            redirect(action: 'selectDepartmentEdit')
            return
        }
        def frameworkDepartmentList=FrameworkDepartment.findAll();
        [frameworkDepartmentList:frameworkDepartmentList]
    }
    /*
    * 编辑架构部门
    * */
    def selectDepartmentEdit(){
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def selectDepartmentList=SelectDepartment.findAllByCidAndUid(company.id,user.id)
        def sql=''
        for(def i=0;i<selectDepartmentList.size();i++){
            if(i==0){
                sql+=selectDepartmentList.get(i).departmentId
            }else{
                sql+=','+selectDepartmentList.get(i).departmentId
            }
        }
        def frameworkDepartmentList=FrameworkDepartment.findAll("from FrameworkDepartment as b where b.id not in("+sql+")");
        [frameworkDepartmentList:frameworkDepartmentList,selectDepartmentList:selectDepartmentList]
    }
    /*
    * 获取部门信息
    * */
    def ajaxDepartment(){
        def rs=[:]
        def departmentId=params.id
        def frameworkDepartmentInstance=FrameworkDepartment.get(departmentId);
        if(frameworkDepartmentInstance){
            rs.result=true
            rs.frameworkDepartmentInstance=frameworkDepartmentInstance
        }else{
            rs.result=false
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    /*
    * 保存架构部门
    * */
    def selectDepartmentSave(){
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def paramsIdInfo=params.list('id');
        def paramsNameInfo=params.list('name');
        def paramsNumInfo=params.list('num');
        for(def i=0;i<paramsIdInfo.size();i++){
            def selectDepartmentInstance=new SelectDepartment()
            selectDepartmentInstance.departmentId=Integer.parseInt(paramsIdInfo.get(i))
            selectDepartmentInstance.cid=company.id
            selectDepartmentInstance.uid=user.id
            selectDepartmentInstance.name=paramsNameInfo.get(i)
            selectDepartmentInstance.num=Integer.parseInt(paramsNumInfo.get(i))
            selectDepartmentInstance.save(flush: true)
        }
        redirect(action: "frameworkShow")
    }
    def frameworkShow(){
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def departmentInstance=[]
        def cid=company.id
        def uid=user.id
        def selectDepartmentInstance=SelectDepartment.findAllByCidAndUid(cid,uid,[sort: 'num',order: 'asc'])
        for(def i=0;i<selectDepartmentInstance.size();i++){
            def data=[:]
            data.id=selectDepartmentInstance.get(i).id
            data.name=selectDepartmentInstance.get(i).name
            data.jobs=FrameworkDepartment.findById(selectDepartmentInstance.get(i).departmentId).jobs.split(',')
            departmentInstance<<data
        }
        def a= departmentInstance
        [departmentInstance:departmentInstance]
    }
    /*
    * 更新架构部门
    * */
    def selectDepartmentUpdate(){
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def paramsIdInfo=params.list('id');
        def paramsNameInfo=params.list('name');
        def paramsNumInfo=params.list('num');
        for(def i=0;i<paramsIdInfo.size();i++){
            def selectDepartmentInstance=SelectDepartment.findBy()
            selectDepartmentInstance.departmentId=Integer.parseInt(paramsIdInfo.get(i))
            selectDepartmentInstance.cid=company.id
            selectDepartmentInstance.uid=user.id
            selectDepartmentInstance.name=paramsNameInfo.get(i)
            selectDepartmentInstance.num=Integer.parseInt(paramsNumInfo.get(i))
            selectDepartmentInstance.save(flush: true)
        }
        redirect(action: "frameworkShow")
    }
//    目标规划选时间
    def choose_date(){
        def user = session.user
        def company = session.company
        if(!user&&!company){
            redirect (action: index(),params: [msg:  "登陆已过期，请重新登陆"])
            return
        }
        def uid=user.id
        def cid=user.cid
        def isupdate=params.isupdate

        def guimoInstance=Guimo.findByCidAndUid(cid,uid)
        if(!guimoInstance){
            guimoInstance=new Guimo()
            guimoInstance.uid=uid
            guimoInstance.cid=cid
            if (!guimoInstance.save(flush: true)) {
                render(view: "choose_date" , params: [msg: "获取数据失败"])
                return
            }
        }
        [guimoInstance:guimoInstance,isupdate:isupdate]

    }
    def guimo_target() {
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def id=params.id
        def isupdate=params.isupdate
        def guimoInstance=Guimo.findById(id)


        if(!guimoInstance){
            render(view: "choose_date" , params: [msg: "获取数据失败"])
            return
        }

     [guimoInstance:guimoInstance,isupdate: isupdate]
    }
    def guimoAjax(){
        def rs=[:]
//        def user = session.user
//        def company = session.company
//        def uid=user.id
//        def cid=company.id
        def begintime=params.begintime
        def endtime=params.endtime
        def id=params.id
        def guimoInstance=Guimo.findByIdAndBegintimeAndEndtime(id,begintime,endtime)
        if(!guimoInstance){
            rs.result=false
            rs.msg='获取数据失败！'
        }else{
            rs.result=true
            rs.guimoInstance=guimoInstance
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }

    def guimoUpdate(){
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def isupdate=0
        def id=params.id
        def sign=params.sign
        def isu=params.isupdate
        def guimoInstance=Guimo.get(id)
        def begintime=guimoInstance.begintime
        def endtime=guimoInstance.endtime
        guimoInstance.properties=params

            if(sign=='choose_date'){
                if (!guimoInstance.save(flush: true)) {
                    render(view: "choose_date", params: [msg: "保存失败！"])
                    return
                }else{
                    def begintime1=guimoInstance.begintime
                    def endtime1=guimoInstance.endtime
                    if(begintime!=begintime1||endtime!=endtime1||isu=='1'){
                        isupdate=1
                    }
                    redirect(action: "guimo_target", params: [id:id,isupdate:isupdate])
                }
            }else {
                if (!guimoInstance.save(flush: true)) {
                    render(view: "guimo_target", params: [msg: "保存失败！",guimoInstance:guimoInstance,id:id,isupdate:isupdate])
                    return
                }else{
                    def isup=params.isupdate
                    if(isup=='1'){
                        isupdate=1
                    }
                    redirect(action: "caiwu_target", params: [begintime:guimoInstance.begintime,endtime:guimoInstance.endtime,id:guimoInstance.id,isupdate:isupdate])
                }
            }


        }




    def caiwu_target(){
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def guimoId=params.id
        def isupdate=params.isupdate
        def uid=user.id
        def cid=company.id
        def begintime=params.begintime
        def endtime=params.endtime

            def caiwuInstance=Caiwu.findByUidAndCidAndBegintimeAndEndtime(user.id,company.id,begintime,endtime)
            if(!caiwuInstance) {
                 caiwuInstance = new Caiwu()
                caiwuInstance.uid = user.id
                caiwuInstance.cid = company.id
                caiwuInstance.begintime = begintime
                caiwuInstance.endtime = endtime
                if (!caiwuInstance.save(flush: true)) {
                    render(view: "guimo_target", params: [msg: "保存失败！"])
                    return
                }
            }
            [caiwuInstance:caiwuInstance,guimoId:guimoId,isupdate:isupdate]
        }

    def caiwuUpdate(){
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def id=params.id
        def caiwuInstance=Caiwu.findById(id)
        if(!caiwuInstance){
            render(view: "caiwu_target", params: [msg: "获取数据失败！",id:id])
            return
        }else{
            caiwuInstance.properties=params
            if (!caiwuInstance.save(flush: true)) {
                render(view: "caiwu_target", params: [msg: "保存失败！",id: id])
                return
            }else{
                redirect(action: "selectDepartment")
            }
        }

    }
    def caiwuAjax(){
        def rs=[:]

        def id=params.id
        def caiwuInstance=Caiwu.findById(id)
        if(!caiwuInstance){
            rs.result=false
            rs.msg='获取数据失败！'
        }else{
            rs.result=true
            rs.caiwuInstance=caiwuInstance
        }
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
    def caiwu_targetup(){
        def id=params.id
        def caiwuInstance=Caiwu.findById(id)
        if(!caiwuInstance){
            render(view: "caiwu_target" , params: [msg: "保存失败！"])
            return
        }else{
            rs.result=true
            rs.caiwuInstance=caiwuInstance
        }
    }
    //工作推进
    def bumenrenwuSave(){
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def selectDepartmentList=SelectDepartment.findAllByCidAndUid(company.id,user.id)
        def sid=params.sid
        def sname=params.sname
        def sign=params.sign
//        if(selectDepartmentList){
//            redirect(action: 'selectDepartmentEdit')
//            return
//        }
//        def frameworkDepartmentList=FrameworkDepartment.findAll();
        [selectDepartmentList:selectDepartmentList,sid:sid,sname:sname,sign:sign]
    }
    def bumenrenwuAdd(){
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def bumenrenwuInstance=new Bumenrenwu(params)
        def uid=user.id
        def cid=company.id
        def dateCteate=new Date()
        bumenrenwuInstance.uid=uid
        bumenrenwuInstance.cid=cid
        bumenrenwuInstance.dateCreate=dateCteate
        if (!bumenrenwuInstance.save(flush: true)) {
            render(view: "bumenrenwuSave", params: [msg: "保存失败！"])
            return
        }else{
            redirect(action: "bumenrenwuList")
        }

    }
    def bumenrenwuEdit(){
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        def selectDepartmentList=SelectDepartment.findAllByCidAndUid(company.id,user.id)
        def id=params.id
        def bumenrenwuInstance=Bumenrenwu.get(id)
        if(!bumenrenwuInstance){
            render(view: "bumenrenwuList", params: [msg: "保存失败！"])
            return
        }
           [bumenrenwuInstance:bumenrenwuInstance,selectDepartmentList:selectDepartmentList]
        }

    def bumenrenwuUpdate(){
        def id=params.id
        def bumenrenwuInstance=Bumenrenwu.get(id)
        if(!bumenrenwuInstance){
            render(view: "bumenrenwuList", params: [msg: "保存失败！"])
            return
        }else{
            bumenrenwuInstance.properties=params
            if (!bumenrenwuInstance.save(flush: true)) {
                render(view: "bumenrenwuEdit", params: [msg: "保存失败！"])
                return
            }else {
                redirect(action: 'bumenrenwuList')
            }
        }
    }
    def bumenrenwuDelete(){
        def id=params.id
        def bumenrenwuInstance=Bumenrenwu.get(id)
        if(!bumenrenwuInstance){
            render(view: "bumenrenwuList", params: [msg: "查找失败！"])
            return
        }else{
            bumenrenwuInstance.delete(flush: true)
            redirect(action: 'bumenrenwuList')
        }
    }
    def bumenrenwuList(){
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }

        def selectDepartmentList=SelectDepartment.findAllByCidAndUid(company.id,user.id)

        def bumenrenwulist=Bumenrenwu.findAllByCidAndUid(company.id,user.id)
        [selectDepartmentList:selectDepartmentList,bumenrenwulist: bumenrenwulist]
    }
    def bumenSelect(){
        def sign=1
        def id=params.id
        def selectDepartmentInstance=SelectDepartment.findById(id)
        if(!selectDepartmentInstance){
            render(view: "bumenrenwuList", params: [msg: "查找失败！"])
            return
        }else{
            redirect(action: 'bumenrenwuSave', params: [sid: selectDepartmentInstance.id,sname: selectDepartmentInstance.name,sign:sign])
        }

    }
    def gongzuotuijin(){
        def user = session.user
        def company = session.company
        if (!user && !company) {
            redirect(action: index(), params: [msg: "登陆已过期，请重新登陆"])
            return
        }
        Calendar cal = Calendar.getInstance();
        def year=cal.get(Calendar.YEAR);
        def month1list=Bumenrenwu.findAllByCidAndUidAndEtime(company.id,user.id,year+'-01')
        def month2list=Bumenrenwu.findAllByCidAndUidAndEtime(company.id,user.id,year+'-02')
        def month3list=Bumenrenwu.findAllByCidAndUidAndEtime(company.id,user.id,year+'-03')
        def month4list=Bumenrenwu.findAllByCidAndUidAndEtime(company.id,user.id,year+'-04')
        def month5list=Bumenrenwu.findAllByCidAndUidAndEtime(company.id,user.id,year+'-05')
        def month6list=Bumenrenwu.findAllByCidAndUidAndEtime(company.id,user.id,year+'-06')
        def month7list=Bumenrenwu.findAllByCidAndUidAndEtime(company.id,user.id,year+'-07')
        def month8list=Bumenrenwu.findAllByCidAndUidAndEtime(company.id,user.id,year+'-08')
        def month9list=Bumenrenwu.findAllByCidAndUidAndEtime(company.id,user.id,year+'-09')
        def month10list=Bumenrenwu.findAllByCidAndUidAndEtime(company.id,user.id,year+'-10')
        def month11list=Bumenrenwu.findAllByCidAndUidAndEtime(company.id,user.id,year+'-11')
        def month12list=Bumenrenwu.findAllByCidAndUidAndEtime(company.id,user.id,year+'-12')
        [month1list:month1list,month2list:month2list,month3list:month3list,month4list:month4list,month5list:month5list,month6list:month6list,month7list:month7list,month8list:month8list,month9list:month9list,month10list:month10list,month11list:month11list,month12list:month12list]
    }

}



