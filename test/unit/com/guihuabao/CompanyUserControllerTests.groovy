package com.guihuabao



import org.junit.*
import grails.test.mixin.*

@TestFor(CompanyUserController)
@Mock(CompanyUser)
class CompanyUserControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/companyUser/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.companyUserInstanceList.size() == 0
        assert model.companyUserInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.companyUserInstance != null
    }

    void testSave() {
        controller.save()

        assert model.companyUserInstance != null
        assert view == '/companyUser/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/companyUser/show/1'
        assert controller.flash.message != null
        assert CompanyUser.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/companyUser/list'

        populateValidParams(params)
        def companyUser = new CompanyUser(params)

        assert companyUser.save() != null

        params.id = companyUser.id

        def model = controller.show()

        assert model.companyUserInstance == companyUser
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/companyUser/list'

        populateValidParams(params)
        def companyUser = new CompanyUser(params)

        assert companyUser.save() != null

        params.id = companyUser.id

        def model = controller.edit()

        assert model.companyUserInstance == companyUser
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/companyUser/list'

        response.reset()

        populateValidParams(params)
        def companyUser = new CompanyUser(params)

        assert companyUser.save() != null

        // test invalid parameters in update
        params.id = companyUser.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/companyUser/edit"
        assert model.companyUserInstance != null

        companyUser.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/companyUser/show/$companyUser.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        companyUser.clearErrors()

        populateValidParams(params)
        params.id = companyUser.id
        params.version = -1
        controller.update()

        assert view == "/companyUser/edit"
        assert model.companyUserInstance != null
        assert model.companyUserInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/companyUser/list'

        response.reset()

        populateValidParams(params)
        def companyUser = new CompanyUser(params)

        assert companyUser.save() != null
        assert CompanyUser.count() == 1

        params.id = companyUser.id

        controller.delete()

        assert CompanyUser.count() == 0
        assert CompanyUser.get(companyUser.id) == null
        assert response.redirectedUrl == '/companyUser/list'
    }
}
