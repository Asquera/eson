require 'spec_helper'

require 'eson/chainable'
require 'eson/api'
require 'eson/dsl'
require 'eson/dsl/param_builder'

describe Eson::API::DSL::ParamBuilder do
  shared_examples 'a valid parameter' do |name, default|
    it 'does not raise error' do
      expect { subject }.to_not raise_error
    end

    it { is_expected.to respond_to(name.to_sym) }

    it "returns default value #{default}" do
      expect(subject.send(name.to_sym)).to eq default
    end

    it 'sets nil as value' do
      expect { subject.send("#{name.to_sym}=", nil) }.to_not raise_error
      expect(subject.send(name.to_sym)).to eq nil
    end
  end

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

      it_behaves_like 'a valid parameter', :foo, '1'

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

      it_behaves_like 'a valid parameter', :bar, 'haha'
    end

    describe 'add boolean paramter' do
      subject do
        Eson::API::DSL::ParamBuilder.new do
          boolean :foo, false
        end
      end

      it_behaves_like 'a valid parameter', :foo, false
    end
  end
end
