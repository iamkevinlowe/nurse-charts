class Api::BloodPressuresController < ApplicationController

  def create
    blood_pressure = BloodPressure.new(blood_pressure_params)
    authorize blood_pressure
    blood_pressure.save
    render json: blood_pressure
  end

  private

  def blood_pressure_params
    params.require(:blood_pressure).permit(:vital_id, :systolic, :diastolic)
  end

end