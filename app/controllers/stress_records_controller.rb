class StressRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stress_record, only: %i[show edit update destroy]

  def index
    # 現在の日付を取得
    today = Time.zone.today

    # ユーザーが選択した年と月、または現在の年と月を取得
    @selected_year = (params[:year] || today.year).to_i
    @selected_month = (params[:month] || today.month).to_i

    # 表示範囲（週または月）を取得して、セッションに表示範囲を保存
    @range = params[:range] || session[:range] || 'week'
    session[:range] = @range

    # 選択された月の最初の日と最後の日を取得
    first_day_of_month = Date.new(@selected_year, @selected_month, 1)
    last_day_of_month = first_day_of_month.end_of_month

    # 選択された月の各週の開始日と終了日を計算
    @weeks = []
    start_day = first_day_of_month
    while start_day <= last_day_of_month
      end_day = [start_day.end_of_week(:sunday), last_day_of_month].min
      @weeks << { start: start_day, end: end_day }
      start_day = end_day + 1.day
    end

    # 表示範囲が週の場合の処理
    if @range == 'week'
      if params[:week_number]
        @week_number = params[:week_number].to_i
      else
        # 今日の日付が含まれる週を見つける
        @week_number = @weeks.find_index { |week| week[:start] <= today && week[:end] >= today } + 1
      end
      # @week_numberが1未満または@weeksの長さを超える場合は、@week_numberを1に設定
      @week_number = 1 if @week_number < 1 || @week_number > @weeks.length

      # 選択された週の開始日と終了日を計算
      start_date = @weeks[@week_number - 1][:start].beginning_of_day
      end_date = @weeks[@week_number - 1][:end].end_of_day
    else # 表示範囲が月の場合の処理
      start_date = first_day_of_month.beginning_of_day
      end_date = last_day_of_month.end_of_day
    end

    # 選択された範囲のストレスレコードを取得
    @stress_records = current_user.stress_records.where(stress_relief_date: start_date..end_date)
    @sorted_stress_records = @stress_records.order(stress_relief_date: :asc)

    # グラフデータの取得
    @data = StressRecord.get_data_for_range(@stress_records.where(performed: true), @range, start_date)
  end

  def show; end

  def new
    @stress_record = StressRecord.new
    @stress_record.stress_relief_date = Time.zone.today
    @stress_reliefs = StressRelief.preload(:user, :tags).order(created_at: :desc).page(params[:page])
  end

  def edit
    @stress_reliefs = StressRelief.preload(:user, :tags).order(created_at: :desc).page(params[:page])
  end

  def create
    @stress_record = current_user.stress_records.new(stress_record_params)

    if @stress_record.save
      redirect_to stress_record_path(@stress_record), notice: t('.success')
    else
      flash.now[:alert] = t('.error')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @stress_record.update(stress_record_params)
      redirect_to stress_record_path(@stress_record), notice: t('.success')
    else
      flash.now[:alert] = t('.error')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @stress_record.destroy
    redirect_to stress_records_url, notice: t('.success')
  end

  private

  def set_stress_record
    @stress_record = StressRecord.find(params[:id])
  end

  def stress_record_params
    params.require(:stress_record).permit(
      :stress_relief_date,
      :title,
      :detail,
      :before_stress_level,
      :after_stress_level,
      :impression,
      :performed
    )
  end
end
