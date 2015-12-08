require 'rails_helper'

RSpec.describe Api::PatientsController, type: :controller do
  before :all do
    clear_db

    @user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.safe_email,
      password: Faker::Lorem.characters(8),
      role: 'doctor'
    )

    @patients = []
    5.times { @patients << new_patient }
    @patients.each { |p| p.save }
  end

  before { sign_in @user }

  context "routes" do
    it { should route(:get, '/api/patients').to(action: :index) }
    it { should route(:get, '/api/patients/50').to(action: :show, id: 50) }
    it { should route(:post, '/api/patients').to(action: :create) }
    it { should route(:post, '/api/patients/find').to(action: :find) }
    it { should_not route(:delete, '/api/patients/50').to(action: :destroy, id: 50) }
  end

  context "params" do
    let(:params) do
      { patient: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          hospital_id: (rand * 50 + 1).floor,
          room_number: (rand * 300 + 1).floor,
          email: Faker::Internet.safe_email,
          password: Faker::Lorem.characters(8),
          role: 'nurse'
        }
      }
    end

    it "permits attributes" do
      should permit(:first_name, :last_name, :hospital_id, :room_number)
        .for(:create, params: params)
        .on(:patient)
    end

    it "does not permit attributes" do
      should_not permit(:email, :password, :role)
        .for(:create, params: params)
        .on(:patient)
    end
  end

  describe "#index" do
    it "returns all patient's JSON responses" do
      get :index, format: :json
      parsed_json = JSON.parse(response.body)

      expect(parsed_json.count).to eql(@patients.count)
    end
  end

  describe "#show" do
    context "with a matching patient id" do
      it "returns the patient's JSON response" do
        get :show, id: @patients.last.id, format: :json
        parsed_json = JSON.parse(response.body)

        expect(parsed_json['first_name']).to eql(@patients.last.first_name)
        expect(parsed_json['last_name']).to eql(@patients.last.last_name)
        expect(parsed_json['hospital_id']).to eql(@patients.last.hospital_id)
        expect(parsed_json['room_number']).to eql(@patients.last.room_number)
      end
    end

    context "without a matching patient id" do
      it "returns a '404 - Not Found' error" do
        get :show, id: @patients.last.id + 1, format: :json
        parsed_json = JSON.parse(response.body)

        expect(parsed_json['error']).to_not be_empty
        expect(response.status).to eql(404)
      end
    end
  end

  describe "#create" do
    let(:patient) { new_patient }

    before { post :create, patient: patient.as_json, format: :json }

    it "returns the patient's JSON response" do
      parsed_json = JSON.parse(response.body)

      expect(parsed_json['first_name']).to eql(patient.first_name)
      expect(parsed_json['last_name']).to eql(patient.last_name)
      expect(parsed_json['hospital_id']).to eql(patient.hospital_id)
      expect(parsed_json['room_number']).to eql(patient.room_number)
    end

    it "increments the patient's array" do
      expect(Patient.all.count).to eql(@patients.count + 1)
    end
  end

  describe "#find" do
    context "with a patient matching the attributes" do
      it "returns the patient's JSON response" do
        post :find, @patients.last.as_json, format: :json
        parsed_json = JSON.parse(response.body)

        expect(parsed_json['first_name']).to eql(@patients.last.first_name)
        expect(parsed_json['last_name']).to eql(@patients.last.last_name)
      end
    end

    context "without a patient matching the attributes" do
      it "returns a '404 - Not Found' error" do
        post :find, { room_number: 1000 }, format: :json
        parsed_json = JSON.parse(response.body)

        expect(parsed_json['error']).to_not be_empty
        expect(response.status).to eql(404)
      end
    end
  end
end

def clear_db
  User.all.delete_all
  Patient.all.delete_all
end

def new_patient
  Patient.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    hospital_id: (rand + 50 + 1).floor,
    room_number: (rand + 300 + 1).floor
  )
end