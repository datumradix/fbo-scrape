class EvaluationCodesController < ApplicationController
  before_action :set_evaluation_code, only: [:show, :edit, :update, :destroy]

  # GET /evaluation_codes
  # GET /evaluation_codes.json
  def index
    @evaluation_codes = EvaluationCode.all
  end

  # GET /evaluation_codes/1
  # GET /evaluation_codes/1.json
  def show
  end

  # GET /evaluation_codes/new
  def new
    @evaluation_code = EvaluationCode.new
  end

  # GET /evaluation_codes/1/edit
  def edit
  end

  # POST /evaluation_codes
  # POST /evaluation_codes.json
  def create
    @evaluation_code = EvaluationCode.new(evaluation_code_params)

    respond_to do |format|
      if @evaluation_code.save
        format.html { redirect_to @evaluation_code, notice: 'Evaluation code was successfully created.' }
        format.json { render action: 'show', status: :created, location: @evaluation_code }
      else
        format.html { render action: 'new' }
        format.json { render json: @evaluation_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /evaluation_codes/1
  # PATCH/PUT /evaluation_codes/1.json
  def update
    respond_to do |format|
      if @evaluation_code.update(evaluation_code_params)
        format.html { redirect_to @evaluation_code, notice: 'Evaluation code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @evaluation_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluation_codes/1
  # DELETE /evaluation_codes/1.json
  def destroy
    @evaluation_code.destroy
    respond_to do |format|
      format.html { redirect_to evaluation_codes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation_code
      @evaluation_code = EvaluationCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evaluation_code_params
      params.require(:evaluation_code).permit(:name)
    end
end
