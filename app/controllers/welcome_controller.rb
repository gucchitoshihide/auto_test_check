class WelcomeController < ApplicationController
  include SessionAction
  before_action :session_required

  def show
  end
end
