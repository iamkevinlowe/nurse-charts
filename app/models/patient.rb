class Patient < ActiveRecord::Base
  belongs_to :hospital
  has_one :careplan, dependent: :destroy
  has_many :reports, dependent: :destroy

  def as_json(options = {})
    super(
      include: { careplan: { include: { issues: { include: :goals } } } }
    )
  end
end
