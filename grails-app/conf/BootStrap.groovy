import com.guihuabao.Banben
import com.guihuabao.Clause
import com.guihuabao.FunIntroduction
import com.guihuabao.IndexImg
import com.guihuabao.Inform
import com.guihuabao.Persona
import com.guihuabao.User

class BootStrap {

    def init = { servletContext ->
        def bookUserInstance = User.findByUsername("hexuadmin")
        if(!bookUserInstance){
            bookUserInstance=new User()
            bookUserInstance.username="hexuadmin"
            bookUserInstance.password="hexuadmin"
            bookUserInstance.rid=1
            if(bookUserInstance.save(flush: true)){
                print(1)
            }else (
                    print(2)
            )

        }
        def funIntroduction = FunIntroduction.findAll()
        if(!funIntroduction){
            funIntroduction=new FunIntroduction()
            funIntroduction.dateCreate=new Date()
            funIntroduction.introduction="1"
            if(funIntroduction.save(flush: true)){
                print(1)
            }else (
                    print(2)
            )
        }
        def inform = Inform.findAll()
        if(!inform){
            inform=new Inform()
            inform.dateCreate=new Date()
            inform.introduction="1"
            if(inform.save(flush: true)){
                print(1)
            }else (
                    print(2)
            )
        }
        def banben = Banben.findAll()
        if(!banben){
            banben=new Banben()
            banben.dateCreate=new Date()
            banben.introduction="1"
            if(banben.save(flush: true)){
                print(1)
            }else (
                    print(2)
            )
        }
        def clause = Clause.findAll()
        if(!clause){
            clause=new Clause()
            clause.dateCreate=new Date()
            clause.introduction="1"
            if(clause.save(flush: true)){
                print(1)
            }else (
                    print(2)
            )
        }
        def indexImg = IndexImg.findAll()
        if(!indexImg){
            indexImg=new IndexImg()
            indexImg.dateCreate=new Date()
            indexImg.img=""
            if(indexImg.save(flush: true)){
                print(1)
            }else (
                    print(2)
            )
        }

        def persona0= Persona.get(0)
        if(!persona0){
            persona0=new Persona()
            persona0.name="管理员"
            if(persona0.save(flush: true)){
                print(1)
            }else (
                    print(2)
            )
        }
            def persona1= Persona.get(1)
            if(!persona1){
                persona1=new Persona()
                persona1.name="董事长"
                if(persona1.save(flush: true)){
                    print(1)
                }else (
                        print(2)
                )
            }
        def persona2= Persona.get(2)
        if(!persona2){
            persona2=new Persona()
            persona2.name="经理"
            if(persona2.save(flush: true)){
                print(1)
            }else (
                    print(2)
            )
        }
        def persona3= Persona.get(3)
        if(!persona3){
            persona3=new Persona()
            persona3.name="员工"
            if(persona3.save(flush: true)){
                print(1)
            }else (
                    print(2)
            )
        }



        def destroy = {

                        }

    }


                }