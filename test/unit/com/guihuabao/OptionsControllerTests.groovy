package com.guihuabao


import org.junit.*
import grails.test.mixin.*

@TestFor(OptionsController)
@Mock(Options)
class OptionsControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/options/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.optionsInstanceList.size() == 0
        assert model.optionsInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.optionsInstance != null
    }

    void testSave() {
        controller.save()

        assert model.optionsInstance != null
        assert view == '/options/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/options/show/1'
        assert controller.flash.message != null
        assert Options.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/options/list'

        populateValidParams(params)
        def options = new Options(params)

        assert options.save() != null

        params.id = options.id

        def model = controller.show()

        assert model.optionsInstance == options
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/options/list'

        populateValidParams(params)
        def options = new Options(params)

        assert options.save() != null

        params.id = options.id

        def model = controller.edit()

        assert model.optionsInstance == options
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/options/list'

        response.reset()

        populateValidParams(params)
        def options = new Options(params)

        assert options.save() != null

        // test invalid parameters in update
        params.id = options.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/options/edit"
        assert model.optionsInstance != null

        options.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/options/show/$options.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        options.clearErrors()

        populateValidParams(params)
        params.id = options.id
        params.version = -1
        controller.update()

        assert view == "/options/edit"
        assert model.optionsInstance != null
        assert model.optionsInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/options/list'

        response.reset()

        populateValidParams(params)
        def options = new Options(params)

        assert options.save() != null
        assert Options.count() == 1

        params.id = options.id

        controller.delete()

        assert Options.count() == 0
        assert Options.get(options.id) == null
        assert response.redirectedUrl == '/options/list'
    }
}
