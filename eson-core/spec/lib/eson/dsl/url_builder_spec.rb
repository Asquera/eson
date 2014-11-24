require 'spec_helper'
require 'rspec/its'

require 'eson/chainable'
require 'eson/api'
require 'eson/dsl'
require 'eson/dsl/url_builder'

require 'pry'

describe Eson::API::DSL::UrlBuilder do
  describe '#paths' do
    let(:builder) do
      Eson::API::DSL::UrlBuilder.new do
        path '/_cluster/health'
        path '/_cluster/health/{index}'
      end
    end
    subject { builder.paths }

    it { is_expected.to be_a(Array) }
    its(:size) { is_expected.to eq 2 }

    it 'returns two paths when fetchting multiple times' do
      expect(subject.size).to eq 2
      expect(subject.size).to eq 2
    end
  end

  describe '#params' do
    context 'with single block' do
      let(:builder) do
        Eson::API::DSL::UrlBuilder.new do
          params do
            string :foo
          end
        end
      end
      subject { builder.params }

      it { is_expected.to respond_to(:foo) }
    end

    context 'with single block and two parameters' do
      let(:builder) do
        Eson::API::DSL::UrlBuilder.new do
          params do
            string :foo
            string :bar
          end
        end
      end
      subject { builder.params }

      it { is_expected.to respond_to(:foo) }
      it { is_expected.to respond_to(:bar) }
    end

    context 'with multiple blocks and parameters' do
      let(:builder) do
        Eson::API::DSL::UrlBuilder.new do
          params do
            string :foo
          end
          params do
            string :bar
          end
        end
      end
      subject { builder.params }

      it { is_expected.to respond_to(:foo) }
      it { is_expected.to respond_to(:bar) }
    end
  end

  describe '#part' do
    context 'with a single index' do
      let(:builder) do
        Eson::API::DSL::UrlBuilder.new do
          path '/_cluster/health/{index}'
          part :index, type: String, required: true
        end
      end
      subject { builder.parts }

      it { is_expected.to respond_to(:index) }
    end
  end
end
