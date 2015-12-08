require 'rails_helper'

RSpec.describe Api::IssuesController, type: :controller do
  before :all do
    clear_db

    @user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.safe_email,
      password: Faker::Lorem.characters(8),
      role: 'doctor'
    )

    @issues = []
    5.times { @issues << new_issue }
    @issues.each { |i| i.save }
  end

  before { sign_in @user }

  context "routes" do
    it { should route(:post, '/api/issues').to(action: :create) }
    it { should_not route(:get, '/api/issues').to(action: :index) }
    it { should_not route(:get, '/api/issues/50').to(action: :show, id: 50) }
    it { should_not route(:put, '/api/issues/50').to(action: :update) }
    it { should_not route(:delete, '/api/issues/50').to(action: :destroy, id: 50) }
  end

  context "params" do
    let(:params) do
      { issue: {
          patient_id: (rand() * 50 + 1).floor,
          user_id: (rand() * 50 + 1).floor,
          careplan_id: (rand() * 50 + 1).floor,
          issue_id: (rand() * 50 + 1).floor,
          goal_id: (rand() * 50 + 1).floor,
          report_id: (rand() * 50 + 1).floor,
          activity: Faker::Lorem.word,
          name: Faker::Lorem.word,
          alert: (rand() * 50 + 1).floor,
          notes: Faker::Lorem.paragraph
        }
      }
    end

    it "permits attributes" do
      should permit(:careplan_id, :name)
        .for(:create, params: params)
        .on(:issue)
    end

    it "does not permit attributes" do
      should_not permit(:patient_id, :user_id, :issue_id, :goal_id, :report_id, :activity, :alert, :notes)
        .for(:create, params: params)
        .on(:issue)
    end
  end

  describe "#create" do
    let(:issue) { new_issue }

    before { post :create, issue: issue.as_json, format: :json }

    it "returns the issue's response" do
      parsed_json = JSON.parse(response.body)

      expect(parsed_json['careplan_id']).to eql(issue.careplan_id)
      expect(parsed_json['name']).to eql(issue.name)
    end

    it "increments the issues array" do
      expect(Issue.all.count).to eql(@issues.count + 1)
    end
  end
end

def clear_db
  User.all.delete_all
  Issue.all.delete_all
end

def new_issue
  Issue.new(
    careplan_id: (rand() * 50 + 1).floor,
    name: Faker::Lorem.word
  )
end