package com.guihuabao

class ShowController {

    def index() {}
    def function(){}
    def mobile(){}
    def aboutus(){}
    def contactus(){}
    def everyonesay(){}
    def safe(){}
    def privacy(){}
    def service(){}
    def feedbackSave(){
        def feedbackInfo = new Business(params)
        if (!feedbackInfo.save(flush: true)) {
            render(view: "contactus", model: [feedbackInfo: feedbackInfo])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), syllabusInstance.id])
        redirect(action: "contactus")
    }
}
