class StressRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stress_record, only: %i[ show edit update destroy ]

  def index
    @stress_records = current_user.stress_records
    @range = ["week", "month"].include?(params[:range]) ? params[:range] : "week"
    @data = StressRecord.get_data_for_range(@stress_records, @range)
  end

  def show
  end

  def new
    @stress_record = StressRecord.new
    @stress_record.stress_relief_date = Date.today
  end

  def edit
  end

  def create
    @stress_record = current_user.stress_records.new(stress_record_params)

    if @stress_record.save
      redirect_to stress_records_path, notice: "Stress record was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @stress_record.update(stress_record_params)
      redirect_to stress_records_path, notice: "Stress record was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @stress_record.destroy
    redirect_to stress_records_url, notice: "Stress record was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stress_record
      @stress_record = StressRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stress_record_params
      params.require(:stress_record).permit(:stress_relief_date, :title, :detail, :before_stress_level, :after_stress_level, :impression)
    end
end
