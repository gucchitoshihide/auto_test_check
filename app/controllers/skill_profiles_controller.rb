class SkillProfilesController < ApplicationController
  before_action :set_skill_profile, only: [:show, :edit, :update, :destroy]

  # GET /skill_profiles
  # GET /skill_profiles.json
  def index
    @skill_profiles = SkillProfile.all
  end

  # GET /skill_profiles/1
  # GET /skill_profiles/1.json
  def show
  end

  # GET /skill_profiles/new
  def new
    @skill_profile = SkillProfile.new
  end

  # GET /skill_profiles/1/edit
  def edit
  end

  # POST /skill_profiles
  # POST /skill_profiles.json
  def create
    @skill_profile = SkillProfile.new(skill_profile_params)

    respond_to do |format|
      if @skill_profile.save
        format.html { redirect_to @skill_profile, notice: 'Skill profile was successfully created.' }
        format.json { render :show, status: :created, location: @skill_profile }
      else
        format.html { render :new }
        format.json { render json: @skill_profile.errors, status: :unprocessable_entity }
      end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_skill_profile
      @skill_profile = SkillProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skill_profile_params
      params.require(:skill_profile).permit(:profile_id, :user_id)
    end
end
