class WeekReportsController < ApplicationController
  before_action :set_week_report, only: [:show, :edit, :update, :destroy]

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
    @week_report.destroy
    respond_to do |format|
      format.html { redirect_to week_reports_url, notice: 'Week report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_week_report
      @report = Report.find_by(id: params[:id])
    end

    def week_report_params
      params.require(:report).permit(:title, :content)
    end
end
