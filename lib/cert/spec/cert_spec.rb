require 'spec_helper'

describe Cert do
  it 'has a version number' do
    expect(Cert::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
