package com.guihuabao



import org.junit.*
import grails.test.mixin.*

@TestFor(SyllabusController)
@Mock(Syllabus)
class SyllabusControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/syllabus/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.syllabusInstanceList.size() == 0
        assert model.syllabusInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.syllabusInstance != null
    }

    void testSave() {
        controller.save()

        assert model.syllabusInstance != null
        assert view == '/syllabus/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/syllabus/show/1'
        assert controller.flash.message != null
        assert Syllabus.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/syllabus/list'

        populateValidParams(params)
        def syllabus = new Syllabus(params)

        assert syllabus.save() != null

        params.id = syllabus.id

        def model = controller.show()

        assert model.syllabusInstance == syllabus
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/syllabus/list'

        populateValidParams(params)
        def syllabus = new Syllabus(params)

        assert syllabus.save() != null

        params.id = syllabus.id

        def model = controller.edit()

        assert model.syllabusInstance == syllabus
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/syllabus/list'

        response.reset()

        populateValidParams(params)
        def syllabus = new Syllabus(params)

        assert syllabus.save() != null

        // test invalid parameters in update
        params.id = syllabus.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/syllabus/edit"
        assert model.syllabusInstance != null

        syllabus.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/syllabus/show/$syllabus.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        syllabus.clearErrors()

        populateValidParams(params)
        params.id = syllabus.id
        params.version = -1
        controller.update()

        assert view == "/syllabus/edit"
        assert model.syllabusInstance != null
        assert model.syllabusInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/syllabus/list'

        response.reset()

        populateValidParams(params)
        def syllabus = new Syllabus(params)

        assert syllabus.save() != null
        assert Syllabus.count() == 1

        params.id = syllabus.id

        controller.delete()

        assert Syllabus.count() == 0
        assert Syllabus.get(syllabus.id) == null
        assert response.redirectedUrl == '/syllabus/list'
    }
}
