package com.guihuabao


import org.junit.*
import grails.test.mixin.*

@TestFor(TargetController)
@Mock(Target)
class TargetControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/target/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.targetInstanceList.size() == 0
        assert model.targetInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.targetInstance != null
    }

    void testSave() {
        controller.save()

        assert model.targetInstance != null
        assert view == '/target/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/target/show/1'
        assert controller.flash.message != null
        assert Target.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/target/list'

        populateValidParams(params)
        def target = new Target(params)

        assert target.save() != null

        params.id = target.id

        def model = controller.show()

        assert model.targetInstance == target
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/target/list'

        populateValidParams(params)
        def target = new Target(params)

        assert target.save() != null

        params.id = target.id

        def model = controller.edit()

        assert model.targetInstance == target
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/target/list'

        response.reset()

        populateValidParams(params)
        def target = new Target(params)

        assert target.save() != null

        // test invalid parameters in update
        params.id = target.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/target/edit"
        assert model.targetInstance != null

        target.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/target/show/$target.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        target.clearErrors()

        populateValidParams(params)
        params.id = target.id
        params.version = -1
        controller.update()

        assert view == "/target/edit"
        assert model.targetInstance != null
        assert model.targetInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/target/list'

        response.reset()

        populateValidParams(params)
        def target = new Target(params)

        assert target.save() != null
        assert Target.count() == 1

        params.id = target.id

        controller.delete()

        assert Target.count() == 0
        assert Target.get(target.id) == null
        assert response.redirectedUrl == '/target/list'
    }
}
