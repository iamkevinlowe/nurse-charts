require 'rails_helper'

RSpec.describe Report, type: :model do

  context "ActiveRecord associations" do
    it { should belong_to :issue }
    it { should belong_to :patient }
    it { should belong_to :user }
  end

end
