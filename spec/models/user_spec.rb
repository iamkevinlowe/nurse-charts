require 'rails_helper'

RSpec.describe User, type: :model do
  
  context "ActiveRecord associations" do
    it { should belong_to :hospital }
    it { should have_many :reports }
  end

  context "Devise validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  context "validations" do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :role }
  end

  describe "#proper_name" do
    let(:user) { User.new(first_name: "John", last_name: "Doe") }
    context "as a nurse" do
      before :example do
        user.role = 'nurse'
      end
      it 'displays the proper name' do
        expect(user.proper_name).to eql('Nurse, John Doe')
      end
    end
    context "as a doctor" do
      before { user.role = 'doctor' }
      it "displays the proper name" do
        expect(user.proper_name).to eql('Doctor, John Doe')
      end
    end
    context "as an admin" do
      before { user.role = 'admin' }
      it "displays the proper name" do
        expect(user.proper_name).to eql('Admin, John Doe')
      end
    end
  end

  describe "#as_json" do
    let(:user) { User.new(first_name: "John", last_name: "Doe", role: 'doctor', email: 'user@example.com') }
    let(:user_json) { user.as_json }

    before do
      expect(user).to receive(:id) { 123 }
      expect(user).to receive(:hospital_id) { 456 }
    end

    it "returns proper_name value" do
      expect(user_json["proper_name"]).to eql('Doctor, John Doe')
    end

    it "returns first_name value" do
      expect(user_json["first_name"]).to eql("John")
    end

    it "returns last_name value" do
      expect(user_json["last_name"]).to eql("Doe")
    end

    it "returns email value" do
      expect(user_json["email"]).to eql("user@example.com")
    end

    it "returns id value" do
      expect(user_json["id"]).to eql(123)
    end

    it "returns hospital_id value" do
      expect(user_json["hospital_id"]).to eql(456)
    end

  end

end
