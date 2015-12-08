require 'rails_helper'

RSpec.describe Api::GoalsController, type: :controller do
  before :all do
    clear_db

    @user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.safe_email,
      password: Faker::Lorem.characters(8),
      role: 'doctor'
    )

    @goals = []
    5.times { @goals << new_goal }
    @goals.each { |g| g.save }
  end

  before { sign_in @user }

  context "routes" do
    it { should route(:post, '/api/goals').to(action: :create) }
    it { should_not route(:get, '/api/goals').to(action: :index) }
    it { should_not route(:get, '/api/goals/50').to(action: :show, id: 50) }
    it { should_not route(:put, '/api/goals/50').to(action: :update, id: 50) }
    it { should_not route(:delete, '/api/goals/50').to(action: :destroy, id: 50) }
  end

  context "params" do
    let(:params) do
      { goal: {
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
      should permit(:issue_id, :activity)
        .for(:create, params: params)
        .on(:goal)
    end

    it "does not permit attributes" do
      should_not permit(:patient_id, :user_id, :careplan_id, :goal_id, :report_id, :name, :alert, :notes)
        .for(:create, params: params)
        .on(:goal)
    end
  end

  describe "#create" do
    let(:goal) { new_goal }

    before { post :create, goal: goal.as_json, format: :json }

    it "returns the goal's JSON response" do
      parsed_json = JSON.parse(response.body)

      expect(parsed_json['issue_id']).to eql(goal.issue_id)
      expect(parsed_json['activity']).to eql(goal.activity)
    end

    it "increments the goals array" do
      expect(Goal.all.count).to eql(@goals.count + 1)
    end
  end
end

def clear_db
  User.all.delete_all
  Goal.all.delete_all
end

def new_goal
  Goal.new(
    issue_id: (rand() * 50 + 1).floor,
    activity: Faker::Lorem.word
  )
end