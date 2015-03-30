class NaicsCodesController < ApplicationController
  before_action :set_naics_code, only: [:show, :edit, :update, :destroy]

  # GET /naics_codes
  # GET /naics_codes.json
  def index
    @naics_codes = NaicsCode.all
  end

  # GET /naics_codes/1
  # GET /naics_codes/1.json
  def show
  end

  # GET /naics_codes/new
  def new
    @naics_code = NaicsCode.new
  end

  # GET /naics_codes/1/edit
  def edit
  end

  # POST /naics_codes
  # POST /naics_codes.json
  def create
    @naics_code = NaicsCode.new(naics_code_params)

    respond_to do |format|
      if @naics_code.save
        format.html { redirect_to @naics_code, notice: 'Naics code was successfully created.' }
        format.json { render action: 'show', status: :created, location: @naics_code }
      else
        format.html { render action: 'new' }
        format.json { render json: @naics_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /naics_codes/1
  # PATCH/PUT /naics_codes/1.json
  def update
    respond_to do |format|
      if @naics_code.update(naics_code_params)
        format.html { redirect_to @naics_code, notice: 'Naics code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @naics_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /naics_codes/1
  # DELETE /naics_codes/1.json
  def destroy
    @naics_code.destroy
    respond_to do |format|
      format.html { redirect_to naics_codes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_naics_code
      @naics_code = NaicsCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def naics_code_params
      params.require(:naics_code).permit(:name)
    end
end
