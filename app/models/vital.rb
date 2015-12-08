class Vital < ActiveRecord::Base
  belongs_to :patient
  has_many :reports, as: :activity, dependent: :destroy
  has_many :blood_pressures, dependent: :destroy
  has_many :pulse_rates, dependent: :destroy
  has_many :respiration_rates, dependent: :destroy
  has_many :temperatures, dependent: :destroy
end
