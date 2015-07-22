package com.guihuabao

import grails.converters.JSON

class UploadController {

    def index() { }
    def upload(){
        def rs=[msg:""]
        def frequencyInstance = Frequency.get(params.id)
        if (!frequencyInstance) {
        }
        frequencyInstance.properties = params

        if (!frequencyInstance.save(flush: true)) {
            rs.msg="保存失败"
        }
        rs.msg="保存成功"
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
}
