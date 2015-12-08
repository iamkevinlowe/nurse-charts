class TemperaturePolicy < ApplicationPolicy

  def create?
    doctor? || nurse?
  end

end