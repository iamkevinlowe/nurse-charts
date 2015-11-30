class CareplanPolicy < ApplicationPolicy

  def create?
    doctor?
  end

end