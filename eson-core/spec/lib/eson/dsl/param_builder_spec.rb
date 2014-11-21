require 'spec_helper'

require 'eson/chainable'
require 'eson/api'
require 'eson/dsl'
require 'eson/dsl/param_builder'

describe Eson::API::DSL::ParamBuilder do
  describe '#initialize' do
    context 'without block' do
      subject { Eson::API::DSL::ParamBuilder.new }

      it 'does not raise error' do
        expect { subject }.to_not raise_error
      end
    end

    context 'with empty block' do
      subject { Eson::API::DSL::ParamBuilder.new {} }

      it 'does not raise error' do
        expect { subject }.to_not raise_error
      end
    end

    describe 'add enum parameter' do
      subject do
        Eson::API::DSL::ParamBuilder.new do
          enum :foo, ['1', '2'], '1'
        end
      end

      it 'does not raise error' do
        expect { subject }.to_not raise_error
      end

      it { is_expected.to respond_to(:foo) }

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

    describe 'add string parameter' do
      subject do
        Eson::API::DSL::ParamBuilder.new do
          string :bar, 'haha'
        end
      end

      it 'does not raise error' do
        expect { subject }.to_not raise_error
      end

      it { is_expected.to respond_to(:bar) }

      it 'returns default value' do
        expect(subject.bar).to eq 'haha'
      end

      it 'sets nil as value' do
        expect { subject.bar = nil }.to_not raise_error
        expect(subject.bar).to be nil
      end
    end
  end
end
