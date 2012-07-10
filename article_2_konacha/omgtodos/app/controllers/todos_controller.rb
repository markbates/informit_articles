class TodosController < ApplicationController
  respond_to :html, :json

  def index
    respond_to do |format|
      format.html {}
      format.json do
        @todos = Todo.order("created_at asc")
        respond_with @todos        
      end
    end
  end

  def show
    @todo = Todo.find(params[:id])
    respond_with @todo
  end

  def create
    @todo = Todo.create(params[:todo])
    respond_with @todo
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update_attributes(params[:todo])
    respond_with @todo
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    respond_with @todo
  end

end
