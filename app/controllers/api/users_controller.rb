class Api::UsersController < ApplicationController

  def index
    users = policy_scope(User)
    authorize users
    render json: users
  end

  def show
    user = User.find(params[:id])
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
    params.require(:user).permit(:first_name, :last_name, :email, :role, :hospital_id, :room_number)
  end

end