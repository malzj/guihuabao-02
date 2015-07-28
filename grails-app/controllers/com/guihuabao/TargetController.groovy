package com.guihuabao

import org.springframework.dao.DataIntegrityViolationException

class TargetController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [targetInstanceList: Target.list(params), targetInstanceTotal: Target.count()]
    }

    def create() {
        [targetInstance: new Target(params)]
    }

    def save() {
        def targetInstance = new Target(params)
        if (!targetInstance.save(flush: true)) {
            render(view: "create", model: [targetInstance: targetInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'target.label', default: 'Target'), targetInstance.id])
        redirect(action: "show", id: targetInstance.id)
    }

    def show(Long id) {
        def targetInstance = Target.get(id)
        if (!targetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'target.label', default: 'Target'), id])
            redirect(action: "list")
            return
        }

        [targetInstance: targetInstance]
    }

    def edit(Long id) {
        def targetInstance = Target.get(id)
        if (!targetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'target.label', default: 'Target'), id])
            redirect(action: "list")
            return
        }

        [targetInstance: targetInstance]
    }

    def update(Long id, Long version) {
        def targetInstance = Target.get(id)
        if (!targetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'target.label', default: 'Target'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (targetInstance.version > version) {
                targetInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'target.label', default: 'Target')] as Object[],
                        "Another user has updated this Target while you were editing")
                render(view: "edit", model: [targetInstance: targetInstance])
                return
            }
        }

        targetInstance.properties = params

        if (!targetInstance.save(flush: true)) {
            render(view: "edit", model: [targetInstance: targetInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'target.label', default: 'Target'), targetInstance.id])
        redirect(action: "show", id: targetInstance.id)
    }

    def delete(Long id) {
        def targetInstance = Target.get(id)
        if (!targetInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'target.label', default: 'Target'), id])
            redirect(action: "list")
            return
        }

        try {
            targetInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'target.label', default: 'Target'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'target.label', default: 'Target'), id])
            redirect(action: "show", id: id)
        }
    }
}
