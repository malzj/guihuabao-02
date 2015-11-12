package com.guihuabao

import org.springframework.dao.DataIntegrityViolationException

class TestPaperController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [testPaperInstanceList: TestPaper.list(params), testPaperInstanceTotal: TestPaper.count()]
    }

    def create() {
        [testPaperInstance: new TestPaper(params)]
    }

    def save() {
        def testPaperInstance = new TestPaper(params)
        if (!testPaperInstance.save(flush: true)) {
            render(view: "create", model: [testPaperInstance: testPaperInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), testPaperInstance.id])
        redirect(action: "show", id: testPaperInstance.id)
    }

    def show(Long id) {
        def testPaperInstance = TestPaper.get(id)
        if (!testPaperInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), id])
            redirect(action: "list")
            return
        }

        [testPaperInstance: testPaperInstance]
    }

    def edit(Long id) {
        def testPaperInstance = TestPaper.get(id)
        if (!testPaperInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), id])
            redirect(action: "list")
            return
        }

        [testPaperInstance: testPaperInstance]
    }

    def update(Long id, Long version) {
        def testPaperInstance = TestPaper.get(id)
        if (!testPaperInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (testPaperInstance.version > version) {
                testPaperInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'testPaper.label', default: 'TestPaper')] as Object[],
                        "Another user has updated this TestPaper while you were editing")
                render(view: "edit", model: [testPaperInstance: testPaperInstance])
                return
            }
        }

        testPaperInstance.properties = params

        if (!testPaperInstance.save(flush: true)) {
            render(view: "edit", model: [testPaperInstance: testPaperInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), testPaperInstance.id])
        redirect(action: "show", id: testPaperInstance.id)
    }

    def delete(Long id) {
        def testPaperInstance = TestPaper.get(id)
        if (!testPaperInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), id])
            redirect(action: "list")
            return
        }

        try {
            testPaperInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'testPaper.label', default: 'TestPaper'), id])
            redirect(action: "show", id: id)
        }
    }
}
