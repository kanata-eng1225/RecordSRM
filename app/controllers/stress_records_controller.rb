class StressRecordsController < ApplicationController
  before_action :set_stress_record, only: %i[ show edit update destroy ]

  # GET /stress_records or /stress_records.json
  def index
    @stress_records = StressRecord.all
  end

  # GET /stress_records/1 or /stress_records/1.json
  def show
  end

  # GET /stress_records/new
  def new
    @stress_record = StressRecord.new
    @stress_record.stress_relief_date = Date.today
  end

  # GET /stress_records/1/edit
  def edit
  end

  # POST /stress_records or /stress_records.json
  def create
    @stress_record = current_user.stress_records.new(stress_record_params)
    # @stress_record = StressRecord.new(stress_record_params)

    if @stress_record.save
      redirect_to stress_record_url(@stress_record), notice: "Stress record was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
    # respond_to do |format|
    #   if @stress_record.save
    #     format.html { redirect_to stress_record_url(@stress_record), notice: "Stress record was successfully created." }
    #     format.json { render :show, status: :created, location: @stress_record }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @stress_record.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /stress_records/1 or /stress_records/1.json
  def update
    if @stress_record.update(stress_record_params)
      redirect_to stress_record_url(@stress_record), notice: "Stress record was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
    # respond_to do |format|
    #   if @stress_record.update(stress_record_params)
    #     format.html { redirect_to stress_record_url(@stress_record), notice: "Stress record was successfully updated." }
    #     format.json { render :show, status: :ok, location: @stress_record }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @stress_record.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /stress_records/1 or /stress_records/1.json
  def destroy
    @stress_record.destroy
    redirect_to stress_records_url, notice: "Stress record was successfully destroyed."
    # respond_to do |format|
    #   format.html { redirect_to stress_records_url, notice: "Stress record was successfully destroyed." }
    #   format.json { head :no_content }
    # end
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
