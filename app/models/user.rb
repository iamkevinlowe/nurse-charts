class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :role, presence: true

  belongs_to :hospital
  has_many :reports

  def proper_name
    "#{role.capitalize} - #{first_name} #{last_name}"
  end

  def as_json(options = {})
    super(
      methods: :proper_name
    )
  end

end
