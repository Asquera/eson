require 'spec_helper'

require 'lib/eson/chainable'
require 'lib/eson/api'
require 'lib/eson/transform/generator'

describe Eson::Transform::Generator do
  describe '#initialize' do
    context 'with empty hash' do
      it 'does not raise error' do
        expect { Eson::Transform::Generator.new({}) }.to_not raise_error
      end
    end

    context 'with sample "cluster.health"' do
      let(:sample) { load_api_sample('cluster.health') }
      subject { Eson::Transform::Generator.new(sample) }

      it 'does not raise error' do
        expect { subject }.to_not raise_error
      end

      it 'returns top level module name' do
        expect(subject.api_endpoint.top_level_name).to eq 'Cluster'
      end

      it 'returns module name "Health"' do
        expect(subject.api_endpoint.module_name).to eq 'Health'
      end
    end

    context 'with sample "bulk"' do
      let(:sample) { load_api_sample('bulk') }
      subject { Eson::Transform::Generator.new(sample) }

      it 'does not raise error' do
        expect { subject }.to_not raise_error
      end

      it 'returns empty top level module name' do
        expect(subject.api_endpoint.top_level_name).to eq ''
      end

      it 'returns module name "Bulk"' do
        expect(subject.api_endpoint.module_name).to eq 'Bulk'
      end
    end
  end

  describe '#ruby_content' do
    context 'with sample "cluster.health"' do
      let(:sample) { load_api_sample('cluster.health') }
      let(:source) { Eson::Transform::Generator.new(sample).ruby_content }
      let!(:module) { eval(source) }

      it 'creates module Eson::Shared::Cluster::Health' do
        exists = Object.const_defined?('Eson::Shared::Cluster::Health')
        expect(exists).to eq true
      end

      context 'with concrete class' do
        before do
          class ApiTest
            include Eson::Shared::Cluster::Health
          end
        end
        subject(:api) { ApiTest.new }

        it 'does not increase paths array' do
          expect(subject.url.paths.size).to eq 2
          expect(subject.url.paths.size).to eq 2
        end

        it 'contains correct methods list' do
          expect(subject.request_methods).to eq [:get]
        end

        describe 'paths array' do
          it "returns correct list of paths" do
            expected = ['/_cluster/health', '/_cluster/health/{index}']
            expect(subject.url.paths).to eq expected
          end
        end

        describe 'the params list' do
          subject { api.url.params }

          it { is_expected.to respond_to(:level) }
          it { is_expected.to respond_to(:local) }
          it { is_expected.to respond_to(:master_timeout) }
          it { is_expected.to respond_to(:timeout) }
          it { is_expected.to respond_to(:wait_for_active_shards) }
          it { is_expected.to respond_to(:wait_for_nodes) }
          it { is_expected.to respond_to(:wait_for_relocating_shards) }
          it { is_expected.to respond_to(:wait_for_status) }
        end
      end
    end

    context 'with sample "bulk.json"' do
      let(:sample) { load_api_sample('bulk') }
      let(:source) { Eson::Transform::Generator.new(sample).ruby_content }
      let!(:module) { eval(source) }

      it 'creates module Eson::Shared::Bulk' do
        exists = Object.const_defined?('Eson::Shared::Bulk')
        expect(exists).to eq true
      end

      it 'does not create Eson::Shared::Bulk::Bulk' do
        exists = Object.const_defined?('Eson::Shared::Bulk::Bulk')
        expect(exists).to eq false
      end
    end

    context 'with sample "indices.exists_alias"' do
      let(:sample) { load_api_sample('indices.exists_alias') }
      let(:source) { Eson::Transform::Generator.new(sample).ruby_content }
      subject { eval(source) }

      it 'does not raise error' do
        expect { subject }.to_not raise_error
      end
    end
  end
end
