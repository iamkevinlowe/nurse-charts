class UsersController < ApplicationController

  def show
   @id = params[:id]
   render :show
  end

end