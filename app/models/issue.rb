class Issue < ActiveRecord::Base
  belongs_to :careplan
  has_many :goals, dependent: :destroy
end
