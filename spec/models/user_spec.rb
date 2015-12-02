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

end
