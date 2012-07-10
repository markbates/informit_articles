#= require spec_helper

describe "Flash", ->

  describe "messages", ->

    beforeEach ->
      page.html("<div id='flash_messages'></div>")

    it "sets a notice message", ->
      Flash.message("notice", "Hello!")
      notice = $("#flash_notice")
      notice.html().should.match(/Hello/)
      notice.should.have.class("alert")
      notice.should.have.class("alert-success")
    
    it "sets an alert message", ->
      Flash.message("alert", "Hello!")
      notice = $("#flash_alert")
      notice.html().should.match(/Hello/)
      notice.should.have.class("alert")
      notice.should.have.class("alert-error")