require 'rails_helper'

describe 'Routing of Las', :type => :routing do
  describe 'Route to valid paths' do
    where(:method, :path, :expected_controller, :expected_action) do
      [
        [:get,  '/admin', 'admin', 'index'],
        [:post, '/admin', 'admin', 'create'],
        [:get,  '/admin/login', 'admin', 'login'],
      ]
    end
    with_them do
      it do
        expect(method => path).to route_to(
          controller: expected_controller,
          action:     expected_action
        )
      end
    end
  end

#  describe 'Route to invvalid paths' do
#    where(:method, :path) do
#      [
#        ['get', '/invalid']
#      ]
#    end
#    with_them do
#      it do
#        expect(send("#{method}", path)).to route_to(
#          controller: 'error',
#          action:     'not_found'
#        )
#      end
#    end
#  end
end
