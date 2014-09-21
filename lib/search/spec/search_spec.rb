require 'spec_helper'

describe Search do

  it 'has a version number' do
    expect(Search::VERSION).not_to be nil
  end

  describe '::Word#reg_exp' do
    before do
      @word  = 'ruby'
      record = { content: "java\nobjective-c\n#{@word}\nc++\n" }
      allow(record).to receive(:content).and_return(record[:content])
      @record = [record]
    end
    let(:record)   { @record }
    let(:property) { :content }
    let(:word)     { @word }

    subject { Search::Word.reg_exp(record, property, word) }

    context 'when record exist' do
      context 'with record and match word' do
        it { expect(subject[0].content).to include(@word) }
      end

      context 'with record and invalid word' do
        let(:word) { 'invalid' }
        it { expect(subject.size).to eq(0) }
      end

      context 'with record and invalid property' do
        let(:property) { :invalid }
        it { expect(subject.size).to eq(0) }
      end
    end

    context 'with blank record and word' do
      let(:record) { [] }
      it { expect(subject.size).to eq(0) }
    end
  end
end
