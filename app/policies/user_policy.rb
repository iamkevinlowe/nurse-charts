class UserPolicy < ApplicationPolicy

  def index?
    doctor? || nurse? || admin?
  end

  def show?
    index?
  end

  def create?
    doctor? || admin?
  end

  class Scope < Scope
    def resolve
      scope.where(hospital_id: user.hospital_id, role: ['doctor', 'nurse'])
    end
  end

end