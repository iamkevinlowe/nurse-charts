class PatientPolicy < ApplicationPolicy

  def index?
    doctor? || nurse? || admin? 
  end

  def show?
    if nurse?
      record.hospital_id == user.hospital_id
    else
      create?
    end
  end

  def create?
    doctor? || admin?
  end

  class Scope < Scope
    def resolve
      if doctor? || admin?
        scope.all.includes(:reports, careplan: [issues: [:goals]])
      elsif nurse?
        scope.where("hospital_id = ?", user.hospital_id).includes(:reports, careplan: [issues: [:goals]])
      end
    end
  end

end