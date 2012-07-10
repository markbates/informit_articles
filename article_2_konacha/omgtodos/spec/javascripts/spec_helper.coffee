# Require the appropriate asset-pipeline files:
#= require application
#= require support/sinon
#= require_tree ./support

# Any other testing specific code here...
# Custom matchers, etc....

Konacha.mochaOptions.ignoreLeaks = true

beforeEach ->
  window.page = $("#konacha")  

  @$ = (selector) =>
    $(selector, page)