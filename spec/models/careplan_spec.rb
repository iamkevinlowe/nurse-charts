require 'rails_helper'

RSpec.describe Careplan, type: :model do
  
  context "ActiveRecord associations" do
    it { should belong_to :patient }
    it { should have_many :issues }
  end

end
