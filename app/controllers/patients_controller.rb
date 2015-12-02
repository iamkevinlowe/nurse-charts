class PatientsController < ApplicationController

  def show
    @id = params[:id]
  end

end