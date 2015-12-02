class Api::ReportsController < ApplicationController

  def create
    report = Report.new(report_params)
    authorize report
    report.save
    render json: report
  end

  private

  def report_params
    params.require(:report).permit(:patient_id, :user_id, :issue_id, :alert, :notes)
  end

end