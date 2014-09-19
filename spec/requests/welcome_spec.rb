require 'rails_helper'

RSpec.describe 'Welcome', :type => :request do
  before { FactoryGirl.create(:user) }

  describe 'GET /welcome' do
    context 'with session' do
      subject do
        get(welcome_path)
        response
      end
      before { login }
      it_behaves_like 'a successful response', 'welcome.show'
    end

    context 'without session' do
      subject do
        get(welcome_path)
        response
      end
      it_behaves_like 'a successful redirection to', '/login/new'
    end
  end
end
