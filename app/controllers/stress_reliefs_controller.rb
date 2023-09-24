class StressReliefsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_stress_relief, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @stress_reliefs = StressRelief.preload(:user, :tags).order(created_at: :desc).page(params[:page])
  end

  def show
  end

  def new
    @stress_relief = StressRelief.new
    @stress_relief.difficulty ||= StressRelief::DEFAULT_DIFFICULTY
  end

  def edit
  end

  def create
    @stress_relief = current_user.stress_reliefs.build(stress_relief_params)

    if @stress_relief.save
      redirect_to stress_relief_path(@stress_relief), notice: t('stress_reliefs.create.success')
    else
      flash.now[:alert] = t('stress_reliefs.create.failure')
      render :new
    end
  end

  def update
    if @stress_relief.update(stress_relief_params)
      redirect_to stress_relief_path(@stress_relief), notice: t('stress_reliefs.update.success')
    else
      flash.now[:alert] = t('stress_reliefs.update.failure')
      render :edit
    end
  end

  def destroy
    @stress_relief.destroy
    redirect_to stress_reliefs_path, notice: t('stress_reliefs.destroy.success')
  end

  private

    def set_stress_relief
      if action_name == 'edit'
        @stress_relief = StressRelief.preload(:tags).find(params[:id])
      else
        @stress_relief = StressRelief.preload(:user, :likes, :tags).find(params[:id])
      end
    end

    def ensure_correct_user
      redirect_to stress_reliefs_path, alert: t('stress_reliefs.unauthorized') unless @stress_relief.user_id == current_user.id
    end

    def stress_relief_params
      params.require(:stress_relief).permit(:title, :detail, :difficulty, :tag_names)
    end
end
