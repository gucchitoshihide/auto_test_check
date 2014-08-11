class SkillProfilesController < ApplicationController
  include SesssionAction
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
      SkillProfile.submit(skill_profile_params)
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

  private

  def set_skill_profile
    @profile = Article.find(params[:id])
  end

  def skill_profile_params
    params.require(:article).permit(:title, :content)
  end

end
