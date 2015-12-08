class PulseRatePolicy < ApplicationPolicy

  def create?
    doctor? || nurse?
  end

end