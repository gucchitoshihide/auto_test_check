require 'cert'

class CommentsController < ApplicationController
  before_action :check_redirection, only: [:create]
  before_action :set_comment, only: [:create]

  def create
    Comment.submit(params[:content], request.referer)
  end

  private

  def check_redirection
    unless Cert::Redirection.from?(Settings[:back][:controller][:comment][:cert_redirection], request.referer)
      redirect_to root_path
    end
  end

  def set_comment
    params.require(:comment).permit(:content)
  end
end
