class Api::GoalsController < ApplicationController

  def create
    goal = Goal.new(goal_params)
    authorize goal
    goal.save
    render json: goal
  end

  private

  def goal_params
    params.require(:goal).permit(:activity, :issue_id)
  end

end