require 'rails_helper'

RSpec.describe Comment, :type => :model do
  describe '.show_all' do
    subject { Comment.show_all(ARTICLE_ID) }

    context 'with commented article' do
      before do
        FactoryGirl.create(:article_comment)
        @expected_comments =
          ArticleComment.where('article_id = ?', ARTICLE_ID).map do |relation_record|
            relation_record.comment
          end
      end

      it { expect(subject).to eq @expected_comments }
    end

    context 'with no comment artice' do
      before { FactoryGirl.create(:article_without_comment) }

      it { expect(subject).to be_empty }
    end
  end

  describe '.num_followed' do
    subject { Comment.num_followed(ARTICLE_ID) }

    context 'with commented article' do
      before { @expected_num = ArticleComment.where('article_id = ?', ARTICLE_ID).count }

      it { expect(subject).to eq @expected_num }
    end

    context 'with no comment article' do
      before { FactoryGirl.create(:article_without_comment) }

      it { expect(subject).to eq 0 }
    end
  end
end
