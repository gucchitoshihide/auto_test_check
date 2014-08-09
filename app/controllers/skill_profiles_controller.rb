class SkillProfilesController < ApplicationController
  before_action :set_skill_profile, only: [:show, :edit, :update, :destroy]

  def index
  end

  # GET /skill_profiles/1
  # GET /skill_profiles/1.json
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

  # DELETE /skill_profiles/1
  # DELETE /skill_profiles/1.json
  def destroy
    @skill_profile.destroy
    respond_to do |format|
      format.html { redirect_to skill_profiles_url, notice: 'Skill profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_skill_profile
    @profile = Article.find(params[:id])
  end

  def skill_profile_params
    params.require(:article).permit(:title, :content)
  end

end
