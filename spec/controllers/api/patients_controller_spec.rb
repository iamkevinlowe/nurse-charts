require 'rails_helper'
require 'faker'

RSpec.describe Api::PatientsController, type: :controller do

  context "routes" do
    it { should route(:get, '/api/patients').to(action: :index) }
    it { should route(:get, '/api/patients/50').to(action: :show, id: 50) }
    it { should route(:post, '/api/patients').to(action: :create) }
    it { should route(:post, '/api/patients/find').to(action: :find) }
    it { should_not route(:delete, '/api/patients/50').to(action: :destroy, id: 50) }
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
        patient: {
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
      should permit(:first_name, :last_name, :hospital_id, :room_number)
        .for(:create, params: @params)
        .on(:patient)
    end

    it "does not permit attributes" do
      sign_in @user
      should_not permit(:email, :password, :role)
        .for(:create, params: @params)
        .on(:patient)
    end
  end

end
