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
      scope.where("role = ?", 'nurse')
    end
  end

end