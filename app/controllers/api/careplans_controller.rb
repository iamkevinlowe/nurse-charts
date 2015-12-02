class Api::CareplansController < ApplicationController

  def create
    careplan = Careplan.new(careplan_params)
    authorize careplan
    careplan.save
    render json: careplan
  end

  private

  def careplan_params
    params.require(:careplan).permit(:patient_id)
  end

end