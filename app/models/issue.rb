class Issue < ActiveRecord::Base
  belongs_to :careplan
  has_many :goals, dependent: :destroy
  has_many :reports, as: :activity, dependent: :destroy

  validates :name, presence: true
end
