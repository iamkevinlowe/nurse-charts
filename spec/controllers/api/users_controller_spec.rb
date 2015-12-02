require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do

  context "routes" do
    it { should route(:get, '/api/users').to(action: :index) }
    it { should route(:get, '/api/users/50').to(action: :show, id: 50) }
    it { should route(:post, '/api/users').to(action: :create) }
    it { should_not route(:delete, '/api/users/50').to(action: :destroy, id: 50) }
  end

  context "params" do

    before :example do
      @user = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.safe_email,
        password: Faker::Lorem.characters(8),
        role: 'doctor'
      )
      @params = {
        user: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          hospital_id: rand() * 50 + 1,
          room_number: rand() * 300 + 1,
          email: Faker::Internet.safe_email,
          password: Faker::Lorem.characters(8),
          role: 'nurse'
        }
      }
    end

    it "permits attributes" do
      sign_in @user
      should permit(:first_name, :last_name, :hospital_id, :email, :role)
        .for(:create, params: @params)
        .on(:user)
    end

    it "does not permit attributes" do
      sign_in @user
      should_not permit(:room_number, :password)
        .for(:create, params: @params)
        .on(:user)
    end
  end

end
