require 'rails_helper'

RSpec.describe Patient, type: :model do
  
  context "ActiveRecord associations" do
    it { should belong_to :hospital }
    it { should have_one :careplan }    
    it { should have_many :reports }
  end

  context "validations" do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

end
