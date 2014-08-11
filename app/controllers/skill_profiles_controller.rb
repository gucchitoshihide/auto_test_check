class SkillProfilesController < ApplicationController
  include SessionAction
  before_action :session_required
  before_action :set_skill_profile, only: [:show, :edit, :update, :destroy]

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
      SkillProfile.submit(skill_profile_params, session[:id])
      redirect_to skill_profiles_url
    rescue ValidationError => e
      flash.now[:alert] = SkillProfile.format_error_message(e.message)
      render :new
    end
  end

  def update
    begin
      SkillProfile.rewrite(@profile, skill_profile_params)
      redirect_to skill_profiles_url
    rescue ValidationError => e
      flash.now[:alert] = SkillProfile.format_error_message(e.message)
      render :edit
    end
  end

  def destroy
    SkillProfile.throw_away(@profile)
    redirect_to skill_profiles_url, notice: 'skill_profile was successfully destroyed'
  end

  def comment
    begin
      Comment.submit(comment_params, params[:article_id], session[:id])
      redirect_to skill_profile_path(id: params[:article_id])
    rescue SystemError => e
      flash.now[:alert] = e.message
      redirect_to root_path
    end
  end

  private

  def set_skill_profile
    @profile = Article.find(params[:id])
  end

  def skill_profile_params
    params.require(:article).permit(:title, :content)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
