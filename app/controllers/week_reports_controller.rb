class WeekReportsController < ApplicationController
  before_action :set_week_report, only: [:show, :edit, :update, :destroy]

  def index
    @week_reports = WeekReport.all
  end

  def show
  end

  def new
    @week_report = WeekReport.new
  end

  def edit
  end

  def create
    @week_report = WeekReport.new(week_report_params)

    respond_to do |format|
      if @week_report.save
        format.html { redirect_to @week_report, notice: 'Week report was successfully created.' }
        format.json { render :show, status: :created, location: @week_report }
      else
        format.html { render :new }
        format.json { render json: @week_report.errors, status: :unprocessable_entity }
      end
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
      params.require(:week_report).permit(:user_id, :report_id)
    end
end
