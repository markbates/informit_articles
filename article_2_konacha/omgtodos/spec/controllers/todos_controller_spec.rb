require 'spec_helper'

describe TodosController do

  let(:todo) { Factory(:todo) }

  describe 'index' do
    
    context "HTML" do
      
      it "renders the HTML page" do
        get :index

        response.should render_template(:index)
        assigns(:todos).should be_nil
      end

    end

    context "JSON" do
      
      it "returns JSON for the todos" do
        get :index, format: "json"

        response.should_not render_template(:index)
        assigns(:todos).should_not be_nil
      end

    end

  end

  describe 'show' do
    
    context "JSON" do
      
      it "returns the todo" do
        get :show, id: todo.id, format: 'json'

        response.should be_successful
        response.body.should eql todo.to_json
      end

    end

  end

  describe 'create' do
    
    context "JSON" do
      
      it "creates a new todo" do
        expect {
          post :create, todo: {body: "do something"}, format: 'json'

          response.should be_successful
        }.to change(Todo, :count).by(1)
      end

      it "responds with errors" do
        expect {
          post :create, todo: {}, format: 'json'

          response.should_not be_successful
          json = decode_json(response.body)
          json.errors.should have(1).error
          json.errors.body.should include("can't be blank")
        }.to_not change(Todo, :count)
      end

    end

  end

  describe 'update' do
    
    context "JSON" do
      
      it "updates a todo" do
        put :update, id: todo.id, todo: {body: "do something else"}, format: 'json'

        response.should be_successful
        todo.reload
        todo.body.should eql "do something else"
      end

      it "responds with errors" do
        put :update, id: todo.id, todo: {body: ""}, format: 'json'

        response.should_not be_successful
        json = decode_json(response.body)
        json.errors.should have(1).error
        json.errors.body.should include("can't be blank")
      end

    end

  end

  describe 'destroy' do
    
    context "JSON" do
      
      it "destroys the todo" do
        todo.should_not be_nil
        expect {
          delete :destroy, id: todo.id, format: 'JSON'
        }.to change(Todo, :count).by(-1)
      end

    end

  end

end
