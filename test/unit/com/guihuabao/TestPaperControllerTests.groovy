package com.guihuabao


import org.junit.*
import grails.test.mixin.*

@TestFor(TestPaperController)
@Mock(TestPaper)
class TestPaperControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/testPaper/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.testPaperInstanceList.size() == 0
        assert model.testPaperInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.testPaperInstance != null
    }

    void testSave() {
        controller.save()

        assert model.testPaperInstance != null
        assert view == '/testPaper/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/testPaper/show/1'
        assert controller.flash.message != null
        assert TestPaper.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/testPaper/list'

        populateValidParams(params)
        def testPaper = new TestPaper(params)

        assert testPaper.save() != null

        params.id = testPaper.id

        def model = controller.show()

        assert model.testPaperInstance == testPaper
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/testPaper/list'

        populateValidParams(params)
        def testPaper = new TestPaper(params)

        assert testPaper.save() != null

        params.id = testPaper.id

        def model = controller.edit()

        assert model.testPaperInstance == testPaper
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/testPaper/list'

        response.reset()

        populateValidParams(params)
        def testPaper = new TestPaper(params)

        assert testPaper.save() != null

        // test invalid parameters in update
        params.id = testPaper.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/testPaper/edit"
        assert model.testPaperInstance != null

        testPaper.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/testPaper/show/$testPaper.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        testPaper.clearErrors()

        populateValidParams(params)
        params.id = testPaper.id
        params.version = -1
        controller.update()

        assert view == "/testPaper/edit"
        assert model.testPaperInstance != null
        assert model.testPaperInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/testPaper/list'

        response.reset()

        populateValidParams(params)
        def testPaper = new TestPaper(params)

        assert testPaper.save() != null
        assert TestPaper.count() == 1

        params.id = testPaper.id

        controller.delete()

        assert TestPaper.count() == 0
        assert TestPaper.get(testPaper.id) == null
        assert response.redirectedUrl == '/testPaper/list'
    }
}
