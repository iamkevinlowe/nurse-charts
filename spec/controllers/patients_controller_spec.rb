require 'rails_helper'

RSpec.describe PatientsController, type: :controller do

  context "routes" do
    it { should route(:get, '/patients/50').to(action: :show, id: 50) }
    it { should_not route(:get, '/patients').to(action: :index) }
    it { should_not route(:post, '/patients').to(actions: :create) }
    it { should_not route(:put, '/patients/50').to(actions: :update) }
    it { should_not route(:delete, '/patients/50').to(actions: :destroy, id: 50) }
  end

end
