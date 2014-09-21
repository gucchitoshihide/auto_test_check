require 'spec_helper'
require 'pry'

describe Cert do
  it 'has a version number' do
    expect(Cert::VERSION).not_to be nil
  end

  describe 'Cert::Params#numerical?' do
    let(:value) { 123 }

    subject { Cert::Params.numerical?(value) }

    context 'with valid value' do
      [123, '123'].each do |valid_value|
        let(:value) { valid_value }
        it { expect(subject).to be true }
      end
    end

    context 'with invalid value' do
      [
       '', 'invalid', '123invalid',
       [], {}, Object
      ].each do |invalid_value|
        context "with #{invalid_value}" do
          let(:value) { invalid_value }
          it { expect(subject).to be false }
        end
      end
    end
  end
end
