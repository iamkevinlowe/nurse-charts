require 'rails_helper'

RSpec.describe Api::ReportsController, type: :controller do
  before :all do
    clear_db

    @user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.safe_email,
      password: Faker::Lorem.characters(8),
      role: 'doctor'
    )

    @reports = []
    5.times { @reports << new_report }
    @reports.each { |r| r.save }
  end

  before { sign_in @user }

  context "routes" do
    it { should route(:post, '/api/reports').to(action: :create) }
    it { should_not route(:get, '/api/reports').to(action: :index) }
    it { should_not route(:get, '/api/reports/50').to(action: :show, id: 50) }
    it { should_not route(:put, '/api/reports/50').to(action: :update) }
    it { should_not route(:delete, '/api/reports/50').to(action: :destroy, id: 50) }
  end

  context "params" do
    let(:params) do
      { report: {
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
      should permit(:patient_id, :user_id, :issue_id, :alert, :notes)
        .for(:create, params: params)
        .on(:report)
    end

    it "does not permit attributes" do
      should_not permit(:careplan_id, :goal_id, :report_id, :activity, :name)
        .for(:create, params: params)
        .on(:report)
    end
  end

  describe "#create" do
    let(:report) { new_report }

    before { post :create, report: report.as_json, format: :JSON }

    it "returns the report's JSON response" do
      parsed_json = JSON.parse(response.body)
      expect(parsed_json['patient_id']).to eql(report.patient_id)
      expect(parsed_json['user_id']).to eql(report.user_id)
      expect(parsed_json['issue_id']).to eql(report.issue_id)
      expect(parsed_json['alert']).to eql(report.alert)
      expect(parsed_json['notes']).to eql(report.notes)      
    end

    it "increments the reports array" do
      expect(Report.all.count).to eql(@reports.count + 1)
    end
  end
end

def clear_db
  User.all.delete_all
  Report.all.delete_all
end

def new_report
  Report.new(
    patient_id: 10,
    user_id: 20,
    issue_id: 30,
    alert: 40,
    notes: "Here are notes"
  )
end