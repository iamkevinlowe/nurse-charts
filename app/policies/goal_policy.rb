class GoalPolicy < ApplicationPolicy

  def create?
    doctor?
  end

end