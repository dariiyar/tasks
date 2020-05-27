require 'rails_helper'

RSpec.describe ApplicationController, type: :routing do
  describe 'routing' do
    it 'root is not routable' do
      expect(get: '/').to route_to('application#render_404')
    end

    it 'not existing route is not routable' do
      expect(get: '/any-route').to route_to('application#render_404', any: 'any-route')
    end
  end
end
