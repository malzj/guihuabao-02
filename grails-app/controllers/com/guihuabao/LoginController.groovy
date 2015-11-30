package com.guihuabao

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

import org.springframework.web.multipart.MultipartFile

import java.text.SimpleDateFormat

class LoginController {
    def login(){
        def username = params.username
        def password = params.password
        def userInstance = User.findByUsernameAndPassword(username,password)
        if (!userInstance){
            redirect(action:'relogin')
            return
        }
        redirect(action:'userList')
    }
    def logout(){
        session.user = ""
        session.company = ""
        redirect(action: "index")
    }
    def index() {}
    def userList(Integer max){
        params.max = Math.min(max ?: 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
    }
    def relogin(){

    }
    def userCreate() {

        [userInstance: new User(params),companyList: Company.list()]
    }
    def userSave() {
        def userInstance = new User(params)
        def companyUser = new CompanyUser(params)
        companyUser.img = "touxiang.jpg"
        if (!userInstance.save(flush: true)||!companyUser.save(flush: true)) {
            render(view: "userCreate", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "userShow", id: userInstance.id)
    }
    def userShow(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "userList")
            return
        }

        [userInstance: userInstance]
    }
    def userEdit(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "userList")
            return
        }

        [userInstance: userInstance]
    }
    def userUpdate(Long id, Long version) {
        def userInstance = User.get(id)

        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "userList")
            return
        }

        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'user.label', default: 'User')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "userEdit", model: [userInstance: userInstance])
                return
            }
        }

        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            render(view: "userEdit", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "userShow", id: userInstance.id)
    }
    def userDelete(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "userList")
            return
        }

        try {
            userInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "userList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "userShow", id: id)
        }
    }

    def companyList(Integer max){
        params.max = Math.min(max ?: 10, 100)
        [companyInstanceList:Company.list(params), companyInstanceTotal: Company.count()]
    }
    def companyCreate(){
        [companyInstance: new Company(params)]
    }
    def companySave(){
        def companyInstance = new Company(params)

        def    fileName

        MultipartFile f = request.getFile('file1')
        if(!f.empty) {
//            fileName=f.getOriginalFilename()
//
//
//            def webRootDir = servletContext.getRealPath("/")
//            println webRootDir
//            def userDir = new File(webRootDir, "/images/")
//            userDir.mkdirs()
//            f.transferTo( new File( userDir, f.originalFilename))
            def date= new Date().getTime()
            Random random =new Random()
            def x = random.nextInt(100)
            def str =f.originalFilename
            String [] strs = str.split("[.]")


            fileName=date.toString()+x.toString()+"."+strs[1]
//            fileName=f.getOriginalFilename()

            def webRootDir = servletContext.getRealPath("/")
            println webRootDir
            def userDir = new File(webRootDir, "/uploadfile/images/")
            userDir.mkdirs()
            f.transferTo( new File( userDir, fileName))

        }


        companyInstance.logoimg=fileName
        if(!companyInstance.save(flush: true)){
            render(view: "companyCreate",model: [companyInstance: companyInstance])
        }

        flash.message =message(code: 'default.created.message', args: [message(code: 'company.label', default: 'Company'), companyInstance.id])
        redirect(action: "companyShow", id:companyInstance.id)
    }
    def companyShow(Long id){
        def companyInstance = Company.get(id)
        if(!companyInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "companyList")
            return
        }
        [companyInstance: companyInstance]
    }
    def companyEdit(Long id){
        def companyInstance = Company.get(id)

        if(!companyInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "companyList")
            return
        }
        [companyInstance: companyInstance]
    }
    def companyUpdate(Long id, Long version) {
        def companyInstance = Company.get(id)
        def  filePath
        def    fileName

        MultipartFile f = request.getFile('file1')
        if(!f.empty) {
            def date= new Date().getTime()
            Random random =new Random()
            def x = random.nextInt(100)
            def str =f.originalFilename
            String [] strs = str.split("[.]")


            fileName=date.toString()+x.toString()+"."+strs[1]
//            fileName=f.getOriginalFilename()

            def webRootDir = servletContext.getRealPath("/")
            println webRootDir
            def userDir = new File(webRootDir, "/uploadfile/images/")
            userDir.mkdirs()
            f.transferTo( new File( userDir, fileName))
        }


        companyInstance.logoimg=fileName
        if (!companyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "companyList")
            return
        }

        if (version != null) {
            if (companyInstance.version > version) {
                companyInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'company.label', default: 'Company')] as Object[],
                        "Another user has updated this Company while you were editing")
                render(view: "companyEdit", model: [companyInstance: companyInstance])
                return
            }
        }

        companyInstance.properties = params

        if (!companyInstance.save(flush: true)) {
            render(view: "companyEdit", model: [companyInstance: companyInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'company.label', default: 'Company'), companyInstance.id])
        redirect(action: "companyShow", id: companyInstance.id)
    }
    def companyDelete(Long id){
        def companyInstance = Company.get(id)
        if(!companyInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code:  'user.label', default: 'User'), id])
            redirect(action: "companyList")
            return
        }

        try{
            companyInstance.delete(flush: true)
            redirect(action: "companyList")
        }
        catch(DataIntegrityViolationException e) {
            redirect(action: "companyShow", id: id)
        }
    }

    def roleList(Integer max){
        params.max = Math.min(max ?: 10, 100)
        [roleInstanceList:Role.list(params), roleInstanceTotal: Role.count()]
    }
    def roleCreate(){
        [roleInstance: new Role(params)]
    }
    def roleSave(){
        def roleInstance = new Role(params)
        if (!roleInstance.save(flush: true)) {
            render(view: "roleCreate", model: [roleInstance: roleInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'role.label', default: 'Role'), roleInstance.id])
        redirect(action: "roleShow", id: roleInstance.id)
    }
    def roleShow(Long id) {
        def roleInstance = Role.get(id)
        if (!roleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), id])
            redirect(action: "roleList")
            return
        }

        [roleInstance: roleInstance]
    }
    def roleEdit(Long id) {
        def roleInstance = Role.get(id)
        if (!roleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), id])
            redirect(action: "roleList")
            return
        }

        [roleInstance: roleInstance]
    }
    def roleUpdate(Long id, Long version) {
        def roleInstance = Role.get(id)
        if (!roleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), id])
            redirect(action: "roleList")
            return
        }

        if (version != null) {
            if (roleInstance.version > version) {
                roleInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'role.label', default: 'Role')] as Object[],
                        "Another role has updated this Role while you were editing")
                render(view: "roleEdit", model: [roleInstance: roleInstance])
                return
            }
        }

        roleInstance.properties = params

        if (!roleInstance.save(flush: true)) {
            render(view: "roleEdit", model: [roleInstance: roleInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'role.label', default: 'Role'), roleInstance.id])
        redirect(action: "roleShow", id: roleInstance.id)
    }
    def roleDelete(Long id) {
        def roleInstance = Role.get(id)
        if (!roleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), id])
            redirect(action: "roleList")
            return
        }

        try {
            roleInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'role.label', default: 'Role'), id])
            redirect(action: "roleList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'role.label', default: 'Role'), id])
            redirect(action: "roleShow", id: id)
        }
    }

    def hxset(){

    }
    //功能介绍
    def funIntroduction(Long id){
            def funIntroduction = FunIntroduction.get(id)
            if (!funIntroduction) {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
                redirect(action: "list")
                return
            }
            [funIntroduction: funIntroduction]
        }


    def funIntroductionSave(Long id, Long version){
        def s=params
        def ss=params.content
        def funIntroduction = FunIntroduction.get(id)
        if (!funIntroduction) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (funIntroduction.version > version) {
                funIntroduction.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'company.label', default: 'Company')] as Object[],
                        "Another user has updated this Company while you were editing")
                render(view: "edit", model: [funIntroduction: funIntroduction])
                return
            }
        }

        funIntroduction.properties = params


        if (!funIntroduction.save(flush: true)) {
            render(view: "edit", model: [funIntroduction: funIntroduction])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'company.label', default: 'Company'), funIntroduction.id])
        redirect(action: "funIntroduction", id: funIntroduction.id)

    }
    //反馈
    def feedback(Integer max){

            params.max = Math.min(max ?: 10, 100)
            [feedbackInstanceList: Feedback.list(params), feedbackInstanceTotal: Feedback.count()]

    }
    //登录图片
    def loginImg(Long id){
        def loginImg= IndexImg.get(id)
        [loginImg:loginImg]


    }
    def loginImgSave(Long id, Long version){
        def loginimg = IndexImg.get(id)
        def  filePath
        def    fileName

        MultipartFile f = request.getFile('file1')
        if(!f.empty) {
//            fileName=f.getOriginalFilename()
//            filePath="web-app/images/"
//            f.transferTo(new File(filePath+fileName))
            def date= new Date().getTime()
            Random random =new Random()
            def x = random.nextInt(100)
            def str =f.originalFilename
            String [] strs = str.split("[.]")


            fileName=date.toString()+x.toString()+"."+strs[1]
//            fileName=f.getOriginalFilename()

            def webRootDir = servletContext.getRealPath("/")
            println webRootDir
            def userDir = new File(webRootDir, "/uploadfile/images/")
            userDir.mkdirs()
            f.transferTo( new File( userDir, fileName))
            loginimg.img=fileName
        }



        if (!loginimg) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "loginImg", id: loginimg.id)
            return
        }

        if (version != null) {
            if (loginimg.version > version) {
                loginimg.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'company.label', default: 'Company')] as Object[],
                        "Another user has updated this Company while you were editing")
                render(view: "companyEdit", model: [companyInstance: loginimg])
                return
            }
        }

        loginimg.properties = params

        if (!loginimg.save(flush: true)) {
            render(view: "companyEdit", model: [companyInstance: loginimg])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'company.label', default: 'Company'), loginimg.id])
        redirect(action: "loginImg", id: loginimg.id)


    }
    //系统通知
    def inform(Integer max){
        params.max = Math.min(max ?: 10, 100)
        def informList = Inform.list(sort: "dateCreate",order: "desc")
        [informList: informList]
    }
    def informCreate(){
        [informInstance: new Inform(params)]
    }
    def informSave(){
        def informInstance=new Inform(params)
        informInstance.dateCreate=new Date()
        if(!informInstance.save(flush: true)){
            render(view: "informCreate", model: [informInstance: informInstance])
            return
        }
        flash.message = message(code: 'default.created.message', args: [message(code: 'inform.label', default: 'Inform'), informInstance.id])
        redirect(action: "inform", id: informInstance.id)
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
    def informEdit(Long id){
        def informInstance = Inform.findById(id)
        if (!informInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'inform.label', default: 'Inform'), id])
            redirect(action: "inform")
            return
        }

        [informInstance: informInstance]
    }
    def informUpdate(Long id){
        def informInstance=Inform.get(id)
        if(!informInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'inform.label', default: 'Inform'), id])
            redirect(action: "inform")
            return
        }
            informInstance.properties=params
            if(!informInstance.save(flush: true)){
                render(view: "informEdit", model: [informInstance: informInstance])
                return
            }
        flash.message = message(code: 'default.updated.message', args: [message(code: 'inform.label', default: 'Inform'), informInstance.id])
        redirect(action: "inform", id: informInstance.id)
    }
    def informDelete(Long id){
        def informInstance=Inform.get(id)
        if (!informInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'inform.label', default: 'Inform'), id])
            redirect(action: "inform")
            return
        }

        try {
            informInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'inform.label', default: 'Inform'), id])
            redirect(action: "inform")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'inform.label', default: 'Inform'), id])
            redirect(action: "inform", id: id)
        }
    }
    //版本更新
    def version(Long id){
        def banben = Banben.get(id)
        if (!banben) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
//            redirect(action: "list")
            return
        }
        [banben: banben]

    }
    def banbenSave(Long id, Long version){
        def banben = Banben.get(id)
        if (!banben) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (banben.version > version) {
                banben.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'company.label', default: 'Company')] as Object[],
                        "Another user has updated this Company while you were editing")
                render(view: "edit", model: [funIntroduction: banben])
                return
            }
        }

        banben.properties = params


        if (!banben.save(flush: true)) {
            render(view: "edit", model: [funIntroduction: banben])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'company.label', default: 'Company'), inform.id])
        redirect(action: "version", id: banben.id)


    }
    //使用条款
    def clause(Long id){
        def clause = Clause.get(id)
        if (!clause) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
//            redirect(action: "list")
            return
        }
        [clause: clause]

    }
    def clauseSave(Long id, Long version){
        def clause = Clause.get(id)
        if (!clause) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'company.label', default: 'Company'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (clause.version > version) {
                clause.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'company.label', default: 'Company')] as Object[],
                        "Another user has updated this Company while you were editing")
                render(view: "edit", model: [funIntroduction: clause])
                return
            }
        }

        clause.properties = params


        if (!clause.save(flush: true)) {
            render(view: "edit", model: [funIntroduction: clause])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'company.label', default: 'Company'), clause.id])
        redirect(action: "clause", id: clause.id)

    }

    //和许助手
    def hxhelper(Integer max){
        params.max = Math.min(max ?: 10, 100)
        [bookInstanceList: Book.list(params), bookInstanceTotal: Book.count()]
    }
    def bookCreate(){
        [bookInstance: new Book(params)]
    }
    def bookSave(){
        def bookInstance = new Book(params)
        def  filePath
        def  fileName
        MultipartFile f = request.getFile('bookImg')
        if(!f.empty) {
//            fileName=f.getOriginalFilename()
//            filePath="web-app/images/"
//            f.transferTo(new File(filePath+fileName))
            def date= new Date().getTime()
            Random random =new Random()
            def x = random.nextInt(100)
            def str =f.originalFilename
            String [] strs = str.split("[.]")


            fileName=date.toString()+x.toString()+"."+strs[1]
//            fileName=f.getOriginalFilename()

            def webRootDir = servletContext.getRealPath("/")
            println webRootDir
            def userDir = new File(webRootDir, "/uploadfile/images/")
            userDir.mkdirs()
            f.transferTo( new File( userDir, fileName))
    
        bookInstance.bookImg=fileName
        }
        if(!bookInstance.save(flush: true)){
            render(view: "bookCreate",model: [bookInstance: bookInstance])
        }

        flash.message =message(code: 'default.created.message', args: [message(code: 'book.label', default: 'Book'), bookInstance.id])
        redirect(action: "bookShow", id:bookInstance.id, params: [bookName: bookInstance.bookName])
    }
    def bookShow(Long id) {
        def bookInstance = Book.get(id)
        if (!bookInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), id])
            redirect(action: "roleList")
            return
        }

        [bookInstance: bookInstance]
    }
    //书籍大纲
    def syllabusList(Integer max,Long id){
        params.max = Math.min(max ?: 10, 100)
         def   syll=Syllabus.findAllByBook(Book.get(id),params)
        def sy=Syllabus.countByBook(Book.get(id))
        [syllabusInstanceList: syll, syllabusInstanceTotal: sy,bookId:id]
    }
    def syllabusCreate(Long id){

        [syllabusInstance: new Syllabus(params),bookId:id]
    }
    def syllabusSave(){

        def syllabusInstance = new Syllabus(params)
        syllabusInstance.book=Book.get(params.bookId)
        syllabusInstance.dateCreate=new Date()
        if (!syllabusInstance.save(flush: true)) {
            render(view: "syllabusCreate", model: [syllabusInstance: syllabusInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), syllabusInstance.id])
        redirect(action: "syllabusShow", id: syllabusInstance.id)
    }
    def syllabusShow(Long id) {
        def syllabusInstance = Syllabus.get(id)
        if (!syllabusInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), id])
            redirect(action: "syllabusList")
            return
        }

        [syllabusInstance: syllabusInstance]
    }
    //章节
    def chapterList(Integer max,Long id){
        params.max = Math.min(max ?: 10, 100)
        def syllabus= Syllabus.get(id)
        def chapterInstanceList=Chapter.findAllBySyllabus(syllabus,params)
        def chapterInstanceTotal=Chapter.countBySyllabus(syllabus)

        [chapterInstanceList: chapterInstanceList, chapterInstanceTotal: chapterInstanceTotal,bookId:syllabus.book.id,syllabusId:id]
    }
    def chapterCreate(Long id){
        [chapterInstance: new Syllabus(params),syllabusId:id]

    }
    def chapterSave(){
        def chapter = new Chapter(params)
        chapter.syllabus=Syllabus.get(params.syllabusId)
        chapter.dateCreate=new Date()
        if (!chapter.save(flush: true)) {
            render(view: "syllabusCreate", model: [chapter: chapter])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), chapter.id])
        redirect(action: "chapterShow", id: chapter.id)
    }
    def chapterShow(Long id) {
        def chapter = Chapter.get(id)
        if (!chapter) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), id])
            redirect(action: "syllabusList")
            return
        }

        [chapter: chapter]


    }

    //内容顺序调整
    //向上调整
    def contentUp(){
        def contentInstance=Content.get(params.id)
        def charpterid = contentInstance.chapter.id
        if(!contentInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'content.label', default: 'Content'), contentInstance.id])
            redirect(action: "contentList",params: [id: charpterid])
            return
        }else{
            if(contentInstance.num==1){

            }else{
                def num1=contentInstance.num-1
                def content1=Content.findByChapterAndNum(contentInstance.chapter,num1)
                contentInstance.num-=1
                content1.num+=1
                if(contentInstance.save(flush: true)&&content1.save(flash:true)){

                }else{
                    flash.message = message(code: 'default.not.found.message', args: [message(code: 'content.label', default: 'Content'), contentInstance.id])
                    redirect(action: "contentList",params: [id: charpterid])
                    return
                }
            }
        }
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'content.label', default: 'Content'), contentInstance.id])
        redirect(action: "contentList",params: [id: charpterid])
        return
    }

    //向下调整
    def contentDown(){
        def contentInstance=Content.get(params.id)
        def charpterid = contentInstance.chapter.id
        def allContent = Content.findAllByChapter(contentInstance.chapter)
        if(!contentInstance){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'content.label', default: 'Content'), contentInstance.id])
            redirect(action: "contentList",params: [id: charpterid])
            return
        }else{
            if(contentInstance.num==allContent.size()){

            }else{
                def num1=contentInstance.num+1
                def content1=Content.findByChapterAndNum(contentInstance.chapter,num1)
                contentInstance.num+=1
                content1.num-=1
                if(contentInstance.save(flush: true)&&content1.save(flash:true)){

                }else{
                    flash.message = message(code: 'default.not.found.message', args: [message(code: 'content.label', default: 'Content'), contentInstance.id])
                    redirect(action: "contentList",params: [id: charpterid])
                    return
                }
            }
        }
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'content.label', default: 'Content'), contentInstance.id])
        redirect(action: "contentList",params: [id: charpterid])
        return
    }

    //内容
    def contentList(Integer max,Long id){
        params.max = Math.min(max ?: 10, 100)
        params<<[sort: 'num',order: 'asc']
        def   contentInstanceList=Content.findAllByChapter(Chapter.get(id),params)
        def contentInstanceTotal=Content.countByChapter(Chapter.get(id))

        [contentInstanceList: contentInstanceList, contentInstanceTotal: contentInstanceTotal,chapterId: id,syllabusId: Chapter.get(id).syllabus.id]


    }
    def contentCreate(Long id){
        [contentInstance: new Content(params),chapterId:id]
    }
    def contentSave(){
        def allContent = Content.findAllByChapter(Chapter.get(params.chapterId),[sort:'num',order:'asc'])
        def contentsize = allContent.size()
        def contentInstance = new Content(params)
        contentInstance.chapter=Chapter.get(params.chapterId)
        if(contentsize==0){
            contentInstance.num =1
        }else {
            def show = allContent.get(contentsize-1)
            contentInstance.num = show.num + 1
        }
        contentInstance.dateCreate=new Date()
        if (!contentInstance.save(flush: true)) {
            render(view: "create", model: [contentInstance: contentInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'content.label', default: 'Content'), contentInstance.id])
        redirect(action: "contentShow", id: contentInstance.id)

    }
    def contentShow(Long id) {
        def content = Content.get(id)
        if (!content) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), id])
            redirect(action: "syllabusList")
            return
        }

        [content: content]
    }
    def feedbackdelete(Long id) {
        def feedbackInstance = Feedback.get(id)
        if (!feedbackInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'feedback.label', default: 'Feedback'), id])
            redirect(controller: "login",action: "feedback")
            return
        }

        try {
            feedbackInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'feedback.label', default: 'Feedback'), id])
            redirect(controller: "login",action: "feedback")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'feedback.label', default: 'Feedback'), id])
            redirect(action: "show", id: id)
        }
    }
    def feedbackShow(Long id){
           def feedback= Feedback.get(id)
           [feedback:feedback]
       }
    def bookdelete(Long id){
        def bookInstance = Book.get(id)
        if (!bookInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), id])
            redirect(action: "hxhelper")
            return
        }

        try {
            bookInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'book.label', default: 'Book'), id])
            redirect(action: "hxhelper")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'book.label', default: 'Book'), id])
            redirect(action: "show", id: id)
        }
    }
    def syllabusDelete(Long id){
        def syllabusInstance = Syllabus.get(id)

        if (!syllabusInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), id])
            redirect(action: "syllabusList",id: syllabusInstance.book.id)
            return
        }

        try {
            syllabusInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), id])
            redirect(action: "syllabusList",id: syllabusInstance.book.id)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), id])
            redirect(action: "show", id: id)
        }
    }
    def charterDelete(Long id){
        def chapterInstance = Chapter.get(id)
        if (!chapterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'chapter.label', default: 'Chapter'), id])
            redirect(action: "chapterList" ,id:chapterInstance.syllabus.id)
            return
        }

        try {
            chapterInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'chapter.label', default: 'Chapter'), id])
            redirect(action: "chapterList" ,id:chapterInstance.syllabus.id)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'chapter.label', default: 'Chapter'), id])
            redirect(action: "show", id: id)
        }
    }
    def contentDelete(Long id){
        def contentInstance = Content.get(id)
        def chapter = Chapter.get(contentInstance.chapter.id)
        def allContent = Content.findAllByChapter(chapter)

        if (!contentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'content.label', default: 'Content'), id])
            redirect(action: "contentList",id: contentInstance.chapter.id)
            return
        }

        def bcontentInstance = Content.findAllByChapterAndNumGreaterThan(chapter,contentInstance.num,[sort: 'num',order: 'asc'])


        try {
            if(contentInstance.num==allContent.size()){
                contentInstance.delete(flush: true)
            }else {
                for (def b in bcontentInstance) {
                    b.num -= 1
                    b.save(flush: true)
                }
                contentInstance.delete(flush: true)
            }

            flash.message = message(code: 'default.deleted.message', args: [message(code: 'content.label', default: 'Content'), id])
            redirect(action: "contentList",id: contentInstance.chapter.id)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'content.label', default: 'Content'), id])
            redirect(action: "show", id: id)
        }
    }
    def upload(){

        def rs=[:]

        def  fileName
        MultipartFile f = params.imgFile
        if(!f.empty) {
            def date= new Date().getTime()
            Random random =new Random()
            def x = random.nextInt(100)
            def str =f.originalFilename
            String [] strs = str.split("[.]")


            fileName=date.toString()+x.toString()+"."+strs[1]
//            fileName=f.getOriginalFilename()

            def webRootDir = servletContext.getRealPath("/")
            println webRootDir
            def userDir = new File(webRootDir, "/uploadfile/images/")
            userDir.mkdirs()
            f.transferTo( new File( userDir, fileName))
        }
        def web='/guihuabao/static/uploadfile/images/'+fileName

        rs=[error:0,url:web]

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON

    }

    def bookEdit(Long id){
        def bookInstance = Book.get(id)
        [bookInstance: bookInstance]
    }
    def bookUpdate(Long id, Long version){
        def bookInstance = Book.get(id)
        def a =params
        def  filePath
        def  fileName

        MultipartFile f = request.getFile('bookImg1')
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
            bookInstance.bookImg=fileName
        }



        if (!bookInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), id])
            redirect(action: "bookShow", id: bookInstance.id)
            return
        }

        if (version != null) {
            if (bookInstance.version > version) {
                bookInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'book.label', default: 'Book')] as Object[],
                        "Another user has updated this Book while you were editing")
                render(view: "edit", model: [bookInstance: bookInstance])
                return
            }
        }

        bookInstance.properties = params


        if (!bookInstance.save(flush: true)) {
            render(view: "edit", model: [bookInstance: bookInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'book.label', default: 'Book'), bookInstance.id])
        redirect(action: "bookShow", id: bookInstance.id)

    }
    def syllabusEdit(Long id){
        def syllabusInstance = Syllabus.get(id)
        if (!syllabusInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), id])
            redirect(action: "list")
            return
        }
        [syllabusInstance: syllabusInstance]
    }
    def syllabusUpdate(Long id,Long version){
        def syllabusInstance = Syllabus.get(id)
        if (!syllabusInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (syllabusInstance.version > version) {
                syllabusInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'syllabus.label', default: 'Syllabus')] as Object[],
                        "Another user has updated this Syllabus while you were editing")
                render(view: "edit", model: [syllabusInstance: syllabusInstance])
                return
            }
        }

        syllabusInstance.properties = params

        if (!syllabusInstance.save(flush: true)) {
            render(view: "edit", model: [syllabusInstance: syllabusInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), syllabusInstance.id])
        redirect(action: "syllabusShow", id: syllabusInstance.id)
    }
    def chapterEdit(Long id){
        def chapterInstance = Chapter.get(id)
        if (!chapterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'chapter.label', default: 'Chapter'), id])
            redirect(action: "list")
            return
        }

        [chapterInstance: chapterInstance]
    }
    def chapterUpdate(Long id,Long version){
        def chapterInstance = Chapter.get(id)
        if (!chapterInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'chapter.label', default: 'Chapter'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (chapterInstance.version > version) {
                chapterInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'chapter.label', default: 'Chapter')] as Object[],
                        "Another user has updated this Chapter while you were editing")
                render(view: "edit", model: [chapterInstance: chapterInstance])
                return
            }
        }

        chapterInstance.properties = params

        if (!chapterInstance.save(flush: true)) {
            render(view: "edit", model: [chapterInstance: chapterInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'chapter.label', default: 'Chapter'), chapterInstance.id])
        redirect(action: "chapterShow", id: chapterInstance.id)
    }
    def contentEdit(Long id){
            def contentInstance = Content.get(id)
            if (!contentInstance) {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'content.label', default: 'Content'), id])
                redirect(action: "list")
                return
            }
            [contentInstance: contentInstance]

    }
    def contentUpdate(Long id, Long version){
        def contentInstance = Content.get(id)
        if (!contentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'content.label', default: 'Content'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (contentInstance.version > version) {
                contentInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'content.label', default: 'Content')] as Object[],
                        "Another user has updated this Content while you were editing")
                render(view: "edit", model: [contentInstance: contentInstance])
                return
            }
        }

        contentInstance.properties = params

        if (!contentInstance.save(flush: true)) {
            render(view: "edit", model: [contentInstance: contentInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'content.label', default: 'Content'), contentInstance.id])
        redirect(action: "contentShow", id: contentInstance.id)

    }

    //案例和工具
    def tools(Integer max){
        params.max = Math.min(max ?: 10, 100)
        def toolInstanceList = HexuTool.list(params)
        [toolInstanceList: HexuTool.list(params), toolInstanceTotal: HexuTool.count()]
    }

    //案例和工具新建
    def toolCreate(){
        [toolInstance: new HexuTool(params)]
    }
    //案例和工具新建
    def toolDelete(Long id){
        def toolInstance = HexuTool.get(id)
        if (!toolInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tool.label', default: 'Tool'), id])
            redirect(action: "tools")
            return
        }

        try {
            toolInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'tool.label', default: 'Tool'), id])
            redirect(action: "tools")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'tool.label', default: 'Tool'), id])
            redirect(action: "tools", id: id)
        }
    }
    def toolEdit(Long id){
        def toolInstance = HexuTool.get(id)
        [toolInstance: toolInstance]
    }

    def toolShow(Long id) {
        def toolInstance = HexuTool.get(id)
        if (!toolInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), id])
            redirect(action: "tools")
            return
        }

        [toolInstance: toolInstance]
    }
    def toolUpdate(Long id, Long version){
        def toolInstance = HexuTool.get(id)
        def  fileName

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

            toolInstance.toolImg=fileName
        }



        if (!toolInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tool.label', default: 'Tool'), id])
            redirect(action: "toolShow", id: toolInstance.id)
            return
        }

        if (version != null) {
            if (toolInstance.version > version) {
                toolInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'book.label', default: 'Book')] as Object[],
                        "Another user has updated this Book while you were editing")
                render(view: "toolEdit", model: [toolInstance: toolInstance])
                return
            }
        }

        toolInstance.properties = params


        if (!toolInstance.save(flush: true)) {
            render(view: "toolEdit", model: [bookInstance: toolInstance,id: toolInstance.id])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'tool.label', default: 'Tool'), toolInstance.id])
        redirect(action: "toolShow", id: toolInstance.id)

    }
    //案例和工具保存
    def toolSave(){
        def toolInstance = new HexuTool(params)
        def  fileName
        MultipartFile f = request.getFile('toolImg')
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
            f.transferTo( new File( userDir, fileName))

            toolInstance.toolImg=fileName
        }
        if(!toolInstance.save(flush: true)){
            render(view: "toolCreate",model: [toolInstance: toolInstance])
        }

        flash.message =message(code: 'default.created.message', args: [message(code: 'book.label', default: 'Book'), toolInstance.id])
        redirect(action: "toolShow", id:toolInstance.id, params: [bookName: toolInstance.toolName])
    }
    def toolContentCreate(Long id){
        [contentInstance: new ToolContent(params),toolId:id]
    }
    def toolContentSave(){
        def contentInstance = new ToolContent(params)
        def id = params.toolId
        contentInstance.hexutools=HexuTool.get(params.toolId)
        contentInstance.dateCreate=new Date()
        if (!contentInstance.save(flush: true)) {
            render(view: "create", model: [contentInstance: contentInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'content.label', default: 'Content'), contentInstance.id])
        redirect(action: "toolContentShow", id: contentInstance.id)

    }
    def toolContentShow(Long id) {
        def toolContentInstance = ToolContent.get(id)
        if (!toolContentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), id])
            redirect(action: "syllabusList")
            return
        }

        [toolContentInstance: toolContentInstance,toolId: toolContentInstance.hexutools.id]
    }
    def toolContentList(Integer max,Long id){
        params.max = Math.min(max ?: 10, 100)
        params<<[sort: "id",order: "asc"]
        def toolContentInstanceList = ToolContent.findAllByHexutools(HexuTool.get(id),params)
        def toolContentInstanceTotal = ToolContent.countByHexutools(HexuTool.get(id))
        [toolContentInstanceList: toolContentInstanceList,toolContentInstanceTotal: toolContentInstanceTotal,toolId: id]
    }
    def toolContentEdit(Long id){
        def toolContentInstance = ToolContent.get(id)
        if (!toolContentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'content.label', default: 'Content'), id])
            redirect(action: "list")
            return
        }
        [toolContentInstance: toolContentInstance]

    }
    def toolContentUpdate(Long id,Long version){
        def toolContentInstance = ToolContent.get(id)
        if (!toolContentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'content.label', default: 'Content'), id])
            redirect(action: "toolContentList")
            return
        }

        if (version != null) {
            if (toolContentInstance.version > version) {
                toolContentInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'content.label', default: 'Content')] as Object[],
                        "Another user has updated this Content while you were editing")
                render(view: "toolContentEdit", model: [toolContentInstance: toolContentInstance])
                return
            }
        }

        toolContentInstance.properties = params

        if (!toolContentInstance.save(flush: true)) {
            render(view: "toolContentEdit", model: [toolContentInstance: toolContentInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'content.label', default: 'Content'), toolContentInstance.id])
        redirect(action: "toolContentShow", id: toolContentInstance.id)
    }
    def toolContentDelete(Long id){
        def toolContentInstance = ToolContent.get(id)
        if (!toolContentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'content.label', default: 'Content'), id])
            redirect(action: "toolContentList",id: toolContentInstance.hexutools.id)
            return
        }

        try {
            toolContentInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'content.label', default: 'Content'), id])
            redirect(action: "toolContentList",id: toolContentInstance.hexutools.id)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'content.label', default: 'Content'), id])
            redirect(action: "toolContentShow", id: id)
        }
    }


    //应用
    //新建应用
    def appList(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [appsInstanceList: Apps.list(params), appsInstanceTotal: Apps.count()]
    }

    def appCreate() {
        [appsInstance: new Apps(params)]
    }

    def appSave() {
        def appsInstance = new Apps(params)
        def  fileName
        MultipartFile f = request.getFile('file')
        if(!f.empty) {

            def date= new Date().getTime()
            Random random =new Random()
            def x = random.nextInt(100)
            def str =f.originalFilename
            String [] strs = str.split("[.]")


            fileName=date.toString()+x.toString()+"."+strs[1]
            def webRootDir = servletContext.getRealPath("/")
            println webRootDir
            def userDir = new File(webRootDir, "uploadfile/appimg/")
            userDir.mkdirs()
            f.transferTo( new File( userDir, fileName))

            appsInstance.appImg=fileName
        }
        if (!appsInstance.save(flush: true)) {
            render(view: "appCreate", model: [appsInstance: appsInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'apps.label', default: 'Apps'), appsInstance.id])
        redirect(action: "appShow", id: appsInstance.id)
    }

    def appShow(Long id) {
        def appsInstance = Apps.get(id)
        if (!appsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'apps.label', default: 'Apps'), id])
            redirect(action: "appList")
            return
        }

        [appsInstance: appsInstance]
    }

    def appEdit(Long id) {
        def appsInstance = Apps.get(id)
        if (!appsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'apps.label', default: 'Apps'), id])
            redirect(action: "appList")
            return
        }

        [appsInstance: appsInstance]
    }

    def appUpdate(Long id, Long version) {
        def appsInstance = Apps.get(id)
        def  fileName
        MultipartFile f = request.getFile('file')
        if(!f.empty) {

            def date= new Date().getTime()
            Random random =new Random()
            def x = random.nextInt(100)
            def str =f.originalFilename
            String [] strs = str.split("[.]")


            fileName=date.toString()+x.toString()+"."+strs[1]
            def webRootDir = servletContext.getRealPath("/")
            println webRootDir
            def userDir = new File(webRootDir, "uploadfile/appimg/")
            userDir.mkdirs()
            f.transferTo( new File( userDir, fileName))

            appsInstance.appImg=fileName
        }

        if (!appsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'apps.label', default: 'Apps'), id])
            redirect(action: "appList")
            return
        }

        if (version != null) {
            if (appsInstance.version > version) {
                appsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'apps.label', default: 'Apps')] as Object[],
                        "Another user has updated this Apps while you were editing")
                render(view: "appEdit", model: [appsInstance: appsInstance])
                return
            }
        }

        appsInstance.properties = params

        if (!appsInstance.save(flush: true)) {
            render(view: "appEdit", model: [appsInstance: appsInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'apps.label', default: 'Apps'), appsInstance.id])
        redirect(action: "appShow", id: appsInstance.id)
    }

    def appDelete(Long id) {
        def appsInstance = Apps.get(id)
        if (!appsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'apps.label', default: 'Apps'), id])
            redirect(action: "appList")
            return
        }

        try {
            appsInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'apps.label', default: 'Apps'), id])
            redirect(action: "appList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'apps.label', default: 'Apps'), id])
            redirect(action: "appShow", id: id)
        }
    }



    //购买应用
    //应用列表
    def buy_app(Integer max){
        params.max = Math.min(max ?: 10, 100)
        def cid = params.cid
        def buyappInstance = CompanyApps.findAllByCid(cid)
        [appsInstanceList: Apps.list(params), appsInstanceTotal: Apps.count(),buyappInstance: buyappInstance,params: [cid: cid]]
    }
    //购买应用保存
    def buyappSave(){
        def rs=[:]
        def id=params.aid
        def appInstance = Apps.get(id)
        def cid = params.buycid
        def haveone = CompanyApps.findByAppAndCid(appInstance,cid)
        if(haveone){
            rs.result=false
            rs.msg="已购买该应用！"
        }else {
            def companyappInstance = new CompanyApps(params)

            companyappInstance.app = appInstance
            if (companyappInstance) {
                companyappInstance.cid = params.buycid
                if (!params.appname) {
                    companyappInstance.name = appInstance.appName
                } else {
                    companyappInstance.name = params.appname
                }
                if (!params.appImg) {
                    companyappInstance.img = appInstance.appImg
                } else {
                    companyappInstance.img = params.appImg
                }
//            companyappInstance.appurl = appInstance.appurl
                companyappInstance.buydate = new Date()
                companyappInstance.enddate = params.enddate
            }

            if (!companyappInstance.save(flush: true)) {
                rs.result=false
                rs.msg="不能买该该应用！"
            }else{
                rs.result=true
                rs.msg="买该应用成功！"
            }
        }

        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
//    删除购买应用
    def buyappDelete(){
        def rs=[:]
        def id=params.aid
        def appInstance = CompanyApps.get(id)
        if(appInstance) {

            try {
                appInstance.delete(flush: true)
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
    //    试题
    /*
    * 试卷列表
    * */
    def testPaperList(Integer max){
        params.max = Math.min(max ?: 10, 100)
        params<<[sort:'dateCreate',order: 'desc']
        def testPaperInstanceList=TestPaper.findAll(params)
        [testPaperInstanceList: testPaperInstanceList, testPaperInstanceTotal: TestPaper.count()]
    }
    /*
   * 新建试卷
   * */
    def testPaperCreate(){

        [testPaperInstance: new TestPaper(params)]
    }
    /*
   * 新建试卷保存
   * */
    def testPaperSave(){

        def testPaperInstance = new TestPaper(params)
        testPaperInstance.dateCreate = new Date()
        if (!testPaperInstance.save(flush: true)) {
            render(view: "create", model: [testPaperInstance: testPaperInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), testPaperInstance.id])
        redirect(action: "testPaperShow", id: testPaperInstance.id)
    }
    /*
      * 试卷查看
      * */
    def testPaperShow(Long id) {
        def testPaperInstance = TestPaper.get(id)
        if (!testPaperInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), id])
            redirect(action: "list")
            return
        }

        [testPaperInstance: testPaperInstance]
    }
    /*
    * 试卷编辑
    * */
    def testPaperEdit(Long id) {
        def testPaperInstance = TestPaper.get(id)
        if (!testPaperInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), id])
            redirect(action: "testPaperList")
            return
        }

        [testPaperInstance: testPaperInstance]
    }
    /*
    * 试卷更新
    * */
    def testPaperUpdate(Long id, Long version) {
        def testPaperInstance = TestPaper.get(id)
        if (!testPaperInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), id])
            redirect(action: "testPaperList")
            return
        }

        if (version != null) {
            if (testPaperInstance.version > version) {
                testPaperInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'testPaper.label', default: 'TestPaper')] as Object[],
                        "Another user has updated this TestPaper while you were editing")
                render(view: "testPaperEdit", model: [testPaperInstance: testPaperInstance])
                return
            }
        }

        testPaperInstance.properties = params

        if (!testPaperInstance.save(flush: true)) {
            render(view: "testPaperEdit", model: [testPaperInstance: testPaperInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), testPaperInstance.id])
        redirect(action: "testPaperShow", id: testPaperInstance.id)
    }
    /*
    * 试卷删除
    * */
    def testPaperDelete(Long id) {
        def testPaperInstance = TestPaper.get(id)
        if (!testPaperInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), id])
            redirect(action: "testPaperList")
            return
        }

        try {
            testPaperInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), id])
            redirect(action: "testPaperList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), id])
            redirect(action: "testPaperShow", id: id)
        }
    }
    /*
    * 题目列表
    *  参数 id（试卷ID）
    * */
    def questionsList(Long id,Integer max){
        params.max = Math.min(max ?: 10, 100)
        params<<[sort:'num',order: 'asc']
        def testPaper=TestPaper.findById(id)
        def questionsInstanceList=Questions.findAllByTestPapers(testPaper,params)
        def questionsInstanceTotal=Questions.countByTestPapers(testPaper)
        [questionsInstanceList: questionsInstanceList, questionsInstanceTotal: questionsInstanceTotal,id: id]
    }
    /*
    * 新建题目
    * 参数 id（试卷ID）
    * */
    def questionCreate(Long id){
        def testPaperInstance=TestPaper.get(id)
        def questionInfo=Questions.findByTestPapers(testPaperInstance,[sort: 'num',order: 'desc'])
        def num
        if(questionInfo){
            num=questionInfo.num+1
        }else{
            num=1
        }
        [questionInstance: new Questions(params),id: id,num: num]
    }
    /*
    * 保存题目及选项
    * 参数 id（试卷ID）
    * */
    def questionSave(Long id){
        def questionInstance=new Questions(params)
        questionInstance.testPapers=TestPaper.findById(id)
        def questionInfo
        questionInfo=questionInstance.save(flush: true)
        if (!questionInfo) {
            redirect(action: "questionsList", id: id)
            return
        }
        if(params.type.toLong()==1||params.type.toLong()==2) {
            def count = params.letter.size()

            for (def i = 0; i < count; i++) {
                def optionInfo = ''
                def optionInstance = new Options();
                optionInstance.letter = params.letter[i]
                optionInstance.content = params.content[i]
                optionInstance.analysis = params.analysis[i]
                optionInstance.score = params.score[i].toLong()
                optionInstance.questions = questionInfo
                optionInfo = optionInstance.save(flush: true)
                if (!optionInfo) {
                    redirect(action: "questionsList", id: id)
                    return
                }
            }
        }
        redirect(action: "questionsList", id: id)
    }
    /*
    * 题目修改
    * 参数 id（试卷ID）questionId（题目ID）
    * */
    def questionEdit(Long id,Long questionId){
        def testPaperInstance=TestPaper.get(id)
        def questionInstance=Questions.findByIdAndTestPapers(questionId,testPaperInstance)
        def optionInstanceList=Options.findAllByQuestions(questionInstance)
        [questionInstance:questionInstance,optionInstanceList:optionInstanceList,id:id]
    }
    /*
   * 题目修改更新
   * 参数 id（试卷ID）questionId（题目ID）
   * */
    def questionUpdate(Long id,Long questionId, Long version){
        def testPaperInstance=TestPaper.get(id)
        def questionInstance=Questions.findByIdAndTestPapers(questionId,testPaperInstance)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), id])
            redirect(action: "questionsList")
            return
        }

        if (version != null) {
            if (questionInstance.version > version) {
                questionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'question.label', default: 'Question')] as Object[],
                        "Another user has updated this TestPaper while you were editing")
                redirect(action: "questionsList",params: [id:id,questionId:questionId])
                return
            }
        }

        questionInstance.num = Float.parseFloat(params.num)
        questionInstance.question = params.question
        questionInstance.type = Float.parseFloat(params.type)
        questionInstance.blank = params.blank?Float.parseFloat(params.blank):0

        if (!testPaperInstance.save(flush: true)) {
            redirect(action: "questionsList",params: [id:id,questionId:questionId])
            return
        }
        //题目选项更新
        if(questionInstance.type==1||questionInstance.type==2) {
            def optionInstanceList = Options.findAllByQuestions(questionInstance)
            def count = optionInstanceList.size()
            def optionInstance
            for (def i = 0; i < count; i++) {
                optionInstance = optionInstanceList.get(i)
                optionInstance.letter = params.list('letter[' + optionInstance.id + ']').get(0)
                optionInstance.content = params.list('content[' + optionInstance.id + ']').get(0)
                optionInstance.analysis = params.list('analysis[' + optionInstance.id + ']').get(0)
                optionInstance.score = params.list('score[' + optionInstance.id + ']').get(0).toLong()
                if (!optionInstance.save(flush: true)) {
                    redirect(action: "questionsList", id: id)
                    return
                }
            }
        }
        redirect(action: "questionsList", id: id)
    }
    /*
    * 题目删除
    * 参数
    * questionId（题目ID）
    * */
    def questionDelete(Long questionId){
        def questionInstance = Questions.get(questionId)
        if (!questionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), questionId])
            redirect(action: "questionsList", id: questionInstance.testPapers.id)
            return
        }

        try {
            questionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'question.label', default: 'Question'), questionId])
            redirect(action: "questionsList", id: questionInstance.testPapers.id)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), questionId])
            redirect(action: "questionsList", id: questionInstance.testPapers.id)
        }
    }
