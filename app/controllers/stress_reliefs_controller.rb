class StressReliefsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_stress_relief, only: %i[show edit update destroy]
  before_action :ensure_correct_user, only: %i[edit update destroy]

  def index
    @stress_reliefs = StressRelief.preload(:user, :tags).order(created_at: :desc).page(params[:page])
  end

  def show; end

  def new
    @stress_relief = StressRelief.new
    @stress_relief.difficulty ||= StressRelief::DEFAULT_DIFFICULTY
  end

  def edit; end

  def create
    @stress_relief = current_user.stress_reliefs.build(stress_relief_params)

    if @stress_relief.save
      redirect_to stress_relief_path(@stress_relief), notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @stress_relief.update(stress_relief_params)
      redirect_to stress_relief_path(@stress_relief), notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @stress_relief.destroy
    redirect_to stress_reliefs_path, notice: t('.success')
  end

  private

  def set_stress_relief
    preload_associations = [:tags]
    @stress_relief = if action_name == 'edit'
                       StressRelief.preload(*preload_associations).find(params[:id])
                     elsif user_signed_in?
                       StressRelief.preload(:user, :likes, *preload_associations).find(params[:id])
                     else
                       StressRelief.preload(:user, *preload_associations).find(params[:id])
                     end
  end

  def ensure_correct_user
    is_correct_user = @stress_relief.user_id == current_user.id
    redirect_to stress_reliefs_path, alert: t('stress_reliefs.unauthorized') unless is_correct_user
  end

  def stress_relief_params
    params.require(:stress_relief).permit(:title, :detail, :difficulty, :tag_names)
  end
end
