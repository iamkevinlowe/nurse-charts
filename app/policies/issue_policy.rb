class IssuePolicy < ApplicationPolicy

  def create?
    doctor?
  end

end