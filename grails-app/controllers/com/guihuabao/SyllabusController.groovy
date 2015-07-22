package com.guihuabao

import org.springframework.dao.DataIntegrityViolationException

class SyllabusController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [syllabusInstanceList: Syllabus.list(params), syllabusInstanceTotal: Syllabus.count()]
    }

    def create() {
        [syllabusInstance: new Syllabus(params)]
    }

    def save() {
        def syllabusInstance = new Syllabus(params)
        if (!syllabusInstance.save(flush: true)) {
            render(view: "create", model: [syllabusInstance: syllabusInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), syllabusInstance.id])
        redirect(action: "show", id: syllabusInstance.id)
    }

    def show(Long id) {
        def syllabusInstance = Syllabus.get(id)
        if (!syllabusInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), id])
            redirect(action: "list")
            return
        }

        [syllabusInstance: syllabusInstance]
    }

    def edit(Long id) {
        def syllabusInstance = Syllabus.get(id)
        if (!syllabusInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), id])
            redirect(action: "list")
            return
        }

        [syllabusInstance: syllabusInstance]
    }

    def update(Long id, Long version) {
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
        redirect(action: "show", id: syllabusInstance.id)
    }

    def delete(Long id) {
        def syllabusInstance = Syllabus.get(id)
        if (!syllabusInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), id])
            redirect(action: "list")
            return
        }

        try {
            syllabusInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'syllabus.label', default: 'Syllabus'), id])
            redirect(action: "show", id: id)
        }
    }
}
