package com.guihuabao



import org.junit.*
import grails.test.mixin.*

@TestFor(CompanyNoticeController)
@Mock(CompanyNotice)
class CompanyNoticeControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/companyNotice/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.companyNoticeInstanceList.size() == 0
        assert model.companyNoticeInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.companyNoticeInstance != null
    }

    void testSave() {
        controller.save()

        assert model.companyNoticeInstance != null
        assert view == '/companyNotice/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/companyNotice/show/1'
        assert controller.flash.message != null
        assert CompanyNotice.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/companyNotice/list'

        populateValidParams(params)
        def companyNotice = new CompanyNotice(params)

        assert companyNotice.save() != null

        params.id = companyNotice.id

        def model = controller.show()

        assert model.companyNoticeInstance == companyNotice
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/companyNotice/list'

        populateValidParams(params)
        def companyNotice = new CompanyNotice(params)

        assert companyNotice.save() != null

        params.id = companyNotice.id

        def model = controller.edit()

        assert model.companyNoticeInstance == companyNotice
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/companyNotice/list'

        response.reset()

        populateValidParams(params)
        def companyNotice = new CompanyNotice(params)

        assert companyNotice.save() != null

        // test invalid parameters in update
        params.id = companyNotice.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/companyNotice/edit"
        assert model.companyNoticeInstance != null

        companyNotice.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/companyNotice/show/$companyNotice.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        companyNotice.clearErrors()

        populateValidParams(params)
        params.id = companyNotice.id
        params.version = -1
        controller.update()

        assert view == "/companyNotice/edit"
        assert model.companyNoticeInstance != null
        assert model.companyNoticeInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/companyNotice/list'

        response.reset()

        populateValidParams(params)
        def companyNotice = new CompanyNotice(params)

        assert companyNotice.save() != null
        assert CompanyNotice.count() == 1

        params.id = companyNotice.id

        controller.delete()

        assert CompanyNotice.count() == 0
        assert CompanyNotice.get(companyNotice.id) == null
        assert response.redirectedUrl == '/companyNotice/list'
    }
}
