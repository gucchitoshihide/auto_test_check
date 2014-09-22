module ValidationComment
  extend ActiveSupport::Concern

  def validate_comment_params(params)
    validate_comment_content(params[:content])
    validate_comment_long(params[:content])
  end

  private

  def validate_comment_content(content)
    @errors << I18n.t('las.errors.comment_content.blank') if content.blank?
  end

  def validate_comment_long(content)
    @errors << I18n.t('las.errors.comment_content.long') if content.length > 3000
  end
end
