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

  # GET /skill_profiles/1/edit
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

  # PATCH/PUT /skill_profiles/1
  # PATCH/PUT /skill_profiles/1.json
  def update
    respond_to do |format|
      if @skill_profile.update(skill_profile_params)
        format.html { redirect_to @skill_profile, notice: 'Skill profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @skill_profile }
      else
        format.html { render :edit }
        format.json { render json: @skill_profile.errors, status: :unprocessable_entity }
      end
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
    @skill_profile = SkillProfile.find(params[:id])
  end

  def skill_profile_params
    params.require(:article).permit(:title, :content)
  end

end
