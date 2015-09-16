package com.guihuabao


import org.junit.*
import grails.test.mixin.*

@TestFor(AppsController)
@Mock(Apps)
class AppsControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/apps/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.appsInstanceList.size() == 0
        assert model.appsInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.appsInstance != null
    }

    void testSave() {
        controller.save()

        assert model.appsInstance != null
        assert view == '/apps/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/apps/show/1'
        assert controller.flash.message != null
        assert Apps.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/apps/list'

        populateValidParams(params)
        def apps = new Apps(params)

        assert apps.save() != null

        params.id = apps.id

        def model = controller.show()

        assert model.appsInstance == apps
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/apps/list'

        populateValidParams(params)
        def apps = new Apps(params)

        assert apps.save() != null

        params.id = apps.id

        def model = controller.edit()

        assert model.appsInstance == apps
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/apps/list'

        response.reset()

        populateValidParams(params)
        def apps = new Apps(params)

        assert apps.save() != null

        // test invalid parameters in update
        params.id = apps.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/apps/edit"
        assert model.appsInstance != null

        apps.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/apps/show/$apps.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        apps.clearErrors()

        populateValidParams(params)
        params.id = apps.id
        params.version = -1
        controller.update()

        assert view == "/apps/edit"
        assert model.appsInstance != null
        assert model.appsInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/apps/list'

        response.reset()

        populateValidParams(params)
        def apps = new Apps(params)

        assert apps.save() != null
        assert Apps.count() == 1

        params.id = apps.id

        controller.delete()

        assert Apps.count() == 0
        assert Apps.get(apps.id) == null
        assert response.redirectedUrl == '/apps/list'
    }
}
