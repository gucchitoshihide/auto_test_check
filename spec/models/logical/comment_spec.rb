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


  # ids are validated at controller
  describe '.submit' do
    before do
      FactoryGirl.create(:user)
      @params = MODEL_POST_COMMENT_PARAMS
    end
    let(:params) { @params }

    subject { Comment.submit(params, ARTICLE_ID, USER_ID) }

    context 'with valid params' do
      it { expect { subject }.not_to raise_error }
    end

    context 'with blank comment' do
      let(:params) { { content: '' } }
      let(:errors) { 'las.errors.comment_content.blank' }

      it { expect { subject }.to raise_error ValidationError, format_errors(errors) }
    end

    context 'with long comment' do
      let(:params) { { content: 'a' * (Settings.comment.length_max + 1) } }
      let(:errors) { 'las.errors.comment_content.long' }

      it { expect { subject }.to raise_error ValidationError, format_errors(errors) }
    end
  end
end
