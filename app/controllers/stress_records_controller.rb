class StressRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stress_record, only: %i[show edit update destroy]

  def index
    # 現在の日付を取得
    today = Time.zone.today

    # ユーザーが選択した年と月を取得、または現在の年と月をデフォルトとして使用
    @selected_year = (params[:year] || today.year).to_i
    @selected_month = (params[:month] || today.month).to_i

    # 表示範囲（週または月）を取得し、セッションに保存
    @range = params[:range] || session[:range] || 'week'
    session[:range] = @range

    # 選択した年月に基づいて各週の開始日と終了日を計算
    @weeks = StressRecord.calculate_weeks_for_month(@selected_year, @selected_month)

    if @range == 'week'
      # ユーザーが選択した週番号を取得、または今日の日付が含まれる週をデフォルトとして使用
      @week_number = params[:week_number].to_i || StressRecord.find_current_week_number(@weeks, today)
      # 週番号が1未満または総週数を超える場合は、週番号を1に設定
      @week_number = 1 if @week_number < 1 || @week_number > @weeks.length

      # 選択した週の開始日と終了日を特定
      start_date = @weeks[@week_number - 1][:start].beginning_of_day
      end_date = @weeks[@week_number - 1][:end].end_of_day
    else
      # 選択した月の開始日と終了日を特定
      start_date = Date.new(@selected_year, @selected_month, 1).beginning_of_day
      end_date = start_date.end_of_month.end_of_day
    end

    # 選択した日付範囲に基づいて、ストレスレコードを取得
    @stress_records = StressRecord.records_for_date_range(current_user, start_date, end_date)
    @sorted_stress_records = @stress_records.order(stress_relief_date: :asc)

    # グラフ表示のためのデータを取得
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
