require 'spec_helper'

require 'eson/chainable'
require 'eson/api'

describe 'Eson::Api' do
  before do
    M = Module.new do
      include Virtus.module
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

  subject { C.new }

  describe '#parameter_string' do
    before do
      M.class_eval do
        parameter_string :bar
      end
      C.class_eval do
        include M
      end
    end

    it { is_expected.to respond_to(:bar) }
  end

  describe '#parameter_boolean' do
    before do
      M.class_eval do
        parameter_boolean :local
      end
      C.class_eval do
        include M
      end
    end

    it { is_expected.to respond_to(:local) }
  end

  describe '#parameter_time' do
    before do
      M.class_eval do
        parameter_time :time
      end
      C.class_eval do
        include M
      end
    end

    it { is_expected.to respond_to(:time) }
  end

  describe '#parameter_enum' do
    before do
      M.class_eval do
        parameter_enum :foo, ['1', '2'], '1'
      end
      C.class_eval do
        include M
      end
    end

    it 'returns default value' do
      expect(subject.foo).to eq '1'
    end

    it 'sets nil as value' do
      expect { subject.foo = nil }.to_not raise_error
    end

    it 'can set default value' do
      expect { subject.foo = '1' }.to_not raise_error
    end

    it 'raise ArgumentError if unknown enum value' do
      expect { subject.foo = '3' }.to raise_error(ArgumentError)
    end
  end
end
