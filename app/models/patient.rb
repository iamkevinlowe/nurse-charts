class Patient < ActiveRecord::Base
  belongs_to :hospital
  has_one :careplan, dependent: :destroy
  has_many :reports, -> { order "created_at DESC" }, dependent: :destroy

  validates :first_name, :last_name, presence: true

  def as_json(options = {})
    super(
      include: {
        careplan: { 
          include: { 
            issues: { 
              include: :goals
            }
          }
        },
        reports: {}
      }
    )
  end
end
