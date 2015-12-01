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
    patient ? (render json: patient) : (head :no_content)
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