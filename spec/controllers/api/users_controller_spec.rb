require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  before :all do
    @user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.safe_email,
      password: Faker::Lorem.characters(8),
      role: 'doctor'
    )

    @users = User.all
  end

  before { sign_in @user }

  context "routes" do
    it { should route(:get, '/api/users').to(action: :index) }
    it { should route(:get, '/api/users/50').to(action: :show, id: 50) }
    it { should route(:post, '/api/users').to(action: :create) }
    it { should_not route(:delete, '/api/users/50').to(action: :destroy, id: 50) }
  end

  context "params" do
    let (:params) do
      { user: {
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
      should permit(:first_name, :last_name, :hospital_id, :email, :role)
        .for(:create, params: params)
        .on(:user)
    end

    it "does not permit attributes" do
      should_not permit(:room_number, :password)
        .for(:create, params: params)
        .on(:user)
    end
  end

  describe "#index" do
    it "returns all user's JSON responses" do
      get :index, format: :json
      parsed_json = JSON.parse(response.body)

      expect(parsed_json.count).to eql(@users.count)
    end
  end

  describe "#show" do
    context "with a matching user id" do
      it "returns the user's JSON response" do
        get :show, id: @users.last.id, format: :json
        parsed_json = JSON.parse(response.body)

        expect(parsed_json['first_name']).to eql(@users.last.first_name)
        expect(parsed_json['last_name']).to eql(@users.last.last_name)
        expect(parsed_json['email']).to eql(@users.last.email)
        expect(parsed_json['role']).to eql(@users.last.role)
      end
    end

    context "without a matching user id" do
      it "returns '404 - No Content' error" do
        get :show, id: @users.last.id + 1, format: :json
        parsed_json = JSON.parse(response.body)

        expect(parsed_json['error']).to_not be_empty
        expect(response.status).to eql(404)
      end
    end
  end

  describe "#create" do
    let(:user) { new_user }

    before { post :create, user: user.as_json, format: :json }

    it "returns the user's JSON response" do
      parsed_json = JSON.parse(response.body)

      expect(parsed_json['first_name']).to eql(user.first_name)
      expect(parsed_json['last_name']).to eql(user.last_name)
      expect(parsed_json['email']).to eql(user.email)
      expect(parsed_json['role']).to eql(user.role)
    end

    it "increments the users array" do
      expect(User.all.count).to eql (@users.count)
    end
  end
end

def new_user
  User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.safe_email,
    password: Faker::Lorem.characters(8),
    role: ['doctor', 'nurse'].sample
  )
end