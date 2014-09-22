class SkillProfilesController < ApplicationController
  include SessionAction
  before_action :session_required
  before_action :set_article,      only: [:show, :edit, :update]
  before_action :authorize_edit,   only: [:edit, :update]

  def index
    @profiles = SkillProfile.latest
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
      SkillProfile.rewrite(@article, article_params, current_user)
      redirect_to skill_profiles_url
    rescue ValidationError => e
      flash.now[:alert] = SkillProfile.format_error_message(e.message)
      render :edit
    end
  end

  def comment
    begin
      return render_403 unless Cert::Params.numeric?(params[:article_id])
      @article = Article.find_by(id: params[:article_id]) # @article is used to #show view
      Comment.submit(comment_params, params[:article_id], session[:id])
    rescue ValidationError => e
      flash.now[:alert] = Flash.format_error_message(e.message)
    end
    render :show
  end

  def search
    @profiles = SkillProfile.search(params)
    render :index
  end

  private

  def set_article
    return render_404 unless Cert::Params.numeric?(params[:id])
    @article = SkillProfile.find_by(id: params[:id]).article
  end

  def authorize_edit
    unless @article.skill_profile.user_id == session[:id]
      render_403
    end
  end

  def article_params 
    params.require(:article).permit(:title, :content)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
