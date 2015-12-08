class Api::TemperaturesController < ApplicationController

  def create
    temperature = Temperature.new(temperature_params)
    authorize temperature
    temperature.save
    render json: temperature
  end

  private

  def temperature_params
    params.require(:temperature).permit(:vital_id, :celsius)
  end

end