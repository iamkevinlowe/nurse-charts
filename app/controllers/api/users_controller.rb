class Api::UsersController < ApplicationController

  def index
    users = policy_scope(User)
    authorize users
    render json: users
  end

  def show
    begin
      user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: 404
      return
    end
    
    authorize user
    render json: user
  end

  def create
    user = User.new(user_params)
    user.password = 'welcome1'
    authorize user
    user.save
    render json: user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role, :hospital_id)
  end

end