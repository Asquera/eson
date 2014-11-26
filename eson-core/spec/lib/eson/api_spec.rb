require 'spec_helper'

require 'eson/chainable'
require 'eson/api'
require 'eson/dsl'

require 'pry'

describe 'Eson::Api' do
  before do
    M = Module.new do
      extend Eson::API
    end
    C = Class.new do
      include M
    end
  end

  after do
    Object.send(:remove_const, :M)
    Object.send(:remove_const, :C)
  end

  describe '#url' do
    subject do
      M.class_eval do
        url do
          params do
            string :bar, 'test'
          end
        end
      end
      C.new
    end

    it 'does not raise error' do
      expect { subject }.to_not raise_error
    end

    it 'creates correct parameter :bar' do
      expect(subject.url.params).to respond_to :bar
    end
  end

  describe 'more complete example' do
    subject do
      M.class_eval do
        methods :get
        url do
          set_base_path '/_cluster/health'
          path '/_cluster/health'
          path '/_cluster/health/{index}'

          part :index, type: String, required: true

          params do
            string :foo, 'foo'
            enum :bar, [1, 2]
          end
        end
      end
      C.new
    end

    it 'does not raise error' do
      expect { subject }.to_not raise_error
    end

    it { is_expected.to respond_to(:url) }

    it 'contains correct base_path' do
      expect(subject.url.base_path).to eq '/_cluster/health'
    end
  end
end
