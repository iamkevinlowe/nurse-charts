class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end

    private

    def doctor?
      user && user.role == 'doctor'
    end

    def admin?
      user && user.role == 'admin'
    end

    def nurse?
      user && user.role == 'nurse'
    end
  end

  private

  def doctor?
    user && user.role == 'doctor'
  end

  def admin?
    user && user.role == 'admin'
  end

  def nurse?
    user && user.role == 'nurse'
  end
end
