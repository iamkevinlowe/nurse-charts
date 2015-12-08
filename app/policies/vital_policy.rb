class VitalPolicy < ApplicationPolicy

  def create?
    doctor? || nurse?
  end

end