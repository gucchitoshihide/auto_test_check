class Admin < ActiveRecord::Base
  has_secure_password

  class << self
    include ValidationAdmin

    attr_accessor :errors

    def authenticate(params)
      @errors = []
      validate_admin_params(params)
      raise ValidationError, join_errors(@errors) if @errors.present?
      admin = find_by_email(params[:email])
      unless admin and admin.authenticate(params[:password])
        raise AuthorizationError, I18n.t('las.errors.admin_authorization.invalid')
      end
      admin
    end

    private

    def join_errors(errored_message_ids)
      errored_message_ids.join(Settings[:error][:seperate])
    end
  end
end
