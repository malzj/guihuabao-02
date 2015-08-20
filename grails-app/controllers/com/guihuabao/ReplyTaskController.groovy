package com.guihuabao

import org.springframework.dao.DataIntegrityViolationException

class ReplyTaskController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [replyTaskInstanceList: ReplyTask.list(params), replyTaskInstanceTotal: ReplyTask.count()]
    }

    def create() {
        [replyTaskInstance: new ReplyTask(params)]
    }

    def save() {
        def replyTaskInstance = new ReplyTask(params)
        if (!replyTaskInstance.save(flush: true)) {
            render(view: "create", model: [replyTaskInstance: replyTaskInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'replyTask.label', default: 'ReplyTask'), replyTaskInstance.id])
        redirect(action: "show", id: replyTaskInstance.id)
    }

    def show(Long id) {
        def replyTaskInstance = ReplyTask.get(id)
        if (!replyTaskInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'replyTask.label', default: 'ReplyTask'), id])
            redirect(action: "list")
            return
        }

        [replyTaskInstance: replyTaskInstance]
    }

    def edit(Long id) {
        def replyTaskInstance = ReplyTask.get(id)
        if (!replyTaskInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'replyTask.label', default: 'ReplyTask'), id])
            redirect(action: "list")
            return
        }

        [replyTaskInstance: replyTaskInstance]
    }

    def update(Long id, Long version) {
        def replyTaskInstance = ReplyTask.get(id)
        if (!replyTaskInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'replyTask.label', default: 'ReplyTask'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (replyTaskInstance.version > version) {
                replyTaskInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'replyTask.label', default: 'ReplyTask')] as Object[],
                        "Another user has updated this ReplyTask while you were editing")
                render(view: "edit", model: [replyTaskInstance: replyTaskInstance])
                return
            }
        }

        replyTaskInstance.properties = params

        if (!replyTaskInstance.save(flush: true)) {
            render(view: "edit", model: [replyTaskInstance: replyTaskInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'replyTask.label', default: 'ReplyTask'), replyTaskInstance.id])
        redirect(action: "show", id: replyTaskInstance.id)
    }

    def delete(Long id) {
        def replyTaskInstance = ReplyTask.get(id)
        if (!replyTaskInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'replyTask.label', default: 'ReplyTask'), id])
            redirect(action: "list")
            return
        }

        try {
            replyTaskInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'replyTask.label', default: 'ReplyTask'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'replyTask.label', default: 'ReplyTask'), id])
            redirect(action: "show", id: id)
        }
    }
}
