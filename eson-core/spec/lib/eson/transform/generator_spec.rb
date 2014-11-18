require 'spec_helper'

require 'lib/eson/chainable'
require 'lib/eson/api'
require 'lib/eson/transform/generator'

describe Eson::Transform::Generator do
  describe '#initialize' do
    it 'does not raise error' do
      expect { Eson::Transform::Generator.new({}) }.to_not raise_error
    end

    context 'with sample "cluster.health"' do
      let(:sample) { load_api_sample('cluster.health') }
      subject { Eson::Transform::Generator.new(sample) }

      it 'does not raise error' do
        expect { subject }.to_not raise_error
      end
    end
  end

  describe '#ruby_content' do
    context 'with sample "cluster.health"' do
      let(:sample) { load_api_sample('cluster.health') }
      let(:source) { Eson::Transform::Generator.new(sample).ruby_content }
      subject!(:module) { eval(source) }

      it 'creates module Eson::Shared::Cluster::Health' do
        exists = Object.const_defined?('Eson::Shared::Cluster::Health')
        expect(exists).to eq true
      end
    end
  end
end
