require 'rails_helper'

RSpec.describe Report, :type => :model do

  describe 'validation' do
    before do
      @report_attributes = {
        id: 1,
        title:     'foo',
        content:   'bar'
      }
    end

    describe 'presence' do
      context 'title' do
        subject do
          @report_attributes[:title] = nil
          Report.new(@report_attributes)
        end
        it { expect(subject).not_to be_valid }
      end

      context 'content' do
        subject do
          @report_attributes[:content] = nil
          Report.new(@report_attributes)
        end
        it { expect(subject).not_to be_valid }
      end
    end

    describe 'max_length' do
      context 'valid at 255' do
        subject do
          @report_attributes[:title] = 'a' * 255
          Report.new(@report_attributes)
        end
        it { expect(subject).to be_valid }
      end
    end

    describe 'max_length' do
      context 'invalid at 256' do
        subject do
          @report_attributes[:title] = 'a' * 256
          Report.new(@report_attributes)
        end
        it { expect(subject).not_to be_valid }
      end
    end

  end
end
