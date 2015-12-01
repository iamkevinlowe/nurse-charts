class Hospital < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :patients, dependent: :destroy
end
