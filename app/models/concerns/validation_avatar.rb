module ValidationAvatar
  require 'RMagick'
  extend ActiveSupport::Concern

  def validate_avatar(params)
    begin
      validate_avatar_blank(params[:avatar]) or @errors.present?
      validate_avatar_content_type(params[:avatar].content_type)
    rescue ValidationError
      return
    end
    image = Magick::ImageList.new(params[:avatar].tempfile.path)
    validate_avatar_scale(image)
    validate_avatar_size(image)
  end

  private

  def validate_avatar_blank(avatar)
    if avatar.blank?
      @errors << I18n.t('las.error.message.avatar.blank.no_avatar')
      raise ValidationError
    end
  end

  def validate_avatar_content_type(content_type)
    unless Settings[:settings][:avatar][:permitted].include?(content_type.split('/').last)
      @errors << I18n.t('las.error.message.avatar.format.invalid')
      raise ValidationError
    end
  end

  def validate_avatar_scale(image)
    if image.columns < Settings[:settings][:avatar][:min_size] or image.rows < Settings[:settings][:avatar][:min_size]
      @errors << I18n.t('las.error.message.avatar.size.scale_small')
    end
  end

  def validate_avatar_size(image)
    if image.filesize >= Settings[:settings][:avatar][:max_storage]
      @errors << I18n.t('las.error.message.avatar.size.storage_big')
    end
  end
end
