class PatientPolicy < ApplicationPolicy

  def index?
    doctor? || nurse? || admin? 
  end

  def show?
    doctor? || admin?
  end

  def create?
    show?
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