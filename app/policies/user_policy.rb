class UserPolicy < ApplicationPolicy

  def index?
    doctor? || admin?
  end

  def show?
    index?
  end

  def create?
    index?
  end

  class Scope < Scope
    def resolve
      scope.where(hospital_id: user.hospital_id, role: ['doctor', 'nurse'])
    end
  end

end