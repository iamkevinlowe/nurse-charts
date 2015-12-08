class Api::PatientsController < ApplicationController

  def index
    patients = policy_scope(Patient)
    authorize patients
    render json: patients
  end

  def find
    patient = Patient.where(
      "first_name = ? AND
      last_name = ? AND
      room_number = ?",
      params[:first_name],
      params[:last_name],
      params[:room_number]
    ).first

    if patient
      render json: patient
    else
      render json: { error: "Could not find patient." }, status: 404
    end
  end

  def show
    begin
      patient = Patient.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: 404
      return
    end

    authorize patient
    render json: patient
  end

  def create
    patient = Patient.new(patient_params)
    authorize patient
    patient.save
    render json: patient
  end

  private

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :hospital_id, :room_number)
  end

end