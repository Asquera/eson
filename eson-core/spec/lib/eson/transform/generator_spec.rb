require 'spec_helper'

require 'lib/eson/transform/generator'

describe Eson::Transform::Generator do
  describe '#initialize' do
    it 'does not raise error' do
      expect { Eson::Transform::Generator.new({}) }.to_not raise_error
    end
  end
end
