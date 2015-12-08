class BloodPressurePolicy < ApplicationPolicy

  def create?
    doctor? || nurse?
  end

end