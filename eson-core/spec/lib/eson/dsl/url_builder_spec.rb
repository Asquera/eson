require 'spec_helper'

require 'eson/chainable'
require 'eson/api'
require 'eson/dsl'
require 'eson/dsl/url_builder'

require 'pry'

describe Eson::API::DSL::UrlBuilder do
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
end
