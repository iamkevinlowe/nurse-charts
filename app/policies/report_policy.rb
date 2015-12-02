class ReportPolicy < ApplicationPolicy

  def create?
    doctor? || nurse?
  end

end