class WeekReportsController < ApplicationController
  before_action :prepare_week_report, only: [:show, :edit, :update, :destroy]
  before_action :check_redirection, only: [:comment]

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
      WeekReport.submit(week_report_params)
      redirect_to week_reports_url
    rescue SystemError
      flash.now[:alert] = 'System Error happened. Try again'
      render :new
    rescue ValidationError => e
      flash.now[:alert] = WeekReport.format_error_message(e.message)
      render :new
    end
  end

  def update
    begin
      WeekReport.rewrite(@report, week_report_params)
      redirect_to week_reports_url
    rescue ValidationError => e
      flash.now[:alert] = WeekReport.format_error_message(e.message)
      render :edit
    end
  end

  def destroy
    WeekReport.throw_away(@report)
    redirect_to week_reports_url, notice: 'Week report was successfully destroyed.'
  end

  def comment
    begin
      binding.pry
      Comment.submit(comment_params, params[:article_id])
      redirect_to week_report_path(id: params[:article_id])
    rescue SystemError => e
      flash.now[:alert] = e.message
      redirect_to root_path
    end
  end

  private

  def prepare_week_report
    @report = Article.find_by(id: params[:id])
  end

  def week_report_params
    params.require(:article).permit(:title, :content)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def check_redirection
    unless Cert::Redirection.from?(Settings[:back][:controller][:comment][:cert_redirection], request.referer)
      redirect_to root_path
    end
  end
end
