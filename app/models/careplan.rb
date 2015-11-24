class Careplan < ActiveRecord::Base
  belongs_to :user
  has_many :issues, dependent: :destroy
end
