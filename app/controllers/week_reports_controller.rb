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
      redirect_to :index
    rescue ValidationError => e
      flash[:alert] = WeekReport.format_error_message(e.message)
      render :new
    end
  end

  def update
    respond_to do |format|
      if @week_report.update(week_report_params)
        format.html { redirect_to @week_report, notice: 'Week report was successfully updated.' }
        format.json { render :show, status: :ok, location: @week_report }
      else
        format.html { render :edit }
        format.json { render json: @week_report.errors, status: :unprocessable_entity }
      end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_week_report
      @week_report = WeekReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def week_report_params
      params.require(:report).permit(:title, :content)
    end
end
