class UserPolicy < ApplicationPolicy

  def index?
    nurse? || admin? || doctor?
  end

  def show?
    index?
  end

  def create?
    admin?
  end

  class Scope < Scope
    def resolve
      if admin? || doctor?
        scope.where(role: ['nurse', 'patient'])
      elsif nurse?
        scope.where("role = ?", 'patient')
      end
    end
  end

end