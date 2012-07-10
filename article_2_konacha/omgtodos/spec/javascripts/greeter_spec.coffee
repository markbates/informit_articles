#= require spec_helper

describe "Greeter", ->
  
  beforeEach ->
    @greeter = new Greeter("Mark")
  
  it "greets someone", ->
    @greeter.greet().should.eql("Hi Mark")