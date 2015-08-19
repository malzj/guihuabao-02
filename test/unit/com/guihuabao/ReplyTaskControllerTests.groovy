package com.guihuabao



import org.junit.*
import grails.test.mixin.*

@TestFor(ReplyTaskController)
@Mock(ReplyTask)
class ReplyTaskControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/replyTask/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.replyTaskInstanceList.size() == 0
        assert model.replyTaskInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.replyTaskInstance != null
    }

    void testSave() {
        controller.save()

        assert model.replyTaskInstance != null
        assert view == '/replyTask/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/replyTask/show/1'
        assert controller.flash.message != null
        assert ReplyTask.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/replyTask/list'

        populateValidParams(params)
        def replyTask = new ReplyTask(params)

        assert replyTask.save() != null

        params.id = replyTask.id

        def model = controller.show()

        assert model.replyTaskInstance == replyTask
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/replyTask/list'

        populateValidParams(params)
        def replyTask = new ReplyTask(params)

        assert replyTask.save() != null

        params.id = replyTask.id

        def model = controller.edit()

        assert model.replyTaskInstance == replyTask
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/replyTask/list'

        response.reset()

        populateValidParams(params)
        def replyTask = new ReplyTask(params)

        assert replyTask.save() != null

        // test invalid parameters in update
        params.id = replyTask.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/replyTask/edit"
        assert model.replyTaskInstance != null

        replyTask.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/replyTask/show/$replyTask.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        replyTask.clearErrors()

        populateValidParams(params)
        params.id = replyTask.id
        params.version = -1
        controller.update()

        assert view == "/replyTask/edit"
        assert model.replyTaskInstance != null
        assert model.replyTaskInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/replyTask/list'

        response.reset()

        populateValidParams(params)
        def replyTask = new ReplyTask(params)

        assert replyTask.save() != null
        assert ReplyTask.count() == 1

        params.id = replyTask.id

        controller.delete()

        assert ReplyTask.count() == 0
        assert ReplyTask.get(replyTask.id) == null
        assert response.redirectedUrl == '/replyTask/list'
    }
}
