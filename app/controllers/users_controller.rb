class UsersController < ApplicationController

  def index
  end

  def show
   @id = params[:id]
   render :show
  end

end