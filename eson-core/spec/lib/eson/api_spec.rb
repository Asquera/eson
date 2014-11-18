require 'spec_helper'

require 'eson/chainable'
require 'eson/api'

describe 'Eson::Api' do
  class ApiTest
    include Eson::API
  end

  subject(:klass) { ApiTest.new }

  it { is_expected.to respond_to(:parameter_enum) }

  describe '#parameter_enum' do
    before do
      subject.parameter_enum(:foo, ['1', '2'], '1')
    end

    it { is_expected.to respond_to(:foo) }
    it { is_expected.to respond_to('foo=') }

    it 'returns default value' do
      expect(klass.foo).to eq '1'
    end

    it 'can set default value' do
      expect { klass.foo = '1' }.to_not raise_error
    end

    it 'raise ArgumentError if unknown enum value' do
      expect { klass.foo = '3' }.to raise_error(ArgumentError)
    end
  end
end
