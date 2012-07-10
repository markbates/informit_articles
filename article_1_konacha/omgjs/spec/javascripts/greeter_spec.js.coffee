#= require application

describe "Greeter", ->

  it "says hello", ->
    greeter = new Greeter()
    greeter.sayHello("Mark").should.eql("Hello Mark!")