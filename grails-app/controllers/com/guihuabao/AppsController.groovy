package com.guihuabao

import org.springframework.dao.DataIntegrityViolationException

class AppsController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [appsInstanceList: Apps.list(params), appsInstanceTotal: Apps.count()]
    }

    def create() {
        [appsInstance: new Apps(params)]
    }

    def save() {
        def appsInstance = new Apps(params)
        if (!appsInstance.save(flush: true)) {
            render(view: "create", model: [appsInstance: appsInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'apps.label', default: 'Apps'), appsInstance.id])
        redirect(action: "show", id: appsInstance.id)
    }

    def show(Long id) {
        def appsInstance = Apps.get(id)
        if (!appsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'apps.label', default: 'Apps'), id])
            redirect(action: "list")
            return
        }

        [appsInstance: appsInstance]
    }

    def edit(Long id) {
        def appsInstance = Apps.get(id)
        if (!appsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'apps.label', default: 'Apps'), id])
            redirect(action: "list")
            return
        }

        [appsInstance: appsInstance]
    }

    def update(Long id, Long version) {
        def appsInstance = Apps.get(id)
        if (!appsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'apps.label', default: 'Apps'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (appsInstance.version > version) {
                appsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'apps.label', default: 'Apps')] as Object[],
                        "Another user has updated this Apps while you were editing")
                render(view: "edit", model: [appsInstance: appsInstance])
                return
            }
        }

        appsInstance.properties = params

        if (!appsInstance.save(flush: true)) {
            render(view: "edit", model: [appsInstance: appsInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'apps.label', default: 'Apps'), appsInstance.id])
        redirect(action: "show", id: appsInstance.id)
    }

    def delete(Long id) {
        def appsInstance = Apps.get(id)
        if (!appsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'apps.label', default: 'Apps'), id])
            redirect(action: "list")
            return
        }

        try {
            appsInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'apps.label', default: 'Apps'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'apps.label', default: 'Apps'), id])
            redirect(action: "show", id: id)
        }
    }
}
