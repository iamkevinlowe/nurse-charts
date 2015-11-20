class HospitalPolicy < ApplicationPolicy

  def index?
    admin?
  end

  def show?
    nurse? || admin?
  end

end