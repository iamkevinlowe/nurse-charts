require 'rails_helper'

RSpec.describe Api::CareplansController, type: :controller do
  before :all do
    clear_db

    @user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.safe_email,
      password: Faker::Lorem.characters(8),
      role: 'doctor'
    )

    @careplans = []
    5.times { @careplans << new_careplan }
    @careplans.each { |c| c.save }
  end

  before { sign_in @user }

  context "routes" do
    it { should route(:post, '/api/careplans').to(action: :create) }
    it { should_not route(:get, '/api/careplans').to(action: :index) }
    it { should_not route(:get, '/api/careplans/50').to(action: :show, id: 50) }
    it { should_not route(:put, '/api/careplans/50').to(action: :update, id: 50) }
    it { should_not route(:delete, '/api/careplans/50').to(action: :destroy, id: 50) }
  end

  context "params" do
    let(:params) do
      { careplan: {
          patient_id: (rand * 50 + 1).floor,
          user_id: (rand * 50 + 1).floor,
          careplan_id: (rand * 50 + 1).floor,
          issue_id: (rand * 50 + 1).floor,
          goal_id: (rand * 50 + 1).floor,
          report_id: (rand * 50 + 1).floor,
          activity: Faker::Lorem.word,
          name: Faker::Lorem.word,
          alert: (rand * 50 + 1).floor,
          notes: Faker::Lorem.paragraph
        }
      }
    end

    it "permits attributes" do
      should permit(:patient_id)
        .for(:create, params: params)
        .on(:careplan) 
    end

    it "does not permit attributes" do
      should_not permit(:user_id, :careplan_id, :issue_id, :goal_id, :report_id, :activity, :name, :alert, :notes)
        .for(:create, params: params)
        .on(:careplan)
    end
  end

  describe "#create" do
    let(:careplan) { new_careplan }

    before { post :create, careplan: careplan.as_json, format: :json }

    it "returns the careplan's JSON response" do
      parsed_json = JSON.parse(response.body)

      expect(parsed_json['patient_id']).to eql(careplan.patient_id)
    end

    it "increments the careplans array" do
      expect(Careplan.all.count).to eql(@careplans.count + 1)
    end
  end
end

def clear_db
  User.all.delete_all
  Careplan.all.delete_all
end

def new_careplan
  Careplan.new(
    patient_id: (rand * 50 + 1).floor
  )
end