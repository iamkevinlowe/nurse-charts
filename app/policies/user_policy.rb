class UserPolicy < ApplicationPolicy

  def index?
    nurse? || admin? || doctor?
  end

  def show?
    index?
  end

  def create?
    admin? || doctor?
  end

  class Scope < Scope
    def resolve
      if admin? || doctor?
        scope.where(role: ['nurse', 'patient']).includes(careplan: [issues: [:goals]])
      elsif nurse?
        scope.where("role = ?", 'patient').includes(careplan: [issues: [:goals]])
      end
    end
  end

end