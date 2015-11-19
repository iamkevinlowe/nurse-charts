class Api::UsersController < ApplicationController

  def index
    users = policy_scope(User)
    authorize users
    render json: users
  end

end