class Report < ActiveRecord::Base
  belongs_to :issue
  belongs_to :patient
  belongs_to :user
end
