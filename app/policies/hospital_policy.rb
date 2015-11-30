class HospitalPolicy < ApplicationPolicy

  def index?
    admin? || doctor?
  end

  def show?
    nurse? || admin?
  end

end