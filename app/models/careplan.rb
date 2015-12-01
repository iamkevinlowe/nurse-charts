class Careplan < ActiveRecord::Base
  belongs_to :patient
  has_many :issues, dependent: :destroy
end
