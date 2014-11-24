require 'spec_helper'

require 'eson/chainable'
require 'eson/api'
require 'eson/dsl'

describe 'Eson::Api::DSL' do
  before do
    C = Class.new do
      include Eson::API::DSL
    end
  end

  after do
    Object.send(:remove_const, :C)
  end

  subject { C.new }

  describe '#methods' do
    context 'with single method' do
      before do
        C.class_eval do
          methods :get
        end
      end

      it 'returns correct list' do
        expect(subject.methods).to eq [:get]
      end
    end

    context 'with multiple methods' do
      before do
        C.class_eval do
          methods :post, :get
        end
      end

      it 'returns correct list' do
        expect(subject.methods).to eq [:post, :get]
      end
    end
  end

  describe '#url' do
    context 'with empty block' do
      before do
        C.class_eval do
          url {}
        end
      end

      it { is_expected.to respond_to(:url) }

      it 'does not raise error when calling :url' do
        expect { subject.url }.to_not raise_error
      end
    end

    describe 'sets base_path' do
      subject do
        C.class_eval do
          url 'test' do
          end
        end
        C.new.url
      end

      it 'does not raise exception' do
        expect { subject }.to_not raise_error
      end

      it { is_expected.to respond_to(:base_path) }

      it 'returns base_path' do
        expect(subject.base_path).to eq 'test'
      end
    end

    describe 'sets path' do
      subject do
        C.class_eval do
          url 'test' do
            path '/_cluster/health'
            path '/_cluster/health/{index}'
          end
        end
        C.new.url
      end

      it 'does not raise exception' do
        expect { subject }.to_not raise_error
      end

      it { is_expected.to respond_to(:paths) }

      it 'returns an Array' do
        expect(subject.paths).to be_a(Array)
      end

      it 'returns 2 entries' do
        expect(subject.paths.size).to eq 2
      end

      it 'returns correct paths' do
        expected = [
          '/_cluster/health',
          '/_cluster/health/{index}'
        ]
        expect(subject.paths).to eq expected
      end
    end

    describe '#params' do
      subject do
        C.class_eval do
          url 'foo' do
            params do
            end
          end
        end
        C.new
      end

      it 'does not raise error when calling params' do
        expect { subject.url.params }.to_not raise_error
      end
    end
  end
end
