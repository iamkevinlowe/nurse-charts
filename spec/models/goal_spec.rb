require 'rails_helper'

RSpec.describe Goal, type: :model do
  
  context "ActiveRecord associations" do
    it { should belong_to :issue }
  end

  context "validations" do
    it { should validate_presence_of :activity }
  end

end
