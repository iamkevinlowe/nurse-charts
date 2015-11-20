class UserPolicy < ApplicationPolicy

  def index?
    nurse? || admin?
  end

  def create?
    admin?
  end

  class Scope < Scope
    def resolve
      if admin?
        scope.where(role: ['nurse', 'patient'])
      elsif nurse?
        scope.where("role = ?", 'patient')
      end
    end
  end

end