class StressRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stress_record, only: %i[show edit update destroy set_session]
  before_action :set_date_params, only: [:index]
  before_action :set_range, only: [:index]
  before_action :set_stress_reliefs, only: %i[new edit]

  def index
    calculate_weeks_and_dates
    fetch_stress_records
  end

  def show; end

  def new
    @stress_record = StressRecord.new
    @stress_record.stress_relief_date = Time.zone.today

    return unless permitted_params[:stress_relief_id]

    stress_relief = StressRelief.find(permitted_params[:stress_relief_id])
    @stress_record.title = stress_relief.title
    @stress_record.detail = stress_relief.detail
  end

  def edit; end

  def create
    @stress_record = current_user.stress_records.new(stress_record_params)

    if @stress_record.save
      redirect_to stress_record_path(@stress_record), notice: t('.success')
    else
      set_stress_reliefs
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

  def search
    @search_results = StressRelief.where('title LIKE ?', "%#{params[:query]}%").limit(5)
  end

  def set_session
    session[:shared_title] = @stress_record.title
    session[:shared_detail] = @stress_record.detail
    redirect_to new_stress_relief_path
  end

  private

  def set_date_params
    # 現在の日付を取得
    today = Time.zone.today
    # ユーザーが選択した年と月を取得、または現在の年と月をデフォルトとして使用
    @selected_year = (params[:year] || today.year).to_i
    @selected_month = (params[:month] || today.month).to_i
  end

  def set_range
    # 表示範囲（週または月）を取得し、セッションに保存
    @range = if %w[week month].include?(params[:range])
               params[:range]
             else
               session[:range] || 'week'
             end
    session[:range] = @range
  end

  # 週と日付の範囲を計算
  def calculate_weeks_and_dates
    @weeks = StressRecord.calculate_weeks_for_month(@selected_year, @selected_month)
    @week_number = determine_week_number
    @start_date, @end_date = StressRecord.calculate_date_range(@selected_year,
                                                               @selected_month, @range, @week_number, @weeks)
  end

  # 週番号の決定
  def determine_week_number
    if params[:week_number].present?
      week_number = params[:week_number].to_i
      # 週番号がその月の週の数を超えている場合、最初の週をリセット
      week_number <= @weeks.length ? week_number : StressRecord::FIRST_WEEK_NUMBER
    else
      StressRecord.find_current_week_number(@weeks, Time.zone.today)
    end
  end

  # ストレスレコードの取得
  def fetch_stress_records
    # テーブル表示用のデータ取得
    @stress_records = StressRecord.records_for_user_and_date_range(current_user, @start_date, @end_date)
                                  .order(stress_relief_date: :asc)
    # グラフ表示用のデータ取得
    @data = StressRecord.get_stress_data_for_user(current_user, @range, @start_date, @end_date)
  end

  def set_stress_reliefs
    @stress_reliefs = if params[:query].present?
                        StressRelief.preload(:user, :tags).order(created_at: :desc).page(params[:page])
                                    .where('title LIKE ?', "%#{params[:query]}%")
                      else
                        StressRelief.preload(:user, :tags).order(created_at: :desc).page(params[:page])
                      end
  end

  def permitted_params
    params.permit(:stress_relief_id)
  end

  def set_stress_record
    @stress_record = current_user.stress_records.find(params[:id])
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
