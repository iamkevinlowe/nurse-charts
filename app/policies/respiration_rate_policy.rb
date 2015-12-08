class RespirationRatePolicy < ApplicationPolicy

  def create?
    doctor? || nurse?
  end

end