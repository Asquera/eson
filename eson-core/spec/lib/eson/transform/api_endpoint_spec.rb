require 'spec_helper'

describe Eson::Transform::ApiEndpoint do
  describe '#module_name' do
    it 'handles common string correctly' do
      api = Eson::Transform::ApiEndpoint.new({ name: 'cluster.health'})
      expect(api.module_name).to eq('Health')
    end

    it 'handles string with underscore correctly' do
      api = Eson::Transform::ApiEndpoint.new({ name: 'get_settings'})
      expect(api.module_name).to eq('GetSettings')
    end
  end
end
