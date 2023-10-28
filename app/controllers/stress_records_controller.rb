class StressRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stress_record, only: %i[show edit update destroy set_session]
  before_action :set_date_params, only: [:index]
  before_action :set_range, only: [:index]
  before_action :set_stress_reliefs, only: %i[new edit]

  def index
    set_weekly_or_monthly_dates
    # 選択した日付範囲に基づいて、ストレスレコードを取得
    @stress_records = current_user.stress_records.for_date_range(@start_date, @end_date)
    @sorted_stress_records = @stress_records.order(stress_relief_date: :asc)
    # グラフ表示のためのデータを取得
    @data = StressRecord.get_data_for_range(@stress_records.where(performed: true), @range, @start_date)
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

  def set_weekly_or_monthly_dates
    # 選択された年と月に基づき、その月の各週の開始日と終了日を計算
    @weeks = StressRecord.calculate_weeks_for_month(@selected_year, @selected_month)

    # 表示範囲に応じて週別または月別の日付を設定
    @range == 'week' ? set_weekly_dates : set_monthly_dates
  end

  def set_weekly_dates
    # ユーザーの入力から週番号を取得、存在しない場合は現在の日付が所属する週をデフォルト値として使用
    determine_week_number
    # 週番号が1未満または総週数を超える場合は、週番号を1に設定
    @week_number = 1 if @week_number < 1 || @week_number > @weeks.length
    # 選択した週の開始日と終了日を特定
    @start_date = @weeks[@week_number - 1][:start].beginning_of_day
    @end_date = @weeks[@week_number - 1][:end].end_of_day
  end

  def set_monthly_dates
    # 選択した月の開始日と終了日を特定
    @start_date = Date.new(@selected_year, @selected_month, 1).beginning_of_day
    @end_date = @start_date.end_of_month.end_of_day
  end

  def determine_week_number
    @week_number = if params[:week_number].present?
                     params[:week_number].to_i
                   else
                     StressRecord.find_current_week_number(@weeks, Time.zone.today)
                   end
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
