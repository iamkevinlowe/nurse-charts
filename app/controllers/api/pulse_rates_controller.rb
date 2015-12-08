class Api::PulseRatesController < ApplicationController

  def create
    pulse_rate = PulseRate.new(pulse_rate_params)
    authorize pulse_rate
    pulse_rate.save
    render json: pulse_rate
  end

  private

  def pulse_rate_params
    params.require(:pulse_rate).permit(:vital_id, :bpm)
  end

end