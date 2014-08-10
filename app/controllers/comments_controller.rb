class CommentsController < ApplicationController
  before_action :check_redirection
  before_action :set_comment, only: [:create]

  def create
    
  end

  private

  def check_redirection

  end

  def set_comment
    params.require(:comment).permit(:content)
  end
end
