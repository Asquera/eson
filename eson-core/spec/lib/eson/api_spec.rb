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

    it 'creates correct parameter' do
      expect(subject.url.bar).to respond_to :bar
    end
  end
end
