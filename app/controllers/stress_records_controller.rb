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
    @stress_record.stress_relief_date = Time.zone.today
  end

  def edit
  end

  def create
    @stress_record = current_user.stress_records.new(stress_record_params)

    if @stress_record.save
      redirect_to stress_records_path, notice: t('stress_records.create.success')
    else
      flash.now[:alert] = t('stress_records.create.error')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @stress_record.update(stress_record_params)
      redirect_to stress_records_path, notice: t('stress_records.update.success')
    else
      flash.now[:alert] = t('stress_records.update.error')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @stress_record.destroy
    redirect_to stress_records_url, notice: t('stress_records.destroy.success')
  end

  private

    def set_stress_record
      @stress_record = StressRecord.find(params[:id])
    end

    def stress_record_params
      params.require(:stress_record).permit(:stress_relief_date, :title, :detail, :before_stress_level, :after_stress_level, :impression)
    end
end