//  架构示例图
    def frameworkImgList(Integer max){
        params.max = Math.min(max ?: 10, 100)
        [frameworkImgInstanceList: FrameworkImg.list(params), frameworkImgInstanceTotal: FrameworkImg.count()]
    }
    def frameworkImgCreate(){
        [frameworkImgInstance: new FrameworkImg(params)]
    }
    def frameworkImgSave(){
        def frameworkImgInstance = new FrameworkImg(params)
        def  fileName
        MultipartFile f = request.getFile('file')
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

            frameworkImgInstance.img=fileName
        }
        if(!frameworkImgInstance.save(flush: true)){
            render(view: "frameworkImgCreate",model: [frameworkImgInstance: frameworkImgInstance])
        }

        flash.message =message(code: 'default.created.message', args: [message(code: 'frameworkImg.label', default: 'FrameworkImg'), frameworkImgInstance.id])
        redirect(action: "frameworkImgShow", id:frameworkImgInstance.id)
    }
    def frameworkImgShow(Long id) {
        def frameworkImgInstance = FrameworkImg.get(id)
        if (!frameworkImgInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'frameworkImg.label', default: 'FrameworkImg'), id])
            redirect(action: "frameworkList")
            return
        }

        [frameworkImgInstance: frameworkImgInstance]
    }
    def frameworkImgDelete(Long id){
        def frameworkImgInstance = FrameworkImg.get(id)
        if (!frameworkImgInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'frameworkImg.label', default: 'FrameworkImg'), id])
            redirect(action: "frameworkList")
            return
        }

        try {
            frameworkImgInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'frameworkImg.label', default: 'FrameworkImg'), id])
            redirect(action: "frameworkList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'frameworkImg.label', default: 'FrameworkImg'), id])
            redirect(action: "frameworkImgShow", id: id)
        }
    }
    def frameworkImgEdit(Long id){
        def frameworkImgInstance = FrameworkImg.get(id)
        [frameworkImgInstance: frameworkImgInstance]
    }
    def frameworkImgUpdate(Long id, Long version){
        def frameworkImgInstance = FrameworkImg.get(id)
        def  fileName
        MultipartFile f = request.getFile('file')
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
            frameworkImgInstance.img=fileName
        }



        if (!frameworkImgInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'frameworkImg.label', default: 'FrameworkImg'), id])
            redirect(action: "frameworkImgShow", id: frameworkImgInstance.id)
            return
        }

        if (version != null) {
            if (frameworkImgInstance.version > version) {
                frameworkImgInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'frameworkImg.label', default: 'FrameworkImg')] as Object[],
                        "Another user has updated this Book while you were editing")
                render(view: "frameworkImgEdit", model: [frameworkImgInstance: frameworkImgInstance])
                return
            }
        }

        frameworkImgInstance.properties = params


        if (!frameworkImgInstance.save(flush: true)) {
            render(view: "frameworkImgEdit", model: [frameworkImgInstance: frameworkImgInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'frameworkImg.label', default: 'FrameworkImg'), frameworkImgInstance.id])
        redirect(action: "frameworkImgShow", id: frameworkImgInstance.id)

    }
