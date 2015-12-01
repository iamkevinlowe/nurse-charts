class PatientsController < ApplicationController

  def show
    @id = params[:id]
    render :show
  end

end