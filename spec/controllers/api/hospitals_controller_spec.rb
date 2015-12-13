require 'rails_helper'

RSpec.describe Api::HospitalsController, type: :controller do
  before do
    @user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.safe_email,
      password: Faker::Lorem.characters(8),
      role: 'doctor'
    )

    @hospitals = []
    5.times { new_hospital }
    @hospitals.each { |h| h.save }
  end

  before { sign_in @user }

  context "routes" do
    it { should route(:get, '/api/hospitals').to(action: :index) }
    it { should_not route(:get, '/api/hospitals/50').to(action: :show, id: 50) }
    it { should_not route(:post, '/api/hospitals').to(action: :create) }
    it { should_not route(:put, '/api/hospitals/50').to(action: :update, id: 50) }
    it { should_not route(:delete, '/api/hospitals/50').to(action: :destroy, id: 50) }
  end

  describe "#index" do
    it "returns all hospital's JSON responses" do
      get :index, format: :json
      parsed_json = JSON.parse(response.body)
      expect(parsed_json.count).to eql(@hospitals.count)
    end
  end
end

def new_hospital
  Hospital.new(
    name: Faker::Company.name,
    phone: Faker::PhoneNumber.phone_number
  )
end