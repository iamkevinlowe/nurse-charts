class Goal < ActiveRecord::Base
  belongs_to :issue

  validates :activity, presence: true
end
