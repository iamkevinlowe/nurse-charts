class Api::IssuesController < ApplicationController

  def create
    issue = Issue.new(issue_params)
    authorize issue
    issue.save
    render json: issue
  end

  private

  def issue_params
    params.require(:issue).permit(:name, :careplan_id)
  end

end