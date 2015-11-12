package com.guihuabao

import org.springframework.dao.DataIntegrityViolationException

class OptionsController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [optionsInstanceList: Options.list(params), optionsInstanceTotal: Options.count()]
    }

    def create() {
        [optionsInstance: new Options(params)]
    }

    def save() {
        def optionsInstance = new Options(params)
        if (!optionsInstance.save(flush: true)) {
            render(view: "create", model: [optionsInstance: optionsInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'options.label', default: 'Options'), optionsInstance.id])
        redirect(action: "show", id: optionsInstance.id)
    }

    def show(Long id) {
        def optionsInstance = Options.get(id)
        if (!optionsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'options.label', default: 'Options'), id])
            redirect(action: "list")
            return
        }

        [optionsInstance: optionsInstance]
    }

    def edit(Long id) {
        def optionsInstance = Options.get(id)
        if (!optionsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'options.label', default: 'Options'), id])
            redirect(action: "list")
            return
        }

        [optionsInstance: optionsInstance]
    }

    def update(Long id, Long version) {
        def optionsInstance = Options.get(id)
        if (!optionsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'options.label', default: 'Options'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (optionsInstance.version > version) {
                optionsInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'options.label', default: 'Options')] as Object[],
                        "Another user has updated this Options while you were editing")
                render(view: "edit", model: [optionsInstance: optionsInstance])
                return
            }
        }

        optionsInstance.properties = params

        if (!optionsInstance.save(flush: true)) {
            render(view: "edit", model: [optionsInstance: optionsInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'options.label', default: 'Options'), optionsInstance.id])
        redirect(action: "show", id: optionsInstance.id)
    }

    def delete(Long id) {
        def optionsInstance = Options.get(id)
        if (!optionsInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'options.label', default: 'Options'), id])
            redirect(action: "list")
            return
        }

        try {
            optionsInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'options.label', default: 'Options'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'options.label', default: 'Options'), id])
            redirect(action: "show", id: id)
        }
    }
}
