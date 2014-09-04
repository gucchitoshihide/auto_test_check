class SettingsController < ApplicationController
  include SessionAction
  before_action :session_required
  before_action :prohibit_editing_other, only: [:edit]
  before_action :set_user, only: [:edit]

  def edit
  end

  def update
    render 'edit'
  end

  private

  def prohibit_editing_other
    if session[:id] != params[:id].to_i
      render 'edit'
    end
  end

  def set_user
    @user = User.find_by_id(session[:id])
  end
end
