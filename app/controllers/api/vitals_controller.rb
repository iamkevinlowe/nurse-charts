class Api::VitalsController < ApplicationController

  def create
    vital = Vital.new(vital_params)
    authorize vital
    vital.save
    render json: vital
  end

  private

  def vital_params
    params.require(:vital).permit(:patient_id)
  end

end