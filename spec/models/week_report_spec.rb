require 'rails_helper'

RSpec.describe WeekReport, :type => :model do

  describe 'scope' do

    context '#recent' do
      subject do
        @recent_report_num = 5
        @recent_report     = WeekReport.recent(@recent_report_num)
      end
      it { expect(subject).not_to be_nil }
      it { expect(subject.size).to eq(@recent_report_num) }
    end

  end

end
