package com.guihuabao

import org.springframework.dao.DataIntegrityViolationException

class CompanyNoticeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [companyNoticeInstanceList: CompanyNotice.list(params), companyNoticeInstanceTotal: CompanyNotice.count()]
    }

    def create() {
        [companyNoticeInstance: new CompanyNotice(params)]
    }

    def save() {
        def companyNoticeInstance = new CompanyNotice(params)
        if (!companyNoticeInstance.save(flush: true)) {
            render(view: "create", model: [companyNoticeInstance: companyNoticeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'companyNotice.label', default: 'CompanyNotice'), companyNoticeInstance.id])
        redirect(action: "show", id: companyNoticeInstance.id)
    }

    def show(Long id) {
        def companyNoticeInstance = CompanyNotice.get(id)
        if (!companyNoticeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'companyNotice.label', default: 'CompanyNotice'), id])
            redirect(action: "list")
            return
        }

        [companyNoticeInstance: companyNoticeInstance]
    }

    def edit(Long id) {
        def companyNoticeInstance = CompanyNotice.get(id)
        if (!companyNoticeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'companyNotice.label', default: 'CompanyNotice'), id])
            redirect(action: "list")
            return
        }

        [companyNoticeInstance: companyNoticeInstance]
    }

    def update(Long id, Long version) {
        def companyNoticeInstance = CompanyNotice.get(id)
        if (!companyNoticeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'companyNotice.label', default: 'CompanyNotice'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (companyNoticeInstance.version > version) {
                companyNoticeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'companyNotice.label', default: 'CompanyNotice')] as Object[],
                        "Another user has updated this CompanyNotice while you were editing")
                render(view: "edit", model: [companyNoticeInstance: companyNoticeInstance])
                return
            }
        }

        companyNoticeInstance.properties = params

        if (!companyNoticeInstance.save(flush: true)) {
            render(view: "edit", model: [companyNoticeInstance: companyNoticeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'companyNotice.label', default: 'CompanyNotice'), companyNoticeInstance.id])
        redirect(action: "show", id: companyNoticeInstance.id)
    }

    def delete(Long id) {
        def companyNoticeInstance = CompanyNotice.get(id)
        if (!companyNoticeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'companyNotice.label', default: 'CompanyNotice'), id])
            redirect(action: "list")
            return
        }

        try {
            companyNoticeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'companyNotice.label', default: 'CompanyNotice'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'companyNotice.label', default: 'CompanyNotice'), id])
            redirect(action: "show", id: id)
        }
    }
}
