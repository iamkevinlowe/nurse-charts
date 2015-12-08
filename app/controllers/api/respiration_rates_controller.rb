class Api::RespirationRatesController < ApplicationController

  def create
    respiration_rate = RespirationRate.new(respiration_rate_params)
    authorize respiration_rate
    respiration_rate.save
    render json: respiration_rate
  end

  private

  def respiration_rate_params
    params.require(:respiration_rate).permit(:vital_id, :bpm)
  end

end