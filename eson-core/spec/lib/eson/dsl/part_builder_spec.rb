require 'spec_helper'

require 'eson/chainable'
require 'eson/api'
require 'eson/dsl/part_builder'

describe Eson::API::DSL::PartBuilder do
  describe '#add_part' do
    context 'with type String' do
      subject { Eson::API::DSL::PartBuilder.new }
      before do
        subject.add_part(:index, type: String, required: true)
      end

      it 'creates :index attribute' do
        expect(subject).to respond_to :index
      end

      it 'can assign a string' do
        expect { subject.index = '1234' }.to_not raise_error
      end
    end

    context 'with type Array[String]' do
      before do
        subject.add_part(:foo, type: Array[String])
      end

      it 'creates :foo attribute' do
        expect(subject).to respond_to :foo
      end

      it 'can assign an array of strings' do
        expect { subject.foo = ['1', '2'] }.to_not raise_error
      end
    end
  end

  describe '#multi_index?' do
    subject { Eson::API::DSL::PartBuilder.new }

    it 'returns false with type String as index part' do
      subject.add_part(:index, type: String)
      expect(subject.multi_index?).to eq false
    end

    it 'returns false without any index part' do
      expect(subject.multi_index?).to eq false
    end

    it 'returns true with type Array[String] as index part' do
      subject.add_part(:index, type: Array[String])
      expect(subject.multi_index?).to eq true
    end
  end
end
