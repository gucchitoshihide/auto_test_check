class SkillProfilesController < ApplicationController
  include SessionAction
  before_action :session_required
  before_action :set_article,    only: [:show, :edit, :update]
  before_action :authorize_edit, only: [:edit, :update]

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    begin
      SkillProfile.submit(article_params, session[:id])
      redirect_to skill_profiles_url
    rescue ValidationError => e
      flash.now[:alert] = SkillProfile.format_error_message(e.message)
      render :new
    end
  end

  def update
    begin
      SkillProfile.rewrite(@article, article_params)
      redirect_to skill_profiles_url
    rescue ValidationError => e
      flash.now[:alert] = SkillProfile.format_error_message(e.message)
      render :edit
    end
  end

  # Implemented for future
  def destroy
    SkillProfile.throw_away(@article)
    redirect_to skill_profiles_url, notice: 'skill_profile was successfully destroyed'
  end

  def comment
    begin
      Comment.submit(comment_params, params[:article_id], session[:id])
      redirect_to skill_profile_path(id: params[:article_id])
    rescue ValidationError => e
      flash.now[:alert] = e.message
      redirect_to root_path
    end
  end

  private

  def set_article
    @article = SkillProfile.find_by(id: params[:id]).article
  end

  def authorize_edit
    unless @article.skill_profile.user_id == session[:id]
      redirect_to root_path
    end
  end

  def article_params 
    params.require(:article).permit(:title, :content)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
