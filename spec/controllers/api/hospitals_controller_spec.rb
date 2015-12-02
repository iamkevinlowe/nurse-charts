require 'rails_helper'

RSpec.describe Api::HospitalsController, type: :controller do

  context "routes" do
    it { should route(:get, '/api/hospitals').to(action: :index) }
    it { should_not route(:get, '/api/hospitals/50').to(action: :show, id: 50) }
    it { should_not route(:post, '/api/hospitals').to(action: :create) }
    it { should_not route(:put, '/api/hospitals/50').to(action: :update, id: 50) }
    it { should_not route(:delete, '/api/hospitals/50').to(action: :destroy, id: 50) }
  end
end
