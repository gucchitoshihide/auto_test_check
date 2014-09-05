require 'spec_helper'

describe Search do
  before do
    @search_valid_word   = 'ruby'
    @search_invalid_word = 'dwqrqvb'
    valid_record   = {content: 'java\nobjective-c\nruby\nc++\n'}
    invalid_record = {content: 'scala\ncobol\npython\n'}
    allow(valid_record).to   receive(:content).and_return(valid_record[:content])
    allow(invalid_record).to receive(:content).and_return(invalid_record[:content])
    @records       = [valid_record, invalid_record]
  end

  it 'has a version number' do
    expect(Search::VERSION).not_to be nil
  end

  describe '::Word#reg_exp' do
    context 'records with valid record, valid word' do
      subject do
        Search::Word.reg_exp(@records, :content, @search_valid_word)
      end
      it { expect(subject).to be_an_instance_of(Array) }
      it { expect(subject.size).to eq(1) }
      it { expect(subject[0].content).to include(@search_valid_word) }
    end

    context 'records with valid record, invalid word' do
      subject do
        Search::Word.reg_exp(@records, :content, @search_invalid_word)
      end
      it { expect(subject).to be_an_instance_of(Array) }
      it { expect(subject.size).to eq(0) }
    end

    context 'only valid record, valid word' do
      subject do
        valid_record = [@records.first]
        Search::Word.reg_exp(valid_record, :content, @search_valid_word)
      end
      it { expect(subject).to be_an_instance_of(Array) }
      it { expect(subject.size).to eq(1) }
    end

    context 'only invalid record, invalid word' do
      subject do
        invalid_record = [@records.last]
        Search::Word.reg_exp(invalid_record, :content, @search_invalid_word)
      end
      it { expect(subject).to be_an_instance_of(Array) }
      it { expect(subject.size).to eq(0) }
    end
  end

end
