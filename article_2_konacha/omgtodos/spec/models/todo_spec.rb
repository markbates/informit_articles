require 'spec_helper'

describe Todo do

  it "requires a body" do
    todo = Todo.new
    todo.should_not be_valid
    todo.errors[:body].should include("can't be blank")
    todo.body = "Do something"
    todo.should be_valid
  end

end