require 'spec_helper'

describe Search do
  before do
    @match_word       = 'ruby'
    @not_match_word   = 'dwqrqvb'
    expcted_record    = {content: 'java\nobjective-c\nruby\nc++\n'}
    unexpected_record = {content: 'scala\ncobol\npython\n'}
    allow(expcted_record).to    receive(:content).and_return(expcted_record[:content])
    allow(unexpected_record).to receive(:content).and_return(unexpected_record[:content])
    @records = [expcted_record, unexpected_record]
  end

  it 'has a version number' do
    expect(Search::VERSION).not_to be nil
  end

  describe '::Word#reg_exp' do
    context 'when given records and word' do
      where(:records, :property, :word, :to_or_not_to) do
        [
          [@records, :content, @match_word,     :to],
          [@records, :content, @not_match_word, :not_to],
          [[],       :content, 'some word',     :not_to],
          [[],       :invalid, 'some word',     :not_to],
        ]
      end
      with_them do
        subject { Search::Word.reg_exp(records, property, word) }
        it { expect(subject).to be_an_instance_of(Array) }
        it { expect(subject[0].content).to_or_not_to include(word) if records.present? }
      end
    end
  end
end
