class PatientPolicy < ApplicationPolicy

  def index?
    doctor? || nurse? || admin? 
  end

  def create?
    doctor? || admin?
  end

  class Scope < Scope
    def resolve
      if doctor? || admin?
        scope.all.includes(careplan: [issues: [:goals]])
      elsif nurse?
        scope.where("hospital_id = ?", user.hospital_id).includes(careplan: [issues: [:goals]])
      end
    end
  end

end