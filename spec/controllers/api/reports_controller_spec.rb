require 'rails_helper'

RSpec.describe Api::ReportsController, type: :controller do

  context "routes" do
    it { should route(:post, '/api/reports').to(action: :create) }
    it { should_not route(:get, '/api/reports').to(action: :index) }
    it { should_not route(:get, '/api/reports/50').to(action: :show, id: 50) }
    it { should_not route(:put, '/api/reports/50').to(action: :update) }
    it { should_not route(:delete, '/api/reports/50').to(action: :destroy, id: 50) }
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
        report: {
          patient_id: rand() * 50 + 1,
          user_id: rand() * 50 + 1,
          careplan_id: rand() * 50 + 1,
          issue_id: rand() * 50 + 1,
          goal_id: rand() * 50 + 1,
          report_id: rand() * 50 + 1,
          activity: Faker::Lorem.word,
          name: Faker::Lorem.word,
          alert: rand() * 50 + 1,
          notes: Faker::Lorem.paragraph
        }
      }
    end

    it "permits attributes" do
      sign_in @user
      should permit(:patient_id, :user_id, :issue_id, :alert, :notes)
        .for(:create, params: @params)
        .on(:report)
    end

    it "does not permit attributes" do
      sign_in @user
      should_not permit(:careplan_id, :goal_id, :report_id, :activity, :name)
        .for(:create, params: @params)
        .on(:report)
    end
  end

end
