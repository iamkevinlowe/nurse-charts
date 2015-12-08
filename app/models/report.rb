class Report < ActiveRecord::Base
  belongs_to :activity, polymorphic: true
  belongs_to :patient
  belongs_to :user
end
