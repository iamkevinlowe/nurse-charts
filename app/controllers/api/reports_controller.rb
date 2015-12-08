class Api::ReportsController < ApplicationController
  before_filter :find_activity

  def create
    report = @activity.reports.build(report_params)
    authorize report
    report.save
    render json: report
  end

  private

  def find_activity
    klass = params[:report][:activity_type].capitalize.constantize
    @activity = klass.find(params[:report][:activity_id])
  end

  def report_params
    params.require(:report).permit(:patient_id, :user_id, :alert, :notes)
  end
end