import com.guihuabao.Banben
import com.guihuabao.Clause
import com.guihuabao.FunIntroduction
import com.guihuabao.IndexImg
import com.guihuabao.Inform
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



        def destroy = {

        }



    }
}