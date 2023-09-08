class StressReliefsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_stress_relief, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  # GET /stress_reliefs or /stress_reliefs.json
  def index
    # @stress_reliefs = StressRelief.all
    # @stress_reliefs = StressRelief.preload(:user, :likes, :tags)
    @stress_reliefs = StressRelief.preload(:user, :tags)
    # @stress_reliefs = StressRelief.includes(:user, :likes, :tags).all
  end

  # GET /stress_reliefs/1 or /stress_reliefs/1.json
  def show
  end

  # GET /stress_reliefs/new
  def new
    @stress_relief = StressRelief.new
    @stress_relief.difficulty ||= StressRelief::DEFAULT_DIFFICULTY
  end

  # GET /stress_reliefs/1/edit
  def edit
  end

  # POST /stress_reliefs or /stress_reliefs.json
  def create
    @stress_relief = current_user.stress_reliefs.build(stress_relief_params)

    if @stress_relief.save
      redirect_to stress_relief_path(@stress_relief), notice: "Stress relief was successfully created."
    else
      render :new
    end
    # @stress_relief = StressRelief.new(stress_relief_params)

    # respond_to do |format|
    #   if @stress_relief.save
    #     format.html { redirect_to stress_relief_url(@stress_relief), notice: "Stress relief was successfully created." }
    #     format.json { render :show, status: :created, location: @stress_relief }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @stress_relief.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /stress_reliefs/1 or /stress_reliefs/1.json
  def update
    if @stress_relief.update(stress_relief_params)
      redirect_to stress_relief_path(@stress_relief), notice: "Stress relief was successfully updated." # 変更点
    else
      render :edit
    end
    # respond_to do |format|
    #   if @stress_relief.update(stress_relief_params)
    #     format.html { redirect_to stress_relief_url(@stress_relief), notice: "Stress relief was successfully updated." }
    #     format.json { render :show, status: :ok, location: @stress_relief }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @stress_relief.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /stress_reliefs/1 or /stress_reliefs/1.json
  def destroy
    @stress_relief.destroy

    redirect_to stress_reliefs_path, notice: "Stress relief was successfully destroyed."

    # respond_to do |format|
    #   format.html { redirect_to stress_reliefs_url, notice: "Stress relief was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stress_relief
      # @stress_relief = StressRelief.find(params[:id])
      # @stress_relief = StressRelief.preload(:user, :likes, :tags).find(params[:id])
      if action_name == 'edit'
        @stress_relief = StressRelief.preload(:tags).find(params[:id])
      else
        @stress_relief = StressRelief.preload(:user, :likes, :tags).find(params[:id])
      end
    end

    def ensure_correct_user
      redirect_to stress_reliefs_path, alert: "Not authorized" unless @stress_relief.user_id == current_user.id
    end

    # Only allow a list of trusted parameters through.
    def stress_relief_params
      params.require(:stress_relief).permit(:title, :detail, :difficulty, :tag_names)
    end
end