//    框架默认部门
    def frameworkDepartmentList(Integer max){
        params.max = Math.min(max ?: 10, 100)
        [frameworkDepartmentInstanceList:FrameworkDepartment.list(params), frameworkDepartmentInstanceTotal: FrameworkDepartment.count()]
    }
    def frameworkDepartmentCreate(){

        [frameworkDepartmentInstance: new FrameworkDepartment(params)]
    }
    def frameworkDepartmentSave(){
        def frameworkDepartmentInstance = new FrameworkDepartment(params)
        if (!frameworkDepartmentInstance.save(flush: true)) {
            render(view: "frameworkDepartmentCreate")
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'frameworkDepartment.label', default: 'FrameworkDepartment'), frameworkDepartmentInstance.id])
        redirect(action: "frameworkDepartmentShow", id: frameworkDepartmentInstance.id)
    }
    def frameworkDepartmentShow(Long id) {

        def frameworkDepartmentInstance = FrameworkDepartment.get(id)
        if (!frameworkDepartmentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'frameworkDepartment.label', default: 'FrameworkDepartment'), id])
            redirect(action: "frameworkDepartmentList")
            return
        }

        [frameworkDepartmentInstance: frameworkDepartmentInstance]
    }
    def frameworkDepartmentEdit(Long id) {
        def frameworkDepartmentInstance = FrameworkDepartment.get(id)
        if (!frameworkDepartmentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'frameworkDepartment.label', default: 'FrameworkDepartment'), id])
            redirect(action: "frameworkDepartmentList")
            return
        }

        [frameworkDepartmentInstance: frameworkDepartmentInstance]
    }
    def frameworkDepartmentUpdate(Long id, Long version) {
        def frameworkDepartmentInstance = FrameworkDepartment.get(id)
        if (!frameworkDepartmentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'frameworkDepartment.label', default: 'FrameworkDepartment'), id])
            redirect(action: "frameworkDepartmentList")
            return
        }

        if (version != null) {
            if (frameworkDepartmentInstance.version > version) {
                frameworkDepartmentInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'frameworkDepartment.label', default: 'FrameworkDepartment')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "frameworkDepartmentEdit", model: [frameworkDepartmentInstance: frameworkDepartmentInstance])
                return
            }
        }

        frameworkDepartmentInstance.properties = params

        if (!frameworkDepartmentInstance.save(flush: true)) {
            render(view: "frameworkDepartmentEdit", model: [frameworkDepartmentInstance: frameworkDepartmentInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'frameworkDepartment.label', default: 'FrameworkDepartment'), frameworkDepartmentInstance.id])
        redirect(action: "frameworkDepartmentShow", id: frameworkDepartmentInstance.id)
    }
    def  frameworkDepartmentDelete(Long id) {
        def frameworkDepartmentInstance = FrameworkDepartment.get(id)
        if (!frameworkDepartmentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'frameworkDepartment.label', default: 'FrameworkDepartment'), id])
            redirect(action: "frameworkDepartmentList")
            return
        }

        try {
            frameworkDepartmentInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'frameworkDepartment.label', default: 'FrameworkDepartment'), id])
            redirect(action: "bumenList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'frameworkDepartment.label', default: 'FrameworkDepartment'), id])
            redirect(action: "bumenShow", id: id)
        }
    }
 }
