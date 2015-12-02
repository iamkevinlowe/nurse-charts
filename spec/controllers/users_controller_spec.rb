require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  context "routes" do
    it { should route(:get, '/users/50').to(action: :show, id: 50) }
    it { should_not route(:get, '/users').to(action: :index) }
    it { should_not route(:post, '/users').to(action: :create) }
    it { should_not route(:put, '/users/50').to(action: :update, id: 50) }
    it { should_not route(:delete, '/users/50').to(action: :destroy, id: 50) }
  end

end
