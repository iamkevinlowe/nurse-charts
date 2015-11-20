class Api::HospitalsController < ApplicationController

  def index
    hospitals = Hospital.all
    authorize hospitals
    render json: hospitals
  end

  def show
    hospital = Hospital.find(params[:id])
    authorize hospital
    render json: hospital
  end

end