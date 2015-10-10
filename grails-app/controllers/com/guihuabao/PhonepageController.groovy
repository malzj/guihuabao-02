package com.guihuabao

import grails.converters.JSON

class PhonepageController {

    //知识内容详情
    def knowcontent(){
        def id = params.id

        params.max = 1
        params<<[sort:"num", order:"asc"]
        def offset = 0
        def offse
        if (params.offset){
            offset =params.offset.toLong()
        }
        if(offse>0){
            offset = offse
        }
        params<<[offset: offset]
        def contentInfo
        def charpterId
        def syllabusInfo
        def chapter = Chapter.get(id.toInteger())
        def syllabus=chapter.syllabus
        def bookId=chapter.syllabus.book.id
        def contentInfoTotal = Content.countByChapter(Chapter.get(id))
        def bookInstance = Book.get(bookId)
        contentInfo = Content.findByChapter(Chapter.get(id),params)

        if(!contentInfo&&chapter&&syllabus){

            if(offset>0){ //判断是向前翻页，还是向后翻页
                //向后翻页 下一页
                charpterId = Chapter.findByIdGreaterThan(chapter.id,[sort: "id",order: "asc"])?.id //向后翻页时获得后一个章节的id
                if(charpterId){
                    redirect(action: "knowcontent",params: [id: charpterId])
                    return
                }else{//如果没有后一章节，则查找后一大纲的第一章节
                    syllabusInfo = Syllabus.findByIdGreaterThanAndBook(syllabus.id,bookInstance,[sort: "id",order: "asc"]) //获得后一个大纲
                    if(syllabusInfo){//如果后一大纲存在，则获取第一章节id
                        charpterId = Chapter.findBySyllabus(syllabusInfo,[sort: "id",order: "asc"])
                        redirect(action: "knowcontent",params: [id: charpterId])
                        return
                    }else{//如果前一大纲不存在，则返回第一页
                        render(view: "msgshow", model: [contentInfo: [introduction: '已经是最后一页'], contentInfoTotal: contentInfoTotal,offset: offset,id: id])
                        return
                    }
                }
            }
        }else if(contentInfo&&chapter&&syllabus){
            if(offset<0) { //判断是向前翻页，还是向后翻页 上一页
                offset = 0
                charpterId = Chapter.findByIdLessThanAndSyllabus(chapter.id, syllabus, [sort: "id", order: "desc"])?.id
                //向前翻页时获得前一个章节的id
                if (charpterId) {
                    redirect(action: "knowcontent", params: [id: charpterId])
                    return
                } else {//如果没有前一章节，则查找前一大纲的最后一章节
                    syllabusInfo = Syllabus.findByIdLessThanAndBook(syllabus.id, bookInstance, [sort: "id", order: "desc"])
                    //获得前一个大纲
                    if (syllabusInfo) {//如果前一大纲存在，则获取最后一章节id
                        charpterId = Chapter.findBySyllabus(syllabusInfo, [sort: "id", order: "desc"])
                        redirect(action: "knowcontent", params: [id: charpterId])
                        return
                    } else {//如果前一大纲不存在，则返回第一页
                        render(view: "msgshow", model: [contentInfo: [introduction: '已经是第一页'], contentInfoTotal: contentInfoTotal,offset: offset,id: id])
                        return
                    }
                }
            }
        }


//        if(contentInfoTotal>offset){

            if(!contentInfo){
                render(view: "msgshow", model: [contentInfo: [introduction: '已加载所有数据'], contentInfoTotal: contentInfoTotal,offset: offset,id: id])
                return
            }
//        }else{
//            render(view: "msgshow", model: [contentInfo: [introduction: '已加载所有数据'], contentInfoTotal: contentInfoTotal,offset: offset,id: id])
//            return
//        }
        [contentInfo: contentInfo, contentInfoTotal: contentInfoTotal,offset: offset,id: id]
    }


    def knowcontent2(){
        def rs=[:]
        def id = params.id
        params.max = 1
        params<<[sort:"num", order:"asc"]
        def offset = 0

       def offse=params.offset
            if (offse){
            if (offse.toString().toLong()>0){
                offset =offse.toLong()
            }else {
                offset=0;
                rs.s=2
            }
        }


        params<<[offset: offset]

        def contentInfo = Content.findByChapter(Chapter.get(id),params)
        def num=Content.countByChapter(Chapter.get(id))
        def next=0
        def prev=0
        if (offset>=num){

            next=1
        }
        if (offset<=0){
            prev=1
        }
        if (contentInfo){

            rs.contentInfo=contentInfo.introduction
        }else {
            rs.contentInfo="已加载所有数据"
            rs.s=1;
        }
        println(next+'  '+prev)
        rs.next=next
        rs.prev=prev
        rs.offset=offset
        rs.id=id
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON

    }

    //工具内容详情
    def toolcontent(){
        def id = params.id

        params.max = 1
        params<<[sort:"id", order:"asc"]
        def offset = 0
        def offse
        if (params.offset){
            offset =params.offset.toLong()
        }
        if(offse>0){
            offset = offse
        }

        params<<[offset: offset]
        def contentInfo
        def contentInfoTotal = ToolContent.countByHexutools(HexuTool.get(id))
        if(contentInfoTotal>offset){
            contentInfo = ToolContent.findByHexutools(HexuTool.get(id),params)
            if(!contentInfo){
//                redirect(action: "knowcontent",params: [contentInfoList: contentInfoList, contentInfoTotal: contentInfoTotal,offset: offset])
//                return
//            }else{
                render(view: "msgshow", model: [contentInfo: [introduction: '已加载所有数据'], contentInfoTotal: contentInfoTotal,offset: offset,id: id])
                return
            }
        }else{
            render(view: "msgshow", model: [contentInfo: [introduction: '已加载所有数据'], contentInfoTotal: contentInfoTotal,offset: offset,id: id])
            return
        }
        if(offset<0){
            offset=0
            render(view: "msgshow", model: [contentInfo: [introduction: '已加载所有数据'], contentInfoTotal: contentInfoTotal,offset: offset,id: id])
            return
        }
        [contentInfo: contentInfo, contentInfoTotal: contentInfoTotal,offset: offset,id: id]
    }
    def toolcontent2(){
        def rs=[:]
        def id = params.id
        params.max = 1
        params<<[sort:"id", order:"asc"]
        def offset = 0

        def offse=params.offset
        if (offse){
            if (offse.toString().toLong()>0){
                offset =offse.toLong()
            }else {
                offset=0;

            }
        }


        params<<[offset: offset]

        def contentInfo = ToolContent.findByHexutools(HexuTool.get(id),params)
        def n1um=ToolContent.countByHexutools(HexuTool.get(id))
        def next=0
        def prev=0
        println(n1um)
        if (offset>=n1um){
            next=1
        }
        if (offset<=0){
            prev=1
        }
        if (contentInfo){

            rs.contentInfo=contentInfo.introduction
        }else {
            rs.contentInfo="已加载所有数据"

        }
        println(next+'  '+prev)
        rs.next=next
        rs.prev=prev
        rs.offset=offset
        rs.id=id
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON

    }
}
