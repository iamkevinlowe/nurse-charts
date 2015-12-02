require 'rails_helper'

RSpec.describe Issue, type: :model do

  context "ActiveRecord associations" do
    it { should belong_to :careplan }
    it { should have_many :goals }
  end

  context "validations" do
    it { should validate_presence_of :name }
  end

end
