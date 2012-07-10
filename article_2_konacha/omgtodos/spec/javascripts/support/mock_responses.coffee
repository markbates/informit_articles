window.MockServer ?= sinon.fakeServer.create()

MockServer.respondWith( 
  "GET",
  "/todos",
  [
    200, 
    { "Content-Type": "application/json" },
    '''
    [
      {"body":"Do something!","completed":false,"id":1}, 
      {"body":"Do something else!","completed":false,"id":2}
    ]'''
  ]
)